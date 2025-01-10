#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
NAMESPACE="ci-cd-namespace"
DEPLOYMENT_FILE="infrastructure/k8s/deployment.yml"
SERVICE_FILE="infrastructure/k8s/service.yml"

# Step 1: Create namespace if it doesn't exist
echo "Ensuring namespace exists..."
kubectl get namespace $NAMESPACE || kubectl create namespace $NAMESPACE

# Step 2: Apply Deployment
if [ -f "$DEPLOYMENT_FILE" ]; then
    echo "Applying Deployment..."
    kubectl apply -f $DEPLOYMENT_FILE -n $NAMESPACE
else
    echo "Error: Deployment file '$DEPLOYMENT_FILE' not found!"
    exit 1
fi

# Step 3: Apply Service
if [ -f "$SERVICE_FILE" ]; then
    echo "Applying Service..."
    kubectl apply -f $SERVICE_FILE -n $NAMESPACE
else
    echo "Error: Service file '$SERVICE_FILE' not found!"
    exit 1
fi

echo "Deployment successful."
