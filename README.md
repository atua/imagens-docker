## PHP 5.6

    docker run --name php56 -h php56 -d -p 8056:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html atuadevops/php:56

## PHP 7

    docker run --name php7 -h php7 -d -p 8070:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html atuadevops/php:7

## PHP 7.3

    docker run --name php73 -h php73 -d -p 8073:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html atuadevops/php:73