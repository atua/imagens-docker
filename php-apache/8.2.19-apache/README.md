## php-apache/8.2.19-apache

    docker build -t atuadevops/php-apache:8.2.19-apache .
    docker login
    docker push atuadevops/php-apache:8.2.19-apache

## 
    docker run --name php82 -h php82 -d -p 8082:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:8.2.19-apache
