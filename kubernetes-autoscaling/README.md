# 📈 Kubernetes Autoscaling Project

This project demonstrates Kubernetes autoscaling using Horizontal Pod Autoscaler (HPA). The HPA automatically adjusts the number of pods in a deployment based on CPU or memory utilization.

## Features

- **Deployment**: A sample application (NGINX) deployed on Kubernetes.
- **Service**: Exposes the application internally or externally.
- **HPA**: Automatically scales pods based on CPU utilization.

## Folder Structure

```
kubernetes-autoscaling/
├── manifests/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── hpa.yaml
├── scripts/
│   ├── setup.sh
├── docs/
├── README.md
├── .gitignore
```

## Setup

1. Run the `setup.sh` script to deploy the application, service, and HPA:
   ```bash
   ./scripts/setup.sh
   ```

2. Use a load-testing tool (e.g., Apache Bench) to generate traffic and observe scaling.

3. Monitor the HPA:
   ```bash
   kubectl get hpa
   kubectl get pods -w
   ```

## Prerequisites

- Kubernetes cluster
- `kubectl` CLI installed
- Metrics Server installed
