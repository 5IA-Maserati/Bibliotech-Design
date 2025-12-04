#!/bin/bash

TARGET_DIR=${1:-.}
MAX_KB=15000

echo "Checking file sizes inside: $TARGET_DIR ..."

oversized=false

while IFS= read -r file; do
  size_kb=$(du -k "$file" | cut -f1)

  if (( size_kb > MAX_KB )); then
    echo "File too large: $file (${size_kb}KB)"
    oversized=true
  fi
done < <(find "$TARGET_DIR" -type f)

if [ "$oversized" = true ]; then
  echo "File size check failed."
  exit 1
fi

echo "All files are within allowed size!"