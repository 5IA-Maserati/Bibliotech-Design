#!/bin/bash

echo "Checking filenames..."

invalid=false

while IFS= read -r file; do
  basename=$(basename "$file")

  # Regex: lowercase + dashes + optional -v1, v2 etc.
  if [[ ! "$basename" =~ ^[a-z0-9]+([\-][a-z0-9]+)*(-v[0-9]+)?\.(png|jpg|jpeg|svg|fig|xd|pdf|md)$ ]]; then
    echo "Invalid filename: $file"
    invalid=true
  fi
done < <(find design -type f)

if [ "$invalid" = true ]; then
  echo "Filename lint failed."
  exit 1
fi

echo "All filenames are valid!"