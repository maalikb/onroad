package main

import (
	"encoding/csv"
	"os"

	"github.com/google/uuid"
)

func main() {
	// Open a file for writing
	file, err := os.Create("users.csv")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	// Write the header row
	header := []string{"id", "email", "is_active", "is_staff", "city_id", "email_verified", "has_contributed"}
	if err := writer.Write(header); err != nil {
		panic("Failed to write header to CSV file")
	}

	// Generate 10 million user records
	for i := 0; i < 10000000; i++ {
		id := uuid.New().String()
		email := id + "@maalik.dev"
		is_active := "true"
		is_staff := "false"
		city_id := "713b7600-4c05-48fc-86d1-31974c747ce3"
		email_verified := "true"
		has_contributed := "true"

		record := []string{id, email, is_active, is_staff, city_id, email_verified, has_contributed}
		if err := writer.Write(record); err != nil {
			panic("Failed to write record to CSV file")
		}
	}
}
