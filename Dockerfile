# Use official PHP 8.2 image with Apache
FROM php:8.2-apache

# Install Moodle dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    git \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    && docker-php-ext-install pgsql pdo_pgsql mysqli zip intl opcache xml \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy Moodle files into web root
COPY . /var/www/html/

# Fix permissions for Moodle web root
RUN chown -R www-data:www-data /var/www/html

# Create Moodle data directory outside web root
RUN mkdir -p /var/moodledata \
    && chown -R www-data:www-data /var/moodledata \
    && chmod -R 770 /var/moodledata

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
