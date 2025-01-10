#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
IMAGE_NAME="ci-cd-app"
IMAGE_TAG="latest"
REGISTRY="nicholasclark"

# Step 1: Run tests
echo "Running tests..."
pytest

# Step 2: Build Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Step 3: Tag the image
echo "Tagging image..."
docker tag $IMAGE_NAME:$IMAGE_TAG $REGISTRY/$IMAGE_NAME:$IMAGE_TAG

# Step 4: Push the image to the registry
echo "Pushing image to registry..."
docker push $REGISTRY/$IMAGE_NAME:$IMAGE_TAG

# Step 5: Deploy to Kubernetes
echo "Deploying to Kubernetes..."
kubectl apply -f ../infrastructure/k8s/deployment.yml
kubectl apply -f ../infrastructure/k8s/service.yml

echo "Build and deployment complete."
