#!/bin/bash
# Check if a command-line argument was provided
if [ $# -eq 0 ]; then
  echo "Error: Please provide a string as a command-line argument."
  exit 1
fi

# Reverse each word in the string
reversed=""
for word in $1; do
  reversed="$reversed $(echo $word | rev)"
done

# Capitalize the first letter of the reversed string
lowercase_string="$(echo $reversed | tr '[:upper:]' '[:lower:]')"
first_letter="$(echo $lowercase_string | cut -c1 | tr '[:lower:]' '[:upper:]')"
rest_of_string="$(echo $lowercase_string | cut -c2-)"

capitalized_string="${first_letter}${rest_of_string}"

echo "$capitalized_string"
