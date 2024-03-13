## php-apache/8.1.27-apache

    docker build -t atuadevops/php-apache:8.1.27-apache .
    docker login
    docker push atuadevops/php-apache:8.1.27-apache

## 
    docker run --name php81 -h php81 -d -p 8081:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:8.1.27-apache
