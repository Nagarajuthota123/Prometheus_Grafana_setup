#!/bin/bash

# Shell script to create Prometheus YUM repository file on Amazon Linux or RHEL-based systems

REPO_PATH="/etc/yum.repos.d/prometheus.repo"

echo "Creating Prometheus YUM repo at $REPO_PATH..."

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

echo "Prometheus repo created successfully at $REPO_PATH"
