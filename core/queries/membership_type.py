import strawberry
from core.types import BaseResponse
from core.models import User, UserPassKeys
from typing import List
from webauthn.helpers import bytes_to_base64url


@strawberry.type
class MemberType:
    type: str
    passkeys: List[str]


@strawberry.type
class MembershipTypeByEmailResponse(BaseResponse):
    data: MemberType
    pass


def membership_type_by_email(self, email: str) -> MembershipTypeByEmailResponse:
    try:
        user = User.objects.get(email=email)
        passkey_credentials_bytes = UserPassKeys.objects.filter(user=user).values_list(
            "credential_id", flat=True
        )
        passkeys = [
            bytes_to_base64url(passkey_credential)
            for passkey_credential in passkey_credentials_bytes
        ]
        return MembershipTypeByEmailResponse(
            success=True,
            message="User already exists",
            data=MemberType(type="RETURNING_USER", passkeys=passkeys),
            code=200,
        )

    except Exception as e:
        return MembershipTypeByEmailResponse(
            success=True,
            message="User does not exist",
            data=MemberType(type="NEW_USER", passkeys=[]),
            code=200,
        )
