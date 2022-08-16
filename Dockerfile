FROM ubuntu:22.04

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

ENV WEB_ROOT=/var/www/html

RUN apt-get -y update
RUN apt-get install -y supervisor
RUN apt-get -y install cron
RUN apt-get install -y vim-tiny
RUN apt-get install -y gettext-base

RUN apt-get install -y nginx
RUN apt-get install -y php8.1 php8.1-fpm php-mysql
RUN apt-get install -y libxml2-dev openssl
RUN apt-get install -y php-bcmath php-ctype php-curl \
    php-dom php-fileinfo php-gd php-iconv \
    php-intl php-json php-mbstring \
    php-simplexml php-soap php-sockets \
    php-tokenizer php-xmlwriter php-xsl php-zip

# Nginx configuration
RUN rm /etc/nginx/sites-enabled/default
COPY config/nginx/templates/default.conf.template /etc/nginx/conf.d/default.conf.template

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# PHP configuration
COPY config/php/custom.ini 	/etc/php/8.1/fpm/conf.d/custom.ini

# Supervisor configuration
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy cron file to the cron.d directory
COPY config/crontabs /etc/cron.d/crontabs
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontabs

# Apply cron job
RUN crontab /etc/cron.d/crontabs
 
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html", "/etc/php/8.1/fpm/conf.d"]

# Define working directory.
WORKDIR /var/www/html

# Create non root user
RUN useradd appuser

RUN chown appuser:www-data -R /var/www/html

# Expose ports.
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord"]