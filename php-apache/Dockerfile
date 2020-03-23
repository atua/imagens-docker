FROM <PHPAPACHEIMAGE>

# Adiciona um usuário sem privilégios de root
RUN useradd -m nonroot --uid=1000

# Atualiza a lista de pacotes
RUN apt-get update

# Instala dependências
RUN apt-get install -y \
    vim \
    git \
    zip \
    libxml2-dev \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libc-client-dev \
    libkrb5-dev \
    xmlsec1 \
    openssh-server

# Instala módulos oficias do PHP sem necessidade de configuração
RUN docker-php-ext-install -j$(nproc) soap  && \
    docker-php-ext-install -j$(nproc) pgsql && \
    docker-php-ext-install -j$(nproc) zip   && \
    docker-php-ext-install -j$(nproc) gd    && \ 
    docker-php-ext-install -j$(nproc) pdo   && \ 
    docker-php-ext-install -j$(nproc) pdo_pgsql
    
# Instala módulos oficias do PHP com necessidade de configuração
RUN PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

# Instala módulos através do pecl
RUN pecl install mongodb && \
    pecl install imagick && \
    pecl install xdebug  && \
    pecl install mcrypt

# Habilita módulos
RUN docker-php-ext-enable mongodb && \
    docker-php-ext-enable imagick && \
    docker-php-ext-enable xdebug  && \
    docker-php-ext-enable mcrypt

# Habilita o módulo do apache que trata as urls amigáveis
RUN a2enmod rewrite

# Baixa o composer e cria o executável global
RUN php -r "readfile('https://getcomposer.org/installer');" | php; \
    mv composer.phar /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer

# Limpa a lista de pacotes
RUN rm -r /var/lib/apt/lists/*

# Configura o virtualhost
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf

# Seta o php.ini-development como principal 
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Copia as configurações necessárias
COPY ./config.ini $PHP_INI_DIR/conf.d/

# Seta uma senha para o usuário root para que seja possível acessar o container por ssh
RUN echo "root:root" | chpasswd

# Altera as configurações do ssh para permitir login como root
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config