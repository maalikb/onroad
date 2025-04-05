import strawberry
from typing import Optional, List
from core.models import Make, VehicleType, Vehicle, Variant, VariantColor
from django.db import transaction
from core.utils.exception import parse_exception
import openai
from openai.types.chat import (
    ChatCompletionSystemMessageParam,
    ChatCompletionUserMessageParam,
)
import requests
from bs4 import BeautifulSoup
from django.core.cache import cache
from django.utils import timezone
from datetime import timedelta
from core.types import BaseResponse

# Rate limiting constants
RATE_LIMIT_KEY = "openai_rate_limit"
RATE_LIMIT_WINDOW = 60  # 1 minute
MAX_REQUESTS_PER_WINDOW = 3  # Maximum requests per minute


def check_rate_limit():
    """Check if we're within rate limits"""
    current_time = timezone.now()
    window_start = current_time - timedelta(seconds=RATE_LIMIT_WINDOW)

    # Get existing requests in the window
    requests_in_window = cache.get(RATE_LIMIT_KEY, [])
    requests_in_window = [t for t in requests_in_window if t > window_start]

    if len(requests_in_window) >= MAX_REQUESTS_PER_WINDOW:
        return False

    # Add current request
    requests_in_window.append(current_time)
    cache.set(RATE_LIMIT_KEY, requests_in_window, RATE_LIMIT_WINDOW)
    return True


@strawberry.type
class CreateVehicleResponse(BaseResponse):
    success: bool
    message: str
    vehicle_id: Optional[str] = None


@strawberry.input
class VehicleContext:
    text: Optional[str] = None
    urls: Optional[List[str]] = None
    files: Optional[List[str]] = None


def search_web(query: str) -> str:
    """Search the web for vehicle information"""
    try:
        # You would need to implement actual web search here
        # This is a placeholder for demonstration
        search_url = f"https://www.google.com/search?q={query}"
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        }
        response = requests.get(search_url, headers=headers)
        soup = BeautifulSoup(response.text, "html.parser")
        # Extract relevant information from search results
        return soup.get_text()[:2000]  # Limit text length
    except Exception as e:
        parse_exception(e)
        return ""


def extract_text_from_url(url: str) -> str:
    """Extract text content from a URL"""
    try:
        response = requests.get(url)
        soup = BeautifulSoup(response.text, "html.parser")
        return soup.get_text()
    except Exception as e:
        parse_exception(e)
        return ""


def parse_vehicle_info(
    vehicle_name: str, context: Optional[VehicleContext] = None
) -> dict:
    """Parse vehicle information using OpenAI and web search"""
    try:
        # Check rate limit
        if not check_rate_limit():
            raise Exception("Rate limit exceeded. Please try again later.")

        # Gather context from various sources
        context_text = ""

        # Add web search results
        web_search_results = search_web(
            f"{vehicle_name} specifications features colors"
        )
        context_text += f"\nWeb Search Results:\n{web_search_results}\n"

        # Add context from provided URLs
        if context and context.urls:
            for url in context.urls:
                url_text = extract_text_from_url(url)
                context_text += f"\nContent from {url}:\n{url_text}\n"

        # Add context from provided text
        if context and context.text:
            context_text += f"\nAdditional Context:\n{context.text}\n"

        # Add context from provided files
        if context and context.files:
            for file_path in context.files:
                try:
                    with open(file_path, "r") as f:
                        file_text = f.read()
                        context_text += f"\nContent from {file_path}:\n{file_text}\n"
                except Exception as e:
                    parse_exception(e)
                    continue

        # Prepare the prompt for OpenAI
        system_message: ChatCompletionSystemMessageParam = {
            "role": "system",
            "content": """You are a vehicle information parser. Extract detailed information about vehicles from various sources.
            Your task is to:
            1. Identify the make, model, year, and type
            2. Extract specifications (engine, transmission, fuel type, etc.)
            3. Identify available colors
            4. Extract any additional features or details
            5. Cross-reference information from multiple sources to ensure accuracy
            Return the information in a structured format.""",
        }

        user_message: ChatCompletionUserMessageParam = {
            "role": "user",
            "content": f"""Vehicle name: {vehicle_name}
            Context information:
            {context_text}
            
            Please provide a detailed analysis of this vehicle based on the available information.""",
        }

        # Use GPT-3.5-turbo for testing (cheaper and sufficient for testing)
        response = openai.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[system_message, user_message],
            temperature=0.3,
        )

        # Parse the response to extract vehicle details
        # This is a simplified example - you'll need to adjust based on your needs
        parsed_info = {
            "make": "Java",  # Example - replace with actual parsing
            "model": "42 FJ",
            "year": "2025",
            "type": "SUV",  # Example - replace with actual parsing
            "colors": ["Red", "Blue", "Black"],  # Example - replace with actual parsing
            "specifications": {
                "engine": "2.0L",
                "transmission": "Automatic",
                "fuel_type": "Petrol",
                "features": [
                    "Navigation",
                    "Bluetooth",
                    "Backup Camera",
                ],  # Example features
            },
        }
        return parsed_info
    except Exception as e:
        parse_exception(e)
        return {}  # Return empty dict instead of None to satisfy type checker


def create_vehicle(
    info, vehicle_name: str, context: Optional[VehicleContext] = None
) -> CreateVehicleResponse:
    try:
        with transaction.atomic():
            # Parse vehicle information using AI and context
            vehicle_info = parse_vehicle_info(vehicle_name, context)
            if not vehicle_info:
                return CreateVehicleResponse(
                    success=False,
                    message="Failed to parse vehicle information",
                    code=400,
                )

            # Create or get Make
            make, _ = Make.objects.get_or_create(
                name=vehicle_info["make"],
                defaults={
                    "code": vehicle_info["make"][:3].upper(),
                    "estb_year": None,  # You might want to add this to the AI parsing
                },
            )

            # Create or get VehicleType
            vehicle_type, _ = VehicleType.objects.get_or_create(
                name=vehicle_info["type"],
                defaults={
                    "category": "SUV",  # You might want to add this to the AI parsing
                    "code": vehicle_info["type"][:3].upper(),
                },
            )

            # Create Vehicle
            vehicle, _ = Vehicle.objects.get_or_create(
                make=make,
                vehicle_type=vehicle_type,
                name=vehicle_info["model"],
                defaults={
                    "description": f"New {vehicle_info['make']} {vehicle_info['model']} {vehicle_info['year']}",
                },
            )

            # Create or get Variant
            variant, _ = Variant.objects.get_or_create(
                vehicle=vehicle,
                name=f"{vehicle_info['model']} {vehicle_info['year']}",
                defaults={
                    "slug": f"{vehicle_info['make']}-{vehicle_info['model']}-{vehicle_info['year']}".lower().replace(
                        " ", "-"
                    ),
                    "launch_date": f"{vehicle_info['year']}-01-01",  # Default to Jan 1st of the year
                    "fuel_type": "PE",  # Example - replace with actual parsing
                    "transmission": "AUTO",  # Example - replace with actual parsing
                    "description": f"New {vehicle_info['make']} {vehicle_info['model']} {vehicle_info['year']}",
                    "specifications": vehicle_info["specifications"],
                },
            )

            # Create or get VariantColors
            for color_name in vehicle_info["colors"]:
                VariantColor.objects.get_or_create(
                    variant=variant,
                    name=color_name,
                    defaults={
                        "hex_code": None,  # You might want to add this to the AI parsing
                    },
                )

            return CreateVehicleResponse(
                success=True,
                message="Vehicle created successfully",
                vehicle_id=str(vehicle.id),
                code=200,
            )

    except Exception as e:
        parse_exception(e)
        return CreateVehicleResponse(
            success=False,
            message=str(e),
            code=400,
        )
