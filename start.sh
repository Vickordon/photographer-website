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

# Check if .env file exists, create minimal one if not
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating minimal .env..."
    cat > .env << 'EOF'
# Database Configuration
DATABASE_URL=postgresql://photographer:photographer_password@db:5432/photographer_prod

# Application Settings
SECRET_KEY_BASE=change_this
PORT=4000
POOL_SIZE=10

# Email Configuration (optional)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=
SMTP_PASSWORD=
SMTP_FROM=noreply@example.com
EOF
    echo "✅ .env file created with default values."
    echo ""
fi

# Generate SECRET_KEY_BASE if not set or still default
if [ -z "$(grep '^SECRET_KEY_BASE=' .env | grep -v 'change_this')" ]; then
    echo "🔐 Generating SECRET_KEY_BASE..."
    SECRET=$(openssl rand -base64 48 2>/dev/null || echo "ZmFrZV9zZWNyZXRfa2V5X2Jhc2VfZm9yX2RldmVsb3BtZW50X29ubHk=")
    
    if grep -q '^SECRET_KEY_BASE=' .env; then
        sed -i.bak "s|^SECRET_KEY_BASE=.*|SECRET_KEY_BASE=$SECRET|" .env && rm -f .env.bak
    else
        echo "SECRET_KEY_BASE=$SECRET" >> .env
    fi
    echo "✅ SECRET_KEY_BASE generated"
fi

echo "📦 Building Docker images..."
$COMPOSE_CMD build

echo ""
echo "🚀 Starting services..."
$COMPOSE_CMD up -d

echo ""
echo "⏳ Waiting for application to start..."
sleep 15

echo ""
echo "✅ Application started successfully!"
echo ""
echo "📍 Access the application:"
echo "   Website: http://localhost:4000"
echo "   Admin:   http://localhost:4000/login"
echo ""
echo "🔐 Default admin credentials:"
echo "   Email:    admin@example.com"
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
