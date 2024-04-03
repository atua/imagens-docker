## php-apache/8.3.3-apache

    docker build -t atuadevops/php-apache:8.3.3-apache .
    docker login
    docker push atuadevops/php-apache:8.3.3-apache

##
    docker run --name php83 -h php83 -d -p 8083:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:8.3.3-apache
