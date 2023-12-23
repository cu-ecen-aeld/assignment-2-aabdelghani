#!/bin/bash

# Check if the number of arguments is correct
if [ $# -ne 2 ]; then
    echo "Error: Please specify both the directory path and the search string."
    exit 1
fi

# Extract arguments
filesdir="$1"
searchstr="$2"

# Check if filesdir is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: '$filesdir' is not a directory."
    exit 1
fi

# Initialize counters
file_count=0
match_count=0

# Recursively search for matching lines in files
while IFS= read -r -d '' file; do
    if [ -f "$file" ]; then
        ((file_count++))
        match_lines=$(grep -c "$searchstr" "$file")
        ((match_count += match_lines))
    fi
done < <(find "$filesdir" -type f -print0)

# Print the results
echo "The number of files are $file_count and the number of matching lines are $match_count"

# Exit with success
exit 0

