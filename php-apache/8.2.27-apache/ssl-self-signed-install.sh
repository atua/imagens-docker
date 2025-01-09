#!/bin/bash

if [ -z "$1" ]; then
  DOMINIO="docker.local"
else
  DOMINIO="$1"
fi

DIAS=3650

cd /tmp

openssl req -x509 -nodes -days ${DIAS} -newkey rsa:4096 -keyout ${DOMINIO}.key -out ${DOMINIO}.crt -subj "/C=BR/ST=RioGrandeDoSul/L=PassoFundo/O=AtuaByNstech/CN=${DOMINIO}"

cp -f ${DOMINIO}.crt /etc/ssl/certs/.
cp -f ${DOMINIO}.key /etc/ssl/private/.

printf "<VirtualHost *:443>
    DocumentRoot /var/www/html

    ServerName ${DOMINIO}
    SSLEngine on
    SSLCertificateFile \"/etc/ssl/certs/${DOMINIO}.crt\"
    SSLCertificateKeyFile \"/etc/ssl/private/${DOMINIO}.key\"

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
    <Directory \"/var/www/html\">
        Options All
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>" > /etc/apache2/sites-available/default-ssl.conf

a2ensite default-ssl
service apache2 reload

rm -f ${DOMINIO}.*
