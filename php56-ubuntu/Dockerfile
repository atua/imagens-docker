FROM ubuntu:15.10

RUN apt-get update
RUN apt-get install -y software-properties-common git vim

RUN apt-get update
RUN apt-get install --allow-unauthenticated -y apache2 libapache2-mod-php5
RUN apt-get install --allow-unauthenticated -y php5 php5-gd php5-cgi php5-curl php5-json php5-pgsql  
RUN apt-get install -y build-essential unzip xmlsec1 zip libxmlsec1 libxmlsec1-openssl
RUN apt-get install -y mcrypt

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postfix >> /dev/null || :
ADD config/postfix/filtro /etc/postfix/
ADD config/postfix/main.cf /etc/postfix/

RUN rm -rf /etc/php5/apache2/php.ini
ADD config/php/php.ini /etc/php5/apache2/

RUN rm -rf /etc/php5/cgi/php.ini
ADD config/php/php.ini /etc/php5/cgi/

RUN rm -rf /etc/php5/cli/php.ini
ADD config/php/cli/php.ini /etc/php5/cli/

RUN php -r "readfile('https://getcomposer.org/installer');" | php; mv composer.phar /usr/local/bin/composer; chmod +x /usr/local/bin/composer

ADD config/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
CMD ["/usr/local/bin/start.sh"]
