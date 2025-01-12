#!/bin/bash

# Set the project root folder name
PROJECT_NAME="kubernetes-monitoring-alerting"

# Create the main project directory
mkdir -p $PROJECT_NAME

# Create subdirectories
mkdir -p $PROJECT_NAME/charts
mkdir -p $PROJECT_NAME/manifests
mkdir -p $PROJECT_NAME/scripts
mkdir -p $PROJECT_NAME/docs
mkdir -p $PROJECT_NAME/logs

# Create essential files
touch $PROJECT_NAME/.gitignore
touch $PROJECT_NAME/README.md
touch $PROJECT_NAME/LICENSE

# Add example files for charts directory
cat <<EOL > $PROJECT_NAME/charts/prometheus-values.yaml
# Custom values for Prometheus
server:
  persistentVolume:
    enabled: true
    size: 10Gi
    storageClass: standard
alertmanager:
  persistentVolume:
    enabled: true
    size: 2Gi
    storageClass: standard
EOL

cat <<EOL > $PROJECT_NAME/charts/grafana-values.yaml
# Custom values for Grafana
persistence:
  enabled: true
  storageClassName: standard
  size: 10Gi
EOL

# Add example files for manifests directory
cat <<EOL > $PROJECT_NAME/manifests/prometheus-alert-rules.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-rules
  namespace: monitoring
data:
  alert-rules.yaml: |
    groups:
    - name: example
      rules:
      - alert: HighCPUUsage
        expr: node_cpu_seconds_total > 0.8
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "High CPU Usage Detected"
          description: "CPU usage is above 80% for more than 2 minutes."
EOL

# Add example files for docs directory
cat <<EOL > $PROJECT_NAME/docs/setup-guide.md
# Setup Guide
Follow these steps to set up Kubernetes Monitoring and Alerting using Prometheus, Grafana, and Alertmanager.
EOL

cat <<EOL > $PROJECT_NAME/docs/troubleshooting.md
# Troubleshooting
Common issues and solutions for setting up Kubernetes Monitoring and Alerting.
EOL

cat <<EOL > $PROJECT_NAME/docs/resources.md
# Resources
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Alertmanager Documentation](https://prometheus.io/docs/alerting/latest/alertmanager/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
EOL

# Add example script files
cat <<EOL > $PROJECT_NAME/scripts/port-forward.sh
#!/bin/bash
# Script to port-forward Prometheus and Grafana services

# Port-forward Prometheus
echo "Port-forwarding Prometheus..."
kubectl port-forward -n monitoring svc/prometheus-server 9090:80 &

# Port-forward Grafana
echo "Port-forwarding Grafana..."
kubectl port-forward -n monitoring svc/grafana 3000:80 &
EOL

cat <<EOL > $PROJECT_NAME/scripts/setup-persistence.sh
#!/bin/bash
# Script to apply persistence configurations

echo "Applying persistence for Prometheus..."
kubectl apply -f manifests/prometheus-alert-rules.yaml

echo "Applying persistence for Grafana..."
helm upgrade --install grafana grafana/grafana -n monitoring -f charts/grafana-values.yaml

echo "Setup complete!"
EOL

# Make scripts executable
chmod +x $PROJECT_NAME/scripts/*.sh

# Print completion message
echo "Project folder structure created at: $PROJECT_NAME"
tree $PROJECT_NAME
