#!/bin/bash
# Read the file name from command line argument
if [ $# -eq 0 ]; then
  echo "Error: Please provide file name."
  exit 1
fi
file=$1


# Convert all characters to lowercase and remove special characters
text=$(tr '[:upper:]' '[:lower:]' < "$file" | tr -s '[:punct:]' ' ')
# Count the frequency of each word
wordcount=$(echo "$text" | tr ' ' '\n' | sort | uniq -c | sort -nr)
# Print the results in descending order
echo "$wordcount"