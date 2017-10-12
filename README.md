# Ubuntu 16.04 | PHP 5.6 | PHP 7

### PHP 5.6

    docker pull atuadevops/php:56
    docker run --name php56 -h php56 -d -p 8056:80 -v /etc/localtime:/etc/localtime:ro -v /var/www/html/:/var/www/html atuadevops/php:56


### PHP 7

    docker pull atuadevops/php:7
    docker run --name php7 -h php7 -d -p 8070:80 -v /etc/localtime:/etc/localtime:ro -v /var/www/html/:/var/www/html atuadevops/php:7
