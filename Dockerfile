FROM php:8.0-apache

RUN a2enmod rewrite

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update && apt-get -qq -y upgrade
RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    libmemcached-dev \
    zlib1g-dev \
    imagemagick \
    libmagickwand-dev \
    wget \
    ghostscript \
    ffmpeg

# Mail
RUN apt-get update && \
    apt-get install -y net-tools && \
    apt-get install -y rsyslog
RUN apt-get install -y mailutils

# Install the PHP extensions we need
RUN docker-php-ext-install -j$(nproc) iconv pdo pdo_mysql mysqli

# GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j "$(nproc)" gd

RUN usermod -u 1000 www-data \
  && wget --no-verbose "https://github.com/omeka/omeka-s/releases/download/v3.2.0/omeka-s-3.2.0.zip" -O /var/www/omeka-s.zip \
  && unzip -q /var/www/omeka-s.zip -d /var/www/ \
  &&  rm /var/www/omeka-s.zip \
  &&  rm -rf /var/www/html/materialendatabank/ \
  &&  mv /var/www/omeka-s /var/www/html/materialendatabank/ \
  &&  chown -R www-data:www-data /var/www/html/

# Content
COPY .htaccess /var/www/html/materialendatabank
COPY themes /var/www/html/materialendatabank/themes
COPY modules /var/www/html/materialendatabank/modules  

ADD php.ini-development /usr/local/etc/php

COPY extra.ini /usr/local/etc/php/conf.d/
COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Mail config
COPY update-exim4.conf.conf /etc/exim4/update-exim4.conf.conf
RUN chmod -R 775 /etc/exim4/
RUN update-exim4.conf

CMD ["apache2-foreground"]
