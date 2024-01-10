#!/bin/bash

# Set the initial date
current_date=$(date -jf "%Y-%m-%d" "2020-12-06" +"%Y-%m-%d")

# Create the 'new' directory if it doesn't exist
mkdir -p ./new

# Initialize a counter
counter=1

# Iterate through the PDF files, ordering them numerically
for file in $(ls payslip-*.pdf | sort -n -t '-' -k 2); do
    # Extract the number from the original file name
    number=$(echo "$file" | grep -o '[0-9]\+')

    # Increment the date by 14 days
    current_date=$(date -v+14d -jf "%Y-%m-%d" "$current_date" +"%Y-%m-%d")

    # Create the new file name with the incremented date, counter, and number
    new_file="./new/${current_date}-canva-payslip-${counter}-${number}.pdf"

    # Copy the original file to the new file name
    cp "$file" "$new_file"

    # Increment the counter
    ((counter++))

    # Print the actions for verification (optional)
    echo "Copied $file to $new_file"
done
