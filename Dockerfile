# Use an official PHP image as the base image
FROM php:8.1-cli

# Install system dependencies, curl, unzip, and other libraries needed by Composer
RUN apt-get update && apt-get install -y curl unzip libpng-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy all files from the current directory to the working directory in the container
COPY . .

# Install PHP dependencies using Composer
RUN composer install --no-dev --optimize-autoloader

# Expose port 8080 to be accessible from outside the container
EXPOSE 8080

# Start PHP's built-in server and bind it to the dynamic $PORT environment variable
CMD ["php", "-S", "0.0.0.0:$PORT", "-t", "public"]
