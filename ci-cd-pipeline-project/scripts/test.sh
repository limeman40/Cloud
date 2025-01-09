#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 1: Run unit tests with pytest
echo "Running unit tests..."
pytest --maxfail=5 --disable-warnings

# Step 2: Check code formatting with black
echo "Checking code formatting with Black..."
black --check .

# Step 3: Run static code analysis with pylint
echo "Running static code analysis with Pylint..."
pylint $(find . -name "*.py" | tr '\n' ' ')

# Step 4: Run security checks with bandit
echo "Running security checks with Bandit..."
bandit -r .

echo "All tests and checks passed successfully."
