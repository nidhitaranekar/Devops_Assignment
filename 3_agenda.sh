#!/bin/bash

input_file="agenda.txt"

# Get the current date and the date for tomorrow
today=$(date +"%m/%d/%Y")
tomorrow=$(date -d "+1 day" +"%m/%d/%Y")

# Print the table header
printf "Current and next day meetings:\n"
printf "%-20s %-20s %-30s\n" "Date" "Title" "Description"

while read -r line; do
  if [[ $line =~ ^(Today|Tomorrow|[0-9]+[-/ ][0-9]+[-/ ][0-9]{2,4}|[0-9]+ [A-Za-z]+([ ]+[0-9]{4})?) ]]; then
    if [[ $line == "Today" ]]; then
      current_date=$today
    elif [[ $line == "Tomorrow" ]]; then
      current_date=$tomorrow
    else
      current_date=$(date -d "$line" +"%m/%d/%Y" 2>/dev/null || date -d "$(echo $line | sed 's/[-/]/ /g')" +"%m/%d/%Y" 2>/dev/null)
    fi
  else
    if [[ $current_date == $today || $current_date == $tomorrow ]]; then
      printf "%-20s %-20s %-30s\n" "$current_date" "$(echo $line | cut -d '|' -f 1)" "$(echo $line | cut -d '|' -f 2)"
    fi
  fi
done < "$input_file"
