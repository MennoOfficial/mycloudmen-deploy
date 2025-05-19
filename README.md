# MyCloudMen Deploy

Deployment configuration for MyCloudMen project.

## Components

- Docker Compose configuration
- Traefik for reverse proxy
- WireMock for service mocking

## Traefik

The `traefik` folder contains the configuration for Traefik, a modern HTTP reverse proxy and load balancer.

### Configuration Files
- `docker-compose.yml`: Defines the Traefik service with SSL support, dashboard, and basic authentication
- `acme.json`: Stores the SSL certificates issued by Let's Encrypt (this file should have 600 permissions)

### Features
- Automatic HTTPS with Let's Encrypt
- HTTP to HTTPS redirection
- Secure dashboard access at `/traefik` path
- Network isolation using Docker networks

## Setup

```bash
# Clone the repository
git clone https://github.com/MennoOfficial/mycloudmen-deploy.git

# Navigate to the project directory
cd mycloudmen-deploy

# Set proper permissions for SSL certificates
chmod 600 traefik/acme.json

# Configure your environment variables (see .env.example)
cp .env.example .env
# Edit .env with your values

# Start the services
cd mycloudmen
./reload.sh
```

## Configuration

Before starting the services, make sure to:

1. Update the .env file with your credentials and settings
2. Update email address and domain name in Traefik configuration if needed
3. Change default passwords for any secure services 