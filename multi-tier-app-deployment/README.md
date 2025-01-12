# Multi-Tier Application Deployment

This repository contains the Kubernetes manifests for deploying a multi-tier application with three components:
1. Database (MySQL)
2. Backend
3. Frontend

## Folder Structure
- `k8s/database`: Contains manifests for the database tier.
- `k8s/backend`: Contains manifests for the backend tier.
- `k8s/frontend`: Contains manifests for the frontend tier.

## Deployment Instructions
1. Apply the database tier:
   ```
   kubectl apply -f k8s/database/
   ```

2. Apply the backend tier:
   ```
   kubectl apply -f k8s/backend/
   ```

3. Apply the frontend tier:
   ```
   kubectl apply -f k8s/frontend/
   ```

4. Verify deployments:
   ```
   kubectl get pods -n multi-tier-app
   ```
