#!/bin/bash

echo "Checking file sizes..."

MAX_KB=5000
failed=false

while IFS= read -r file; do
  size_kb=$(du -k "$file" | cut -f1)

  if [ "$size_kb" -gt "$MAX_KB" ]; then
    echo "$file is too large: ${size_kb}KB (max ${MAX_KB}KB)"
    failed=true
  fi
done < <(find design -type f -name "*.*")

if [ "$failed" = true ]; then
  exit 1
fi

echo "All files are within allowed size!"