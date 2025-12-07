# Base image resmi Codespaces dengan PHP 8.3 + Composer
FROM mcr.microsoft.com/devcontainers/php:8.3

# Instal paket penting Laravel
RUN apt-get update && apt-get install -y \
    git unzip sqlite3 libsqlite3-dev \
    libpng-dev libzip-dev libonig-dev libicu-dev \
    redis-server nano curl supervisor

# Install ekstensi PHP yang benar
RUN docker-php-ext-configure intl && \
    docker-php-ext-install intl gd zip pdo pdo_mysql pdo_sqlite

# Install Node.js 20 (Vite)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Matikan Xdebug untuk performa
RUN rm -f /usr/local/etc/php/conf.d/*xdebug*.ini

# Composer cache
ENV COMPOSER_CACHE_DIR=/tmp/composer-cache
