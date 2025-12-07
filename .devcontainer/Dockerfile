# Base image
FROM mcr.microsoft.com/devcontainers/php:8.3

# Install additional packages & extensions
RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libpng-dev libzip-dev libonig-dev sqlite3 \
    redis-server supervisor nano curl && \
    docker-php-ext-install intl pdo_sqlite zip gd mbstring

# Disable Xdebug (for speed)
RUN rm -f /usr/local/etc/php/conf.d/*xdebug*.ini

# Install Node.js 20 (for Vite)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Composer cache directory
ENV COMPOSER_CACHE_DIR=/tmp/composer-cache
