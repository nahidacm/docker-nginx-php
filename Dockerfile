# FROM ubuntu:22.04
# FROM nahidacm/nginx-php:apt-update
# FROM nahidacm/nginx-php:nginx
# FROM nahidacm/nginx-php:php-mysql
# FROM nahidacm/nginx-php:php-lib
# FROM nahidacm/nginx-php:php-ext1
# FROM nahidacm/nginx-php:php-ext2
FROM nahidacm/nginx-php:php-ext3

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# RUN apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common -y
# RUN add-apt-repository ppa:ondrej/php

RUN apt-get -y update

RUN apt-get install -y nginx
RUN apt-get install -y php8.1 php8.1-fpm php-mysql
RUN apt-get install -y libxml2-dev openssl
RUN apt-get install -y php-bcmath php-ctype php-curl \
    php-dom php-fileinfo php-gd php-iconv \
    php-intl php-json php-mbstring \
    php-simplexml php-soap php-sockets \
    php-tokenizer php-xmlwriter php-xsl php-zip

# RUN php --modules

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /var/www/html

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
