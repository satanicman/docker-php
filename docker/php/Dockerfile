FROM php:7-fpm

ARG WEB_USER
ARG WEB_GROUP
ARG PHP_ROOT_DIR

COPY www.conf ${PHP_ROOT_DIR}/php-fpm.d/www.conf

RUN usermod -u 1000 ${WEB_USER} \
 && groupmod -g 1000 ${WEB_GROUP} \
 && chgrp -R staff ${PHP_ROOT_DIR}/php-fpm.d/www.conf

RUN \
apt-get update && \
apt-get install -y git libonig-dev libwebp-dev libjpeg62-turbo-dev libpng-dev libfreetype6-dev libmcrypt-dev libssl-dev libgmp-dev libicu-dev procps && \
apt-get clean && \
rm -rf /var/lib/apt/list/*

RUN mkdir -p /usr/src/php/ext/xdebug && curl -fsSL https://pecl.php.net/get/xdebug-2.9.8 | tar xvz -C "/usr/src/php/ext/xdebug" --strip 1

RUN \
docker-php-ext-configure pdo_mysql && \
docker-php-ext-configure mbstring && \
docker-php-ext-configure sockets && \
docker-php-ext-configure gd --with-jpeg=/usr/include --with-webp=/usr/include --with-freetype=/usr/include && \
docker-php-ext-configure opcache && \
docker-php-ext-configure exif && \
docker-php-ext-configure gmp && \
docker-php-ext-configure bcmath && \
docker-php-ext-configure intl && \
docker-php-ext-install xdebug pdo_mysql mbstring sockets gd opcache exif gmp bcmath intl

RUN \
echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
&& echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
&& echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini \
&& echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN \
mkdir -p ${HOME}/php-default-conf && \
cp -R /usr/local/etc/* ${HOME}/php-default-conf
