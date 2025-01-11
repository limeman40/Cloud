#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define the test directory
TEST_DIR="../tests"

echo "Running all unit tests in the '${TEST_DIR}' folder..."

# Check if the tests folder exists
if [ ! -d "$TEST_DIR" ]; then
  echo "Error: '${TEST_DIR}' directory does not exist."
  exit 1
fi

# Run the tests using a testing framework (e.g., Jest, Pytest, Mocha, etc.)
# Replace 'npm test' with your specific test command
npm test "$TEST_DIR" --passWithNoTests

# Check the status of the tests
if [ $? -eq 0 ]; then
  echo "All tests passed successfully!"
else
  echo "Some tests failed. Check the logs above for more details."
  exit 1
fi
