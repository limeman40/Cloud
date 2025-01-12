#!/bin/bash

# Variables
DEPLOYMENT_FILE="../manifests/deployment.yaml"
SERVICE_FILE="../manifests/service.yaml"
HPA_FILE="../manifests/hpa.yaml"
METRICS_SERVER="https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"

# Check for kubectl
if ! command -v kubectl &> /dev/null
then
    echo "Error: kubectl is not installed. Please install kubectl and try again."
    exit 1
fi

# Install Metrics Server
echo "Installing Metrics Server..."
kubectl apply -f $METRICS_SERVER

# Wait for Metrics Server
echo "Waiting for Metrics Server to be ready..."
sleep 30

# Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."
kubectl apply -f $DEPLOYMENT_FILE
kubectl apply -f $SERVICE_FILE
kubectl apply -f $HPA_FILE

# Verify
echo "Setup complete! Verify resources with 'kubectl get all' and test autoscaling."
