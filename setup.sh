#!/bin/bash

echo "---- Iniciando instalacao do ambiente de Desenvolvimento PHP 8 [Thiago Rocha]---"

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Definindo Senha padrao para o MySQL e suas ferramentas ---"

DEFAULTPASS="vagrant"
sudo debconf-set-selections <<EOF
mysql-server	mysql-server/root_password password $DEFAULTPASS
mysql-server	mysql-server/root_password_again password $DEFAULTPASS
dbconfig-common	dbconfig-common/mysql/app-pass password $DEFAULTPASS
dbconfig-common	dbconfig-common/mysql/admin-pass password $DEFAULTPASS
dbconfig-common	dbconfig-common/password-confirm password $DEFAULTPASS
dbconfig-common	dbconfig-common/app-password-confirm password $DEFAULTPASS
phpmyadmin		phpmyadmin/reconfigure-webserver multiselect apache2
phpmyadmin		phpmyadmin/dbconfig-install boolean true
phpmyadmin      phpmyadmin/app-password-confirm password $DEFAULTPASS 
phpmyadmin      phpmyadmin/mysql/admin-pass     password $DEFAULTPASS
phpmyadmin      phpmyadmin/password-confirm     password $DEFAULTPASS
phpmyadmin      phpmyadmin/setup-password       password $DEFAULTPASS
phpmyadmin      phpmyadmin/mysql/app-pass       password $DEFAULTPASS
EOF

echo "--- Instalando pacotes basicos ---"
sudo apt-get install software-properties-common vim curl python-software-properties git-core --assume-yes --force-yes

echo "--- Adicionando repositorio do pacote PHP ---"
sudo add-apt-repository ppa:ondrej/php

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Instalando MySQL, Phpmyadmin e alguns outros modulos ---"
sudo apt-get install mysql-server-5.5 mysql-client phpmyadmin --assume-yes --force-yes

echo "--- Instalando PHP, Apache e alguns modulos ---"
sudo apt-get install php8.1 php8.1-common --assume-yes --force-yes
sudo apt-get install php8.1-cli libapache2-mod-php8.1 php8.1-mysql php8.1-curl php-memcached php8.1-dev php8.1-mcrypt php8.1-sqlite3 php8.1-mbstring php*-mysql  php-gd php-xml php-mbstring  zip unzip --assume-yes --force-yes

echo "--- Habilitando o PHP 8 ---"
sudo a2dismod php5
sudo a2enmod php8.1

echo "--- Habilitando mod-rewrite do Apache ---"
sudo a2enmod rewrite

echo "--- Reiniciando Apache ---"
sudo service apache2 restart

echo "--- Baixando e Instalando Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "--- Instalando Banco NoSQL -> Redis <- ---" 
sudo apt-get install redis-server --assume-yes
sudo apt-get install php8.1-redis --assume-yes

# Instale apartir daqui o que você desejar 

echo "[OK] --- Ambiente de desenvolvimento concluido ---"
sudo apt-get install zip
sudo apt-get install unzip
