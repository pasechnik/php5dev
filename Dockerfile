FROM php:5-apache
MAINTAINER Vladimir Pasechnik <vladimir.pasechnik@gmail.com>

RUN apt-get update && apt-get -y install apt-utils && apt-get -y dist-upgrade

RUN apt-get -y install mc vim wget curl

RUN sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/apache2.conf

RUN a2enmod rewrite
RUN docker-php-ext-install mysql pdo pdo_mysql mysqli

RUN apt-get -y install libzip-dev
RUN docker-php-ext-install zip


RUN pecl install xdebug-2.2.7
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini
RUN echo "xdebug.remote_host=127.0.0.1" >> /usr/local/etc/php/php.ini
#RUN echo 'date.timezone = "Europe/Kiev"'  >> /usr/local/etc/php/php.ini
RUN echo 'date.timezone = "Asia/Jerusalem"'  >> /usr/local/etc/php/php.ini
RUN echo "error_reporting = E_ALL & ~E_NOTICE & ~E_DEPRECATED" >> /usr/local/etc/php/php.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 1.6.3

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/b107d959a5924af895807021fcef4ffec5a76aa9/web/installer \
 && php -r " \
    \$signature = '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061'; \
    \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
        unlink('/tmp/installer.php'); \
        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
        exit(1); \
    }" \
 && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
 && composer --ansi --version --no-interaction \
 && rm -rf /tmp/* /tmp/.htaccess

WORKDIR /var/www/html

COPY ./index.php /var/www/html

RUN chown -R www-data.www-data /var/www/html
RUN chmod -R a+r /var/www/html
#RUN chmod -R u+w /var/www/html/tmp
#RUN find /var/www/html -type d -exec chmod 755 {} \;
RUN ls -alF /var/www/html
