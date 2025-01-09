#!/bin/bash

if [ -z "$1" ]; then
  DOMINIO="docker.local"
else
  DOMINIO="$1"
fi

DIAS=3650

ORGANIZACAO="AtuaByNstech"
SENHA="123456"

cd /tmp

# gera chave privada e certificado do CA
if [ ! -f "/etc/ssl/private/${ORGANIZACAO}-RootCA.key" ]; then
  if openssl genrsa -aes256 -passout pass:${SENHA} -out /etc/ssl/private/${ORGANIZACAO}-RootCA.key 4096; then
    if openssl req -x509 -new -nodes -key /etc/ssl/private/${ORGANIZACAO}-RootCA.key -passin pass:${SENHA} -sha256 -days ${DIAS} -out /usr/local/share/ca-certificates/${ORGANIZACAO}-RootCA.crt -subj "/CN=${ORGANIZACAO} Root CA/C=BR/ST=Rio Grande do Sul/L=Passo Fundo/O=${ORGANIZACAO}"; then
      update-ca-certificates
    fi
  fi
fi


# gera certificado do domínio assinado pelo CA
openssl req -new -nodes -out ${DOMINIO}.csr -newkey rsa:4096 -keyout ${DOMINIO}.key -subj "/CN=${DOMINIO}/C=BR/ST=Rio Grande do Sul/L=Passo Fundo/O=${ORGANIZACAO}"
printf "authorityKeyIdentifier=keyid,issuer\nbasicConstraints=CA:FALSE\nkeyUsage=digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment\nextendedKeyUsage=serverAuth\nsubjectAltName=@alt_names\n[alt_names]\nDNS.1=${DOMINIO}" > ${DOMINIO}.ext
openssl x509 -req -in ${DOMINIO}.csr -CA /usr/local/share/ca-certificates/${ORGANIZACAO}-RootCA.crt -CAkey /etc/ssl/private/${ORGANIZACAO}-RootCA.key -passin pass:${SENHA} -CAcreateserial -out ${DOMINIO}.crt -days ${DIAS} -sha256 -extfile ${DOMINIO}.ext

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

echo
echo
echo "Importe o arquivo [/usr/local/share/ca-certificates/${ORGANIZACAO}-RootCA.crt] para os Certificados de Autoridade do seu navegador."
echo