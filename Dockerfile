# Use an official PHP image as the base image
 # Use a PHP image as the base image (if this doesn't work, we'll install PHP manually)
FROM php:8.1-cli

# Install curl, unzip, and other required dependencies for Composer
RUN apt-get update && apt-get install -y curl unzip libpng-dev

# Install PHP (if not already installed)
RUN apt-get install -y php-cli

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the application files to the container
COPY . .

# Install PHP dependencies using Composer
RUN /usr/local/bin/composer install --no-dev --optimize-autoloader

# Expose the port that Render provides
EXPOSE 8080

# Start the PHP built-in server
CMD ["php", "-S", "0.0.0.0:$PORT", "-t", "public"]
