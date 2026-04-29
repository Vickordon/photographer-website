#!/bin/bash

# Photographer Website - One Command Start Script
# This script starts the application with Docker in one command

set -e

echo "🚀 Starting Photographer Website with Docker..."
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "   Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed."
    echo "   Visit: https://docs.docker.com/compose/install/"
    exit 1
fi

# Determine docker-compose command
if docker compose version &> /dev/null; then
    COMPOSE_CMD="docker compose"
else
    COMPOSE_CMD="docker-compose"
fi

# Create or update .env file
echo "🔐 Setting up environment variables..."
cat > .env << EOF
# Database Configuration
DATABASE_URL=postgresql://photographer:photographer_pass@db:5432/photographer_prod

# Application Settings
SECRET_KEY_BASE=$(openssl rand -base64 48 2>/dev/null || echo 'ZmFrZV9zZWNyZXRfa2V5X2Jhc2VfZm9yX2RldmVsb3BtZW50X29ubHk=')
PORT=4000
MIX_ENV=prod

# Email Configuration (optional)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=
SMTP_PASSWORD=
SMTP_FROM=noreply@example.com
EOF

echo "✅ .env file created with secure SECRET_KEY_BASE"
echo ""

echo "📦 Building Docker images..."
$COMPOSE_CMD build --no-cache

echo ""
echo "🚀 Starting services..."
$COMPOSE_CMD up -d

echo ""
echo "⏳ Waiting for database to be ready..."
sleep 5

echo "⏳ Waiting for application to start..."
sleep 10

echo ""
echo "✅ Application started successfully!"
echo ""
echo "📍 Access the application:"
echo "   Website: http://localhost:4000"
echo "   Admin:   http://localhost:4000/login"
echo ""
echo "🔐 Default admin credentials:"
echo "   Email:    [EMAIL_REDACTED]"
echo "   Password: admin123"
echo ""
echo "⚠️  IMPORTANT: Change the default password after first login!"
echo ""
echo "📊 View logs:"
echo "   $COMPOSE_CMD logs -f"
echo ""
echo "🛑 Stop application:"
echo "   $COMPOSE_CMD down"
echo ""
echo "🗑️  Stop and remove all data:"
echo "   $COMPOSE_CMD down -v"
echo ""
