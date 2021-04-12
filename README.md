## php-apache/7.4.16-apache

    docker run --name php74 -h php74 -d -p 8074:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:7.4.16-apache

## postgres/latest

    docker run --name postgres -d -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 atuadevops/postgres:latest
