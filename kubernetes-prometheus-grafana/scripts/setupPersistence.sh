#!/bin/bash
# Script to apply persistence configurations

echo "Applying persistence for Prometheus..."
kubectl apply -f manifests/prometheus-alert-rules.yaml

echo "Applying persistence for Grafana..."
helm upgrade --install grafana grafana/grafana -n monitoring -f ../charts/grafana-values.yaml

echo "Setup complete!"
