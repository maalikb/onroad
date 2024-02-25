package main

import (
	"encoding/csv"
	"fmt"
	"os"

	"github.com/google/uuid"
)

func main() {
	// Open the users.csv file
	usersFile, err := os.Open("users.csv")
	if err != nil {
		panic(fmt.Sprintf("Failed to open users.csv: %v", err))
	}
	defer usersFile.Close()

	// Create the user_tokens.csv file
	tokensFile, err := os.Create("user_tokens.csv")
	if err != nil {
		panic(fmt.Sprintf("Failed to create user_tokens.csv: %v", err))
	}
	defer tokensFile.Close()

	usersReader := csv.NewReader(usersFile)
	tokensWriter := csv.NewWriter(tokensFile)

	// Skip the header row of the users.csv
	if _, err := usersReader.Read(); err != nil {
		panic(fmt.Sprintf("Failed to read header from users.csv: %v", err))
	}

	// Write the header row to user_tokens.csv
	header := []string{"created_at", "updated_at", "id", "token", "used", "expires_at", "type", "user_id", "client", "description"}
	if err := tokensWriter.Write(header); err != nil {
		panic(fmt.Sprintf("Failed to write header to user_tokens.csv: %v", err))
	}

	// Read each user from users.csv and generate 10 tokens for each
	for {
		record, err := usersReader.Read()
		if err != nil {
			break // Stop at EOF
		}

		userID := record[0] // Assuming the first column is user ID

		for i := 0; i < 10; i++ {
			tokenID := uuid.New().String()
			token := uuid.New().String()
			used := "false"
			tokenType := "VC"
			client := "web"

			tokenRecord := []string{"", "", tokenID, token, used, "", tokenType, userID, client, ""}
			if err := tokensWriter.Write(tokenRecord); err != nil {
				panic(fmt.Sprintf("Failed to write token record to user_tokens.csv: %v", err))
			}
		}
	}

	tokensWriter.Flush()
	if err := tokensWriter.Error(); err != nil {
		panic(fmt.Sprintf("Failed to flush to user_tokens.csv: %v", err))
	}
}
