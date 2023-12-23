#!/bin/bash

# Test script for writer.c

# Compile writer.c
gcc -o writer writer.c -Wall
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

# Function to run a test
run_test() {
    test_desc=$1
    expected_result=$2
    ./writer "$3" "$4"

    # Check the result
    if [ $? -eq $expected_result ]; then
        echo "PASS: $test_desc"
    else
        echo "FAIL: $test_desc"
    fi

    # If a file is supposed to be created, check its content
    if [ $expected_result -eq 0 ]; then
        if [ "$(cat "$3")" == "$4" ]; then
            echo "PASS: File content as expected for $test_desc"
        else
            echo "FAIL: File content not as expected for $test_desc"
        fi
    fi
}

# Test 1: Normal operation
run_test "Normal operation" 0 "testfile.txt" "Hello, World"

# Test 2: Missing arguments
run_test "Missing arguments" 1 "" ""

# Test 3: File cannot be created
run_test "File cannot be created" 1 "/nonexistent_directory/testfile.txt" "Hello"

# Clean up
rm writer
rm testfile.txt

echo "Tests completed."

