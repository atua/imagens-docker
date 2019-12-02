## 7.3.12-apache

    docker run --name php73 -h php73 -d -p 8073:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:7.3.12-apache

## 7.4.0-apache

    docker run --name php74 -h php74 -d -p 8074:80 -e TZ=America/Sao_Paulo -v /var/www/html/:/var/www/html -w /var/www/html atuadevops/php-apache:7.4.0-apache

## docker exec

    # root
    docker exec -ti php74 /bin/bash

    # nonroot
    docker exec -ti --user=nonroot php74 /bin/bash
