#!/usr/bin/env bash

# Install Prometheus

# download and extract `prometheus server` package
mkdir -p /home/vagrant/monitoring/prometheus/server
cd /home/vagrant/monitoring/prometheus/server

PROMETHEUS_VERSION=2.39.1
PROM_PKG_NAME=prometheus-${PROMETHEUS_VERSION}.linux-amd64
wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/${PROM_PKG_NAME}.tar.gz
tar xvfz ${PROM_PKG_NAME}.tar.gz
cd ${PROM_PKG_NAME}

# verify prometehus server
./prometheus --version

# Install node exporter

# download and extract `node_exporter` package
mkdir -p /home/vagrant/monitoring/prometheus/node_exporter
cd /home/vagrant/monitoring/prometheus/node_exporter

NODE_EXPORTER_VERSION=1.4.0
NOD_EXP_PKG_NAME=node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/${NOD_EXP_PKG_NAME}.tar.gz
tar xvfz ${NOD_EXP_PKG_NAME}.tar.gz
cd ${NOD_EXP_PKG_NAME}

