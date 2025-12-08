#!/usr/bin/env bash
set -e

echo "▶ Updating packages..."
sudo apt-get update -y

echo "▶ Installing dependencies..."
sudo apt-get install -y zip unzip sqlite3 redis-server libicu-dev libzip-dev

echo "▶ Installing PHP extensions..."
sudo docker-php-ext-install intl pdo_sqlite zip

echo "▶ Installing Node 20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "▶ Installing Composer (latest)..."
EXPECTED_CHECKSUM="$(curl -fsSL https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$EXPECTED_CHECKSUM') { echo \"Installer verified\"; } else { echo \"Installer corrupt\"; exit(1); }"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

echo "▶ Installing Laravel dependencies..."
composer install

echo "▶ Installing Node dependencies..."
npm install

echo "▶ Done! Container ready ✓"
