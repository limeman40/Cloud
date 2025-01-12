# 🔔 Kubernetes Monitoring and Alerting

This repository provides a complete guide and setup for monitoring and alerting in Kubernetes using **Prometheus**, **Grafana**, and **Alertmanager**. By following this project, you will gain practical experience in setting up metrics collection, visualization, and alerting in a Kubernetes cluster.

---

## **Objectives**

1. Deploy Prometheus for metrics scraping from Kubernetes components.
2. Use Grafana to visualize metrics with dashboards.
3. Configure Alertmanager to send notifications based on alert rules.
4. Customize dashboards and alerts for specific use cases.
5. Test the monitoring and alerting system for functionality.

---

## **Prerequisites**

- A Kubernetes cluster (e.g., Minikube, Kind, or a cloud provider setup).
- `kubectl` installed and configured for your cluster.
- Helm installed for managing Kubernetes applications.

---

## **Setup Instructions**

### **Step 1: Install Prometheus**

1. Add the Prometheus Helm repository:
   ```bash
      helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
      helm repo update
   ```
2.  Install Prometheus using Helm:
    ```bash
       helm install prometheus prometheus-community/prometheus -n monitoring --create-namespace
    ```
3.  - Verify the installation:
    ```bash
       kubectl get pods -n monitoring
    ```
    - Port-forward the Prometheus server to access the UI:
    ```bash
       kubectl port-forward -n monitoring deploy/prometheus-server 9090
    ```
    - Access Prometheus at `http://localhost:9090`

### **Step 1: Install Prometheus**

1. Add the Grafana Helm repository:
``bash
    helm repo add grafana https://grafana.github.io/helm-charts
```

2. Install Grafana:
```bash
    helm repo add grafana https://grafana.github.io/helm-charts
```

3. Retrieve the admin password:
```bash
    kubectl get secret -n monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```
4. Access Grafana:
-Port-forward to Grafana:
```bash
    kubectl port-forward -n monitoring svc/grafana 3000:80
```
- Visit `http://localhost:3000` and log in with:
- Username: `admin`
- Password: Retrieved above.

5. Add Prometheus as a data source:
- Navigate to Grafana -> Configuration -> Data Sources -> Add.
- Choose Prometheus and set the URL to:
` http://prometheus-server.monitoring.svc.cluster.local `

6. Import predefined dashboards:
- Use dashboard ID `6417` for Kubernetes Monitoring.

### **Step 3: Configure Alertmanager**

1.  Port-forward Alertmanager:
```bash
kubectl port-forward -n monitoring deploy/prometheus-alertmanager 9093
```
Visit `http://localhost:9093.`

2.  Create an alert rule: Create a `ConfigMap` for alert rules:

```yaml
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
```

Apply the `ConfigMap`:

```bash
kubectl apply -f alert-rules-configmap.yaml
```

3. Update Prometheus configuration to include Alert manager:

```yaml
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - alertmanager.monitoring.svc.cluster.local:9093
```

4. Configure notification channels:
- Set up Slack, email, or other integrations in Alert manager's `config.yml`.

### **Step 4: Test the Setup*-

1. Simulate high CPU usage in a pod to trigger an alert.
2. Check Prometheus for alert detection.
3. Verify notifications sent by Alertmanager (e.g., email, Slack).
4. View cluster metrics in Grafana dashboards.

##Optional Enhancements
- Service Mesh Metrics: Integrate Prometheus with Istio or Linkerd for advanced monitoring.
- Log Monitoring: Add Loki and integrate it with Grafana for centralized logging.
- Persistence: Use PersistentVolumeClaims to ensure Prometheus and Grafana data persistence.

## Deliverables
- A functional Kubernetes monitoring and alerting system.
- Screenshots of custom Grafana dashboards.
- Evidence of Alert manager notifications (e.g., email, Slack logs).
- A write-up on challenges faced and solutions implemented.

Resources
- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Alert manager Documentation](https://prometheus.io/docs/alerting/latest/alertmanager/)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)

📧 Contact
For questions or feedback, feel free to reach out:

- Email: nicholas.a.clark@outlook.com
- LinkedIn: [Nicholas Clark](https://www.linkedin.com/in/nicholas-a-clark/)