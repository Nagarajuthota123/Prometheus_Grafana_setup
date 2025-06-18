# 📊 Prometheus & Grafana Setup on AWS EC2

This guide outlines the step-by-step process to set up **Prometheus** and **Grafana** on an AWS EC2 instance to monitor system metrics using **Node Exporter**.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🚀 Prerequisites

- AWS account with access to launch 2 EC2 instances.
- EC2 instance running **Amazon Linux 2** (t2.micro or higher recommended).
- Open the following **inbound ports** in the Security Group:
  - `9090` – Prometheus
  - `9100` – Node Exporter
  - `3000` – Grafana
  - `80`, `443` – (Optional) HTTP/HTTPS access

---

## ⚙️ 1. Launch and Connect to EC2

- Launch an EC2 instance (Amazon Linux 2).
- Configure Security Group with the above-mentioned ports.
- Connect to the instance using **MobaXterm**, **PuTTY**, or `ssh`.

---

## 📦 2. Install Prometheus and Node Exporter

Use the provided `prometheus.sh, grafana, node_exporter scripts:

🌐 3. Verify Dashboards
Open these URLs in your browser using your EC2's public IP:

Prometheus: http://<EC2_PUBLIC_IP>:9090

Node Exporter: http://<EC2_PUBLIC_IP>:9100

🔧 4. Configure Prometheus to Monitor Node Exporter
Edit the Prometheus configuration file:

sudo nano /etc/prometheus/prometheus.yml
Add the following under scrape_configs:

scrape_configs:
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
Save and exit (Ctrl + O, Enter, Ctrl + X), then restart Prometheus:
sudo systemctl restart prometheus

🧪 5. Test Prometheus Setup
Visit: http://<EC2_PUBLIC_IP>:9090

Go to Status → Targets to verify node_exporter is listed and "up".

Try a query like node_cpu_seconds_total in the "Graph" tab and click Execute.

📊 6. Access Grafana Dashboard
Open Grafana in your browser:

http://<EC2_PUBLIC_IP>:3000
Default credentials:

Username: admin

Password: admin

You'll be prompted to set a new password on first login.

🔗 8. Add Prometheus as a Data Source in Grafana
In the left sidebar, click the gear icon (⚙️) → Data Sources

Click Add data source

Choose Prometheus

In the URL field, enter:

http://localhost:9090
Click Save & Test

You should see: ✅ "Data source is working"

✅ Done!
You now have:

Prometheus collecting system metrics

Node Exporter exposing Linux metrics

Grafana visualizing everything

You can now import dashboards or create custom panels using PromQL queries.

📦 Optional Next Steps
Set up Alertmanager for notifications

Monitor additional services (MySQL, Docker, NGINX) with exporters

Use Grafana's prebuilt dashboards from Grafana.com/dashboards

👨‍💻 Author
Nagaraju Thota – AWS DevOps Engineer
