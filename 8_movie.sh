#!/bin/bash

API_KEY="d34d839"
read -p "Enter a movie title: " title
#title="$1"

response=$(wget -qO- "http://www.omdbapi.com/?apikey=$API_KEY&s=$title")

if [[ $response == *"Error"* ]]; then
  echo "Error: Movie not found"
else
  titles=$(echo "$response" | jq -r '.Search[].Title')
  years=$(echo "$response" | jq -r '.Search[].Year')
  
  if [ -z "$titles" ]; then
    echo "No matching movies found"
  else
    echo "Matching movies:"
    paste <(echo "$titles") <(echo "$years") -d ', '
  fi
fi
