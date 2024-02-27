FROM ubuntu:20.04
LABEL maintainer="prosenjit@itobuz.com"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install apache2 apache2-utils  -y
RUN a2enmod rewrite && a2enmod headers && a2enmod expires 
RUN apt-get install -y  unzip curl ca-certificates nano imagemagick webp wget

RUN apt-get install -y software-properties-common apt-transport-https -y
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update

# Install php version 7.4
RUN apt install -y php7.4 php7.4-mysql php7.4-curl php7.4-dom php7.4-mbstring php7.4-zip php7.4-imagick libapache2-mod-php7.4 php7.4-intl

# Install WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN apt-get install -y mysql-client

# Default appache config
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN a2enmod ssl
RUN a2ensite default-ssl.conf

RUN apt clean 
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]