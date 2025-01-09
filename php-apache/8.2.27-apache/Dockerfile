FROM php:8.2.27-apache

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
    openssh-server \
    freetds-dev \
    libmemcached-dev \
    libssl-dev \
    zlib1g-dev \
    poppler-utils \
    unrar-free \
    expect \
    wget

# Instala módulos oficias do PHP sem necessidade de configuração
RUN docker-php-ext-install -j$(nproc) soap  && \
    docker-php-ext-install -j$(nproc) pgsql && \
    docker-php-ext-install -j$(nproc) zip   && \
    docker-php-ext-install -j$(nproc) gd    && \ 
    docker-php-ext-install -j$(nproc) pdo   && \ 
    docker-php-ext-install -j$(nproc) pdo_pgsql && \
    docker-php-ext-install -j$(nproc) pdo_dblib && \
    docker-php-ext-install -j$(nproc) intl
    
# Instala módulos oficias do PHP com necessidade de configuração
RUN PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

# Instala módulos através do pecl
RUN pecl install mongodb
RUN pecl install imagick
RUN pecl install xdebug
RUN pecl install mcrypt
RUN pecl install memcached

# Habilita módulos
RUN docker-php-ext-enable mongodb && \
    docker-php-ext-enable imagick && \
    docker-php-ext-enable xdebug  && \
    docker-php-ext-enable mcrypt  && \
    docker-php-ext-enable memcached

# Habilita o módulo do apache que trata as urls amigáveis
RUN a2enmod rewrite
RUN a2enmod ssl

# Baixa o composer e cria o executável global
RUN php -r "readfile('https://getcomposer.org/installer');" | php; \
    mv composer.phar /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer

# Limpa a lista de pacotes
RUN rm -r /var/lib/apt/lists/*

# Configura o virtualhost
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default

# Configura o ssl
#COPY AtuaByNstech-RootCA.key /etc/ssl/private/.
#COPY AtuaByNstech-RootCA.crt /usr/local/share/ca-certificates/AtuaByNstech-RootCA.crt
#RUN update-ca-certificates
#COPY docker.local.crt /etc/ssl/certs/docker.local.crt
#COPY docker.local.key /etc/ssl/private/docker.local.key
#COPY vhost-ssl.conf /etc/apache2/sites-available/default-ssl.conf
#RUN a2ensite default-ssl
COPY ssl-ca-signed-install.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/ssl-ca-signed-install.sh
COPY ssl-self-signed-install.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/ssl-self-signed-install.sh

# Atualiza certificados CAs ICP-Brasil
COPY icp-brasil-install.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/icp-brasil-install.sh; \
    /usr/local/bin/icp-brasil-install.sh

# Seta o php.ini-development como principal 
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Copia as configurações necessárias
COPY config.ini $PHP_INI_DIR/conf.d/
COPY config-errors.ini $PHP_INI_DIR/conf.d/
COPY php-errors-enable.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/php-errors-enable.sh
COPY php-errors-disable.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/php-errors-disable.sh
COPY php-jit-enable.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/php-jit-enable.sh
COPY php-jit-disable.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/php-jit-disable.sh

# Seta uma senha para o usuário root para que seja possível acessar o container por ssh
RUN echo "root:root" | chpasswd

# Habilita criptografia legada (antiga) no openssl versão 3+ para que seja possível assinar xmls usando o xmlsec1
RUN cp /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf-old
RUN sed -i "s/# \[openssl_init\]/[openssl_init]/" /etc/ssl/openssl.cnf
RUN sed -i "s/# providers = provider_sect/providers = provider_sect/" /etc/ssl/openssl.cnf
RUN sed -i "s/# \[provider_sect\]/[provider_sect]/" /etc/ssl/openssl.cnf
RUN sed -i "s/# default = default_sect/default = default_sect\nlegacy = legacy_sect/" /etc/ssl/openssl.cnf
RUN sed -i -z "s/# \[default_sect\]\n# activate = 1/[default_sect]\nactivate = 1\n[legacy_sect]\nactivate = 1/" /etc/ssl/openssl.cnf

# Altera as configurações do ssh para permitir login como root
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config

# Habilita manipulação de PDF
RUN sed -i 's/  \(<policy.*"coder".*rights=\)"none"\(.*"PDF".*>\)/  \1"read|write"\2/' /etc/ImageMagick-6/policy.xml

# Configura xdebug
RUN echo "zend_extension=xdebug.so\n" \
         "xdebug.mode=debug\n" \
         "xdebug.start_with_request=yes\n" \
         "xdebug.discover_client_host=1\n" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Configura prompt git
COPY git-bash-install.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/git-bash-install.sh; \
    /usr/local/bin/git-bash-install.sh

RUN echo "alias cdhtml='cd /var/www/html'" >> /root/.bashrc
