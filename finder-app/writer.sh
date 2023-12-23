#!/bin/bash

# Script: writer.sh
# Arguments: 
# 1. Full path to a file (writefile)
# 2. Text string to be written (writestr)

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Error: Two arguments are required."
    echo "Usage: $0 <path-to-file> <text-string>"
    exit 1
fi

writefile="$1"
writestr="$2"

# Extract the directory path from the full file path
dirpath=$(dirname "$writefile")

# Create the directory if it does not exist
if ! mkdir -p "$dirpath"; then
    echo "Error: Failed to create directory $dirpath."
    exit 1
fi

# Write the string to the file, creating or overwriting the file
if echo "$writestr" > "$writefile"; then
    echo "File written successfully."
else
    echo "Error: Failed to write to file $writefile."
    exit 1
fi

