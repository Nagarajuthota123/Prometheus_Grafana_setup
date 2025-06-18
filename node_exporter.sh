#!/bin/bash

# Script to install Node Exporter on Amazon Linux

set -e

NODE_EXPORTER_VERSION="1.8.1"

echo "📦 Downloading Node Exporter v$NODE_EXPORTER_VERSION..."
cd /tmp
curl -sLO https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

echo "📂 Extracting..."
tar -xzf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
cd node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64

echo "👤 Creating node_exporter user..."
sudo useradd --no-create-home --shell /bin/false node_exporter

echo "📁 Installing binary..."
sudo cp node_exporter /usr/local/bin/
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

echo "🛠️ Creating systemd service..."
sudo bash -c "cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF"

echo "🚀 Starting and enabling Node Exporter..."
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
sudo systemctl status node_exporter
