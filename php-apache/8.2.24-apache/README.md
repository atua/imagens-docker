## php-apache/8.2.24-apache

### Para criar a imagem
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout docker.local.key -out docker.local.crt -subj "/C=BR/ST=RioGrandeDoSul/L=PassoFundo/O=AtuaByNstech/CN=docker.local"
    docker build -t atuadevops/php-apache:8.2.24-apache .
    docker login
    docker push atuadevops/php-apache:8.2.24-apache

### Para usar a imagem
    echo "PUT_YOUR_DOCKER_IP_ADDRESS_HERE docker.local" | sudo tee -a /etc/hosts
    docker run --name php82 -h php82 -d -p 8082:80 -p 44382:443 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:8.2.24-apache
    docker exec -e XDEBUG_MODE=off -ti php82 bash
