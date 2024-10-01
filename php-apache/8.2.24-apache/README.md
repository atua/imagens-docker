## php-apache/8.2.24-apache

### Para criar a imagem
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout localhost.key -out localhost.crt -subj "/C=BR/ST=RioGrandeDoSul/L=PassoFundo/O=AtuaByNstech/CN=localhost"
    docker build -t atuadevops/php-apache:8.2.24-apache .
    docker login
    docker push atuadevops/php-apache:8.2.24-apache

### Para usar a imagem
    docker run --name php82 -h php82 -d -p 8082:80 -p 44382:443 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:8.2.24-apache
    docker exec -e XDEBUG_MODE=off -ti php82 bash
