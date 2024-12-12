FROM php:8.3

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libxpm-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    bash \
    fcgiwrap \
    libmcrypt-dev \
    libonig-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath opcache

# Install Composer (using the official image)
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Install Node.js and pnpm
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pnpm

# Set up working directory
WORKDIR /var/www

# Copy project files into the container
COPY . /var/www/

# Install PHP and Node.js dependencies
RUN composer install --no-dev --no-interaction --no-progress --no-suggest \
    && pnpm install

# Set ownership for web server user
RUN chown -R www-data:www-data /var/www

# Expose the port for php artisan serve
EXPOSE 8000
