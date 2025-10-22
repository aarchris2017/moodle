# Base image
FROM php:8.2-apache

# Install dependencies required by Moodle
RUN apt-get update && apt-get install -y \
    libpq-dev unzip git libzip-dev libicu-dev libxml2-dev \
    && docker-php-ext-install pgsql pdo_pgsql mysqli zip intl opcache xml \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy Moodle files from public/ to Apache root
COPY public/ /var/www/html/

# Enable necessary Apache modules
RUN a2enmod rewrite headers env dir mime

# Set ownership and permissions
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p /var/moodledata && chown -R www-data:www-data /var/moodledata && chmod -R 770 /var/moodledata

# Expose web port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
