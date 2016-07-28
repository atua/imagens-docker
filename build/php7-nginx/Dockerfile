FROM docker.io/ubuntu

RUN apt-get update
RUN apt-get install -y software-properties-common git vim
RUN add-apt-repository ppa:nginx/stable
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y nginx php7.0 php7.0-fpm php7.0-gd php7.0-cgi php7.0-curl php7.0-json
RUN apt-get install -y php7.0-mbstring php7.0-mcrypt php7.0-pgsql php7.0-soap php7.0-xml php7.0-zip
RUN apt-get install -y build-essential unzip xmlsec1 zip libxmlsec1 libxmlsec1-openssl

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postfix >> /dev/null || :
ADD config/postfix/filtro /etc/postfix/
ADD config/postfix/main.cf /etc/postfix/

RUN rm -rf /etc/nginx/sites-enabled/default
ADD config/nginx/default /etc/nginx/sites-enabled/

RUN rm -rf /etc/php/7.0/fpm/php.ini
ADD config/php/fpm/php.ini /etc/php/7.0/fpm/

RUN rm -rf /etc/php/7.0/cli/php.ini
ADD config/php/cli/php.ini /etc/php/7.0/cli/

RUN php -r "readfile('https://getcomposer.org/installer');" | php; mv composer.phar /usr/local/bin/composer; chmod +x /usr/local/bin/composer

ADD config/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
CMD ["/usr/local/bin/start.sh"]
