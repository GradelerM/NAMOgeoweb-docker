FROM php:8-apache
LABEL maintainer="marie.gradeler@gmail.com"

## Install PHP dependencies
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gettext pdo_pgsql pgsql

# Install git for cloning
RUN apt-get update && apt-get install --no-install-recommends -y git ca-certificates zlib1g-dev libzip-dev sendmail

# Config sendmail
RUN echo "sendmail_path=/usr/sbin/sendmail -t -i" >> /usr/local/etc/php/conf.d/sendmail.ini 
RUN sed -i '/#!\/bin\/sh/aservice sendmail restart' /usr/local/bin/docker-php-entrypoint
RUN sed -i '/#!\/bin\/sh/aecho "$(hostname -i)\t$(hostname) $(hostname).localhost" >> /etc/hosts' /usr/local/bin/docker-php-entrypoint

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

# Add the config files to the application
COPY ./init/config.php /var/www/html/map
COPY ./init/optional/palette.css /var/www/html/map/styles
COPY ./init/optional/regions_of_interest.html /var/www/html/map
COPY ./init/optional/thumbnails/* /var/www/html/map/images/assets/thumbnails/
COPY ./init/optional/logos/* /var/www/html/map/images/assets/logos/
COPY ./init/about.html /var/www/html/map/components

# Make sure www-data owns the files
WORKDIR /var/www
RUN chown -R www-data:www-data html

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Clean up
RUN apt-get -y --purge autoremove &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*