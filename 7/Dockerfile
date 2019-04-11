FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y software-properties-common git vim

RUN apt-get update
RUN apt-get install --allow-unauthenticated -y apache2 libapache2-mod-php7.0
RUN apt-get install --allow-unauthenticated -y php php7.0-gd php7.0-cgi php7.0-curl php-json php7.0-pgsql \
                                               php-xdebug php7.0-soap php7.0-xml php7.0-imap php-imagick \
                                               php7.0-mbstring php7.0-zip php7.0-mcrypt
RUN phpenmod mcrypt
RUN apt-get install -y build-essential unzip xmlsec1 zip libxmlsec1 libxmlsec1-openssl

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postfix >> /dev/null || :
ADD config/postfix/filtro /etc/postfix/
ADD config/postfix/main.cf /etc/postfix/

RUN apt-get install -y php-pear
RUN apt-get install -y php-dev
RUN apt-get install -y pkg-config
RUN pecl install mongodb

RUN rm -rf /etc/php/7.0/apache2/php.ini
ADD config/php/php.ini /etc/php/7.0/apache2/

RUN rm -rf /etc/php/7.0/cgi/php.ini
ADD config/php/php.ini /etc/php/7.0/cgi/

RUN rm -rf /etc/php/7.0/cli/php.ini
ADD config/php/cli/php.ini /etc/php/7.0/cli/

RUN rm -rf /etc/php/7.0/mods-available/20-xdebug.ini
ADD config/php/20-xdebug.ini /etc/php/7.0/mods-available/

# Habilita o módulo do apache que trata as urls amigáveis
RUN a2enmod rewrite

# Remove o arquivo de configuração padrão do apache 
RUN rm -rf /etc/apache2/apache2.conf

# Adiciona o arquivo de configuração do apache com as alterações necessárias
ADD config/apache/apache2.conf /etc/apache2/

RUN php -r "readfile('https://getcomposer.org/installer');" | php; \
    mv composer.phar /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer

ADD config/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
CMD ["/usr/local/bin/start.sh"]
