#!/bin/bash

# Stop the application
echo "🛑 Stopping Photographer Website..."

if command -v docker-compose &> /dev/null; then
    docker-compose down
elif docker compose version &> /dev/null; then
    docker compose down
else
    echo "❌ Docker Compose is not installed"
    exit 1
fi

echo "✅ Application stopped"
