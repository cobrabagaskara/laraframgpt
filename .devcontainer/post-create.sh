#!/bin/bash

# Script untuk setup Laravel di Codespace/DevContainer

echo "🚀 Starting Laravel setup..."

# 1. Update dan install dependencies
sudo apt-get update
sudo apt-get install -y git curl unzip

# 2. Install Composer (jika belum ada)
if ! command -v composer &> /dev/null; then
    echo "📦 Installing Composer..."
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    php -r "unlink('composer-setup.php');"
fi

# 3. Install Node.js dan npm (untuk Vite/Mix)
if ! command -v node &> /dev/null; then
    echo "📦 Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# 4. Install Laravel dependencies
if [ -f "composer.json" ]; then
    echo "📦 Installing PHP dependencies..."
    composer install --no-interaction --prefer-dist --optimize-autoloader
    
    # 5. Setup .env file jika belum ada
    if [ ! -f ".env" ]; then
        echo "⚙️ Creating .env file..."
        cp .env.example .env
        # Generate app key
        php artisan key:generate
    else
        # Pastikan app key sudah di-generate
        if ! grep -q "^APP_KEY=base64:" .env; then
            echo "🔑 Generating app key..."
            php artisan key:generate
        fi
    fi
    
    # 6. Link storage
    echo "📁 Linking storage..."
    php artisan storage:link
    
    # 7. Optimize Laravel
    echo "⚡ Optimizing Laravel..."
    php artisan optimize:clear
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    
    # 8. Install Node dependencies dan build assets (jika ada package.json)
    if [ -f "package.json" ]; then
        echo "📦 Installing Node dependencies..."
        npm ci --silent
        
        echo "🔨 Building assets..."
        # Cek apakah menggunakan Vite atau Mix
        if [ -f "vite.config.js" ] || [ -f "vite.config.ts" ]; then
            npm run build
        elif [ -f "webpack.mix.js" ]; then
            npm run production
        fi
    fi
    
    # 9. Set permissions untuk Laravel
    echo "🔒 Setting permissions..."
    sudo chown -R $USER:www-data storage bootstrap/cache
    sudo chmod -R 775 storage bootstrap/cache
    
    # 10. Create symbolic link untuk public storage jika perlu
    if [ ! -L "public/storage" ]; then
        php artisan storage:link
    fi
fi

# 11. Start development server di background (opsional)
echo "🌐 Starting Laravel development server..."
# php artisan serve --host=0.0.0.0 --port=8000 &

echo "✅ Setup completed!"
echo "📊 Please check:"
echo "   - Port 8000: Laravel application"
echo "   - Port 5173: Vite dev server (if using Vite)"
