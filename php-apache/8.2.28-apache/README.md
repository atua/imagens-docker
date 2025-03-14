## php-apache/8.2.28-apache

### Para criar a imagem
    docker build -t atuadevops/php-apache:8.2.28-apache .
    docker login
    docker push atuadevops/php-apache:8.2.28-apache
### Para usar a imagem
    docker run --name php82 -h php82 -d -p 8082:80 -p 44382:443 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:8.2.28-apache
    docker exec -e XDEBUG_MODE=off -ti php82 bash
###### Opcional 1: definir um nome de domínio na sua máquina, exemplo "docker.local"
    echo "$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' php82) docker.local" | sudo tee -a /etc/hosts
###### Opcional 2.1: habilitar https com certificado auto-assinado
    [docker bash]# /usr/local/bin/ssl-self-signed-install.sh docker.local
###### Opcional 2.2: habilitar https com certificado assinado por CA local (evita mensagem de conexão insegura) (necessário fazer o Opcional 1)
    [docker bash]# /usr/local/bin/ssl-ca-signed-install.sh docker.local
