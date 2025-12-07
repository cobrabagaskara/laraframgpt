# Base image resmi Codespaces dengan PHP 8.3 + Composer + Git
FROM mcr.microsoft.com/devcontainers/php:8.3

# Install libraries untuk Laravel
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
        libicu-dev libzip-dev libpng-dev libonig-dev \
        sqlite3 libsqlite3-dev unzip curl nano redis-server

# Install PHP extensions
RUN docker-php-ext-install intl pdo pdo_mysql pdo_sqlite zip gd mbstring

# Install Node.js 20 dengan cara aman (tanpa NodeSource)
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs

# Matikan Xdebug (untuk performa) — aman
RUN rm -f /usr/local/etc/php/conf.d/*xdebug*.ini

# Composer cache dir
ENV COMPOSER_CACHE_DIR=/tmp/composer-cache

# Set working dir
WORKDIR /workspaces/laraframgpt
