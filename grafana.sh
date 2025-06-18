#!/bin/bash

# Script to install Grafana on Amazon Linux 2

set -e

echo "🚀 Starting Grafana installation..."

# Step 1: Add Grafana YUM repo
REPO_FILE="/etc/yum.repos.d/grafana.repo"
echo "📁 Creating Grafana repo at $REPO_FILE"
sudo bash -c "cat <<EOF > $REPO_FILE
[grafana]
name=Grafana OSS
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
EOF"

# Step 2: Clean yum cache
echo "🧹 Cleaning YUM cache..."
sudo yum clean all

# Step 3: Download and install Grafana
GRAFANA_VERSION="10.2.3-1"
RPM_URL="https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.x86_64.rpm"

echo "⬇️ Downloading Grafana $GRAFANA_VERSION"
cd /tmp
wget "$RPM_URL"

echo "📦 Installing Grafana $GRAFANA_VERSION"
sudo yum localinstall "grafana-${GRAFANA_VERSION}.x86_64.rpm" -y

echo "🚀 Starting and enabling Grafana..."
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

echo "📊 Grafana installation complete. Access it on port 3000."
sudo systemctl status grafana-server
