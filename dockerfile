FROM ubuntu:16.04

RUN /usr/bin/apt-get update

RUN /usr/bin/apt-get --yes upgrade

RUN /usr/bin/apt-get --yes install language-pack-en-base software-properties-common

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN /usr/bin/apt-get --yes install \
    apache2 \
    binutils \
    build-essential \
    ca-certificates \
    curl \
    gettext \
    git \
    htop \
    libapache2-mod-php \
    libmysqlclient-dev \
    mariadb-client \
    mariadb-server \
    ncdu \
    nload \
    php \
    php-bcmath \
    php-bz2 \
    php-cgi \
    php-cli \
    php-common \
    php-curl \
    php-dba \
    php-dev \
    php-enchant \
    php-fpm \
    php-gd \
    php-gmp \
    php-imap \
    php-interbase \
    php-intl \
    php-json \
    php-ldap \
    php-mbstring \
    php-mcrypt \
    php-mysql \
    php-odbc \
    php-opcache \
    php-pgsql \
    php-phpdbg \
    php-pspell \
    php-readline \
    php-recode \
    php-soap \
    php-sqlite3 \
    php-sybase \
    php-tidy \
    php-xml \
    php-xmlrpc \
    php-xsl \
    php-zip \
    python3-pip \
    ssh \
    tmux \
    tree \
    unzip \
    vim \
    wget

RUN /usr/sbin/a2enmod php7.0 proxy proxy_fcgi rewrite

RUN /usr/sbin/phpenmod \
    bz2 \
    curl \
    dba \
    enchant \
    gd \
    gmp \
    imap \
    interbase \
    intl \
    json \
    ldap \
    mbstring \
    mcrypt \
    odbc \
    opcache \
    pgsql \
    pspell \
    readline \
    recode \
    soap \
    sqlite3 \
    tidy \
    xml \
    xmlrpc \
    xsl \
    zip

RUN /bin/mkdir --parents \
    /root/public_html \
    /var/lib/php/sessions \
    /var/lib/php/sessions/administrators \
    /var/lib/php/sessions/visitors

RUN /bin/echo 'root:root' | /usr/sbin/chpasswd

RUN /bin/chmod 755 /root /root/public_html

COPY files/etc/apache2/ports.conf /etc/apache2/ports.conf
COPY files/etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY files/etc/init.d/php7.0-fpm /etc/init.d/php7.0-fpm
COPY files/etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY files/etc/php/7.0/fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY files/etc/php/7.0/php.ini /etc/php/7.0/apache2/php.ini
COPY files/etc/php/7.0/php.ini /etc/php/7.0/cgi/php.ini
COPY files/etc/php/7.0/php.ini /etc/php/7.0/cli/php.ini
COPY files/etc/php/7.0/php.ini /etc/php/7.0/fpm/php.ini
COPY files/etc/php/7.0/php.ini /etc/php/7.0/phpdbg/php.ini
COPY files/etc/ssh/sshd_config /etc/ssh/sshd_config
COPY files/root/my.cnf /root/my.cnf
COPY files/root/run.sh /root/run.sh

RUN /bin/chmod 755 /etc/init.d/php7.0-fpm

RUN /usr/bin/touch /etc/development

RUN /usr/bin/curl \
    --show-error \
    --silent \
    https://getcomposer.org/installer \
    | \
    /usr/bin/php \
    -- \
    --filename=composer \
    --install-dir=/usr/local/bin

EXPOSE 80

ENV HOME /root

WORKDIR /root

ENTRYPOINT ["/bin/bash", "/root/run.sh"]
