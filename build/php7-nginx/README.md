# Container docker PHP7 + Nginx

##Clone

    git clone https://github.com/evertonrobertoauler/php7-nginx.git
    cd php7-nginx

##Build

    docker build -t php7-nginx .
    
##Start

    docker run -d -p 80:80 -v /home/everton/programacao/php/atua:/var/www/html php7-nginx

##Bash

    docker exec -ti $(docker ps -q) /bin/bash

##Remover imagens antigas (nome == "<none>")

    docker rmi $(docker images | grep "<none>" | xargs -n 1 echo | egrep "\w{12}")
