#!/bin/bash

# Install composer deps jika ada
if [ -f "composer.json" ]; then
    composer install
fi

# Install node deps jika ada
if [ -f "package.json" ]; then
    npm install
fi

# Generate APP_KEY
if [ ! -f ".env" ]; then
    cp .env.example .env
fi
php artisan key:generate || true

echo "Post-create script selesai!"
