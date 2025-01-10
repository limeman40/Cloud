# CI/CD Pipeline Configuration

This directory contains CI/CD configuration files.

## Pipeline Overview
- **Linting**: Ensures code quality using Pylint.
- **Testing**: Runs all unit tests using Pytest.
- **Deployment**: Automates deployment steps (e.g., Docker build, cloud deployment).

## File Structure
- `main.yml`: GitHub Actions workflow configuration.

## Adding New Steps
To modify the pipeline, edit the `main.yml` file and commit changes. Ensure to test your changes locally before pushing.

For more details, refer to the main [README.md](../README.md).
