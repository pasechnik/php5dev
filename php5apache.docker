FROM php:5-apache
MAINTAINER Vladimir Pasechnik <vladimir.pasechnik@gmail.com>

RUN apt-get update && apt-get -y install apt-utils && apt-get -y dist-upgrade

RUN apt -y install mc vim wget curl

RUN sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/apache2.conf

RUN a2enmod rewrite
RUN docker-php-ext-install mysql pdo pdo_mysql mysqli

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini
RUN echo "xdebug.remote_host=127.0.0.1" >> /usr/local/etc/php/php.ini
#RUN echo 'date.timezone = "Europe/Kiev"'  >> /usr/local/etc/php/php.ini
RUN echo 'date.timezone = "Asia/Jerusalem"'  >> /usr/local/etc/php/php.ini
RUN echo "error_reporting = E_ALL & ~E_NOTICE & ~E_DEPRECATED" >> /usr/local/etc/php/php.ini

WORKDIR /var/www/html

COPY ./index.php /var/www/html

RUN chown -R www-data.www-data /var/www/html
RUN chmod -R a+r /var/www/html
#RUN chmod -R u+w /var/www/html/tmp
#RUN find /var/www/html -type d -exec chmod 755 {} \;
RUN ls -alF /var/www/html
