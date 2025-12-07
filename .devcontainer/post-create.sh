#!/bin/bash
set -e

echo "📦 Running Laravel post-create setup..."

# Install PHP dependencies
if [ -f "composer.json" ]; then
    composer install --no-interaction
fi

# Install JS dependencies
if [ -f "package.json" ]; then
    npm install
fi

# Generate Laravel key
php artisan key:generate || true

echo "🔥 Setup complete!"
