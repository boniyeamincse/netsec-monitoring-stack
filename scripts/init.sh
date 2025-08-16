#!/bin/bash

# Automated setup script for the NetSec Monitoring Stack

# --- Helper Functions ---

function check_command() {
  if ! command -v $1 &> /dev/null; then
    echo "Error: $1 is not installed. Please install it before running this script."
    exit 1
  fi
}

function generate_password() {
  openssl rand -base64 16
}

# --- Main Script ---

echo "🚀 Starting the setup process for the NetSec Monitoring Stack..."

# 1. Check for dependencies
echo "
🔎 Checking for dependencies..."
check_command docker
check_command docker-compose

# 2. Configure environment
echo "
🔑 Configuring environment files and generating passwords..."

# .env
if [ ! -f .env ]; then
  cp .env.example .env
fi

# librenms.env
if [ ! -f env/librenms.env ]; then
  cp env/librenms.env.example env/librenms.env
  DB_PASSWORD=$(generate_password)
  sed -i "s/DB_PASSWORD=/DB_PASSWORD=${DB_PASSWORD}/g" env/librenms.env
fi

# netbox.env
if [ ! -f env/netbox.env ]; then
  cp env/netbox.env.example env/netbox.env
  POSTGRES_PASSWORD=$(generate_password)
  SUPERUSER_PASSWORD=$(generate_password)
  sed -i "s/POSTGRES_PASSWORD=/POSTGRES_PASSWORD=${POSTGRES_PASSWORD}/g" env/netbox.env
  sed -i "s/SUPERUSER_PASSWORD=/SUPERUSER_PASSWORD=${SUPERUSER_PASSWORD}/g" env/netbox.env
fi

# 3. Start all services
echo "
🐳 Starting all services with Docker Compose..."

make up-core
make up-flows
make up-ids
make up-soc
make up-ti
make up-grafana

echo "
✅ Setup complete! All services are starting up in the background."
echo "
ℹ️ It may take a few minutes for all services to be fully available."
echo "
🔗 You can check the status of the services with 'make ps' or view the logs with 'make logs'."
