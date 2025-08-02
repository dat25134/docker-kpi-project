FROM php:8.2-fpm

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    libzip-dev unzip curl cron git supervisor libpng-dev libonig-dev \
    libjpeg-dev libfreetype6-dev libpng-dev libwebp-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install pdo pdo_mysql zip mbstring gd exif

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

RUN git clone https://github.com/phpredis/phpredis.git /tmp/phpredis && \
    cd /tmp/phpredis && \
    git checkout 5.3.7 && \
    phpize && \
    ./configure && \
    make && make install && \
    docker-php-ext-enable redis && \
    rm -rf /tmp/phpredis

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .

# Composer install sẽ chạy trong docker-compose

EXPOSE 90
