#!/bin/bash

echo "Validating SVG files..."

failed=false

for file in $(find design/assets/icons -name "*.svg"); do
  if grep -Ei "<script|onload=|onclick=|onerror=" "$file" > /dev/null; then
    echo "Unsafe SVG found: $file"
    failed=true
  fi
done

if [ "$failed" = true ]; then
  exit 1
fi

echo "All SVG icons are safe."