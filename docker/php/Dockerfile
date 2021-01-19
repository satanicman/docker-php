FROM php:fpm

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

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir -p /usr/src/php/ext/xdebug && curl -fsSL https://pecl.php.net/get/xdebug | tar xvz -C "/usr/src/php/ext/xdebug" --strip 1

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
mkdir -p ${HOME}/php-default-conf && \
cp -R /usr/local/etc/* ${HOME}/php-default-conf
