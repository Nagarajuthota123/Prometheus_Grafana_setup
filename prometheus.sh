#!/bin/bash

# Script to create Prometheus YUM repository and install Prometheus & Node Exporter

set -e

REPO_PATH="/etc/yum.repos.d/prometheus.repo"

echo "📁 Creating Prometheus YUM repo at $REPO_PATH..."
sudo bash -c "cat <<EOF > $REPO_PATH
[prometheus]
name=Prometheus
baseurl=https://packagecloud.io/prometheus-rpm/release/el/7/x86_64
repo_gpgcheck=1
enabled=1
gpgkey=https://packagecloud.io/prometheus-rpm/release/gpgkey https://raw.githubusercontent.com/lest/prometheus-rpm/master/RPM-GPG-KEY-prometheus-rpm
gpgcheck=1
metadata_expire=300
EOF"

echo "🔄 Updating packages and installing Prometheus & Node Exporter..."
sudo yum update -y
sudo yum install -y prometheus2 node_exporter

echo "ℹ️ Checking Prometheus package info..."
rpm -qi prometheus2

echo "🚀 Starting Prometheus and Node Exporter services..."
sudo systemctl start prometheus
sudo systemctl start node_exporter

echo "✅ Enabling services to start on boot..."
sudo systemctl enable prometheus
sudo systemctl enable node_exporter

echo "📊 Checking service status..."
sudo systemctl status prometheus
sudo systemctl status node_exporter
