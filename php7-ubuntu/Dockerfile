FROM ubuntu:17.04

RUN apt-get update
RUN apt-get install -y software-properties-common git vim

RUN apt-get update
RUN apt-get install --allow-unauthenticated -y apache2 libapache2-mod-php7.0
RUN apt-get install --allow-unauthenticated -y php php7.0-gd php7.0-cgi php7.0-curl php-json php7.0-pgsql php-xdebug php7.0-soap php7.0-xml php7.0-imap php-imagick php7.0-mbstring
RUN apt-get install -y build-essential unzip xmlsec1 zip libxmlsec1 libxmlsec1-openssl
RUN apt-get install -y mcrypt

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postfix >> /dev/null || :
ADD config/postfix/filtro /etc/postfix/
ADD config/postfix/main.cf /etc/postfix/

RUN rm -rf /etc/php/7.0/apache2/php.ini
ADD config/php/php.ini /etc/php/7.0/apache2/

RUN rm -rf /etc/php/7.0/cgi/php.ini
ADD config/php/php.ini /etc/php/7.0/cgi/

RUN rm -rf /etc/php/7.0/cli/php.ini
ADD config/php/cli/php.ini /etc/php/7.0/cli/

RUN rm -rf /etc/php/7.0/mods-available/20-xdebug.ini
ADD config/php/20-xdebug.ini /etc/php/7.0/mods-available/

RUN php -r "readfile('https://getcomposer.org/installer');" | php; mv composer.phar /usr/local/bin/composer; chmod +x /usr/local/bin/composer

ADD config/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
CMD ["/usr/local/bin/start.sh"]
