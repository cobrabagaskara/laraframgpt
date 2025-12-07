# Gunakan base image resmi Devcontainers untuk PHP + Node
FROM mcr.microsoft.com/devcontainers/php:8.3-node

# Install dependensi tambahan untuk Laravel
RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libpng-dev libzip-dev sqlite3 redis-server supervisor nano curl

# Install ekstensi PHP tambahan
RUN docker-php-ext-install intl pdo pdo_mysql pdo_sqlite zip gd

# Disable Xdebug untuk kecepatan
RUN rm -f /usr/local/etc/php/conf.d/*xdebug*.ini

# Composer cache
ENV COMPOSER_CACHE_DIR=/tmp/composer-cache
