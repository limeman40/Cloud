#!/bin/bash
# Script to port-forward Prometheus and Grafana services

# Port-forward Prometheus
echo "Port-forwarding Prometheus..."
kubectl port-forward -n monitoring svc/prometheus-server 9090:80 &

# Port-forward Grafana
echo "Port-forwarding Grafana..."
kubectl port-forward -n monitoring svc/grafana 3000:80 &
