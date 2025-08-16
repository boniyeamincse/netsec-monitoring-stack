#!/bin/bash

# Automated setup script for the NetSec Monitoring Stack

# --- Helper Functions ---

function check_and_install_packages() {
  # Detect package manager
  if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
  elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
  elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
  else
    echo "Error: Could not detect package manager. Please install Docker and Docker Compose manually."
    exit 1
  fi

  # Check for Docker
  if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Attempting to install..."
    read -p "Do you want to proceed with the installation? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      sudo $PKG_MANAGER update
      sudo $PKG_MANAGER install -y docker.io
      sudo systemctl start docker
      sudo systemctl enable docker
    else
      echo "Installation aborted. Please install Docker manually and run this script again."
      exit 1
    fi
  fi

  # Check for Docker Compose
  if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Attempting to install..."
    read -p "Do you want to proceed with the installation? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
    else
      echo "Installation aborted. Please install Docker Compose manually and run this script again."
      exit 1
    fi
  fi
}

function generate_password() {
  openssl rand -base64 16
}

# --- Main Script ---

echo "🚀 Starting the setup process for the NetSec Monitoring Stack..."

# 1. Check for and install dependencies
echo "
🔎 Checking for and installing dependencies..."
check_and_install_packages

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