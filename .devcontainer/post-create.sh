#!/usr/bin/env bash
set -e

echo "🚀 Running Laravel post-create setup..."

# Ensure storage folders exist
mkdir -p storage/logs
mkdir -p bootstrap/cache
mkdir -p database

# Fix permissions
chmod -R 777 storage bootstrap/cache

# Create SQLite database if not exists
if [ ! -f "database/database.sqlite" ]; then
    touch database/database.sqlite
fi

# Install composer dependencies (if vendor missing)
if [ ! -d "vendor" ]; then
    composer install
fi

# Install node modules (if node_modules missing)
if [ ! -d "node_modules" ]; then
    npm install
fi

echo "✨ Laravel environment ready!"
