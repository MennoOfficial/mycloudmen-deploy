#!/bin/bash
set -e

# Load environment variables
if [ -f ../.env ]; then
  echo "Loading environment variables from .env file..."
  export $(grep -v '^#' ../.env | xargs)
fi

# Set default values if not provided in .env
DOMAIN=${DOMAIN:-mycloudmen.example.com}

# This script should be run on the VM to deploy the latest version

echo "Pulling latest images from GitHub Container Registry..."
docker compose pull

echo "Restarting services with latest images..."
docker compose down
docker compose up -d

echo "Cleaning up unused images..."
docker image prune -f

echo "Deployment complete!"
echo "Application UI: https://${DOMAIN}"
echo "API Endpoint: https://${DOMAIN}/api"
echo "Traefik Dashboard: https://${DOMAIN}/traefik"

# Print the current version from the running containers
echo -n "Deployed frontend version: "
docker exec $(docker ps -q -f name=mycloudmen-frontend) sh -c "cat /usr/share/nginx/html/assets/version.js" | grep APP_VERSION | cut -d "'" -f 2

echo -n "Deployed backend version: "
docker exec $(docker ps -q -f name=mycloudmen-backend) sh -c "cat /app/resources/version.properties" | grep application.version | cut -d "=" -f 2

echo "Remember to clear browser cache with Ctrl+F5 to see all changes!" 