FROM php:8-apache
LABEL maintainer="marie.gradeler@gmail.com"

## Install PHP dependencies
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gettext pdo_pgsql pgsql

# Install git for cloning
RUN apt-get update && apt-get install --no-install-recommends -y git ca-certificates

# Go to the htdocs directory
WORKDIR /var/www/html

# Clone from the NAMOgeoweb repo
RUN git clone https://github.com/GradelerM/NAMOgeoweb.git

# Get the application out of the "NAMOgeoweb" dir
WORKDIR /var/www/html/NAMOgeoweb
RUN mv * ../

# Remove the empty directory
WORKDIR /var/www/html
RUN rm -rf ./NAMOgeoweb

# Add the config.php file to the directory
COPY ./config.php /var/www/html/map
COPY ./info.php /var/www/html

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Clean up
RUN apt-get -y --purge autoremove &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*