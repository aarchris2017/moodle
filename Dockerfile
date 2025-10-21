# Use official PHP image with Apache
FROM php:8.1-apache

# Install Moodle dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    git \
    && docker-php-ext-install pgsql pdo_pgsql mysqli

# Copy Moodle files into web root
COPY . /var/www/html/

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
