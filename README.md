## php-apache/7.3.12-apache

    docker run --name php73 -h php73 -d -p 8073:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:7.3.12-apache

## php-apache/7.4.0-apache

    docker run --name php74 -h php74 -d -p 8074:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:7.4.0-apache

## postgres/latest

    docker run --name postgres -d -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data atuadevops/postgres:latest