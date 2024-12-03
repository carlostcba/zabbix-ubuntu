#!/bin/bash

# Actualizar y mejorar paquetes existentes
echo "Actualizando paquetes..."
sudo apt update && sudo apt upgrade -y

# Instalar dependencias
echo "Instalando dependencias necesarias..."
sudo apt install -y apache2 \
    php php-mysql php-gd php-bcmath php-mbstring php-xml php-ldap php-imap php-snmp php-json php-opcache php-intl \
    mysql-server

# Habilitar servicios Apache y MySQL
echo "Habilitando servicios Apache y MySQL..."
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl enable mysql
sudo systemctl start mysql

# Configurar el repositorio de Zabbix
echo "Configurando repositorio de Zabbix..."
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_latest_7.0+ubuntu24.04_all.deb
sudo apt update

# Instalar Zabbix
echo "Instalando Zabbix..."
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Configurar la base de datos MySQL
echo "Configurando base de datos MySQL para Zabbix..."
sudo mysql -e "CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
sudo mysql -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
sudo mysql -e "SET GLOBAL log_bin_trust_function_creators = 1;"

# Importar esquema de Zabbix
echo "Importando esquema de Zabbix..."
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p@Lasalle2599 zabbix

# Restaurar configuración de seguridad en MySQL
echo "Restaurando configuración de seguridad en MySQL..."
sudo mysql -e "SET GLOBAL log_bin_trust_function_creators = 0;"

# Configurar Zabbix Server
echo "Configurando Zabbix Server..."
sudo sed -i 's/^# DBPassword=/DBPassword=@Lasalle2599/' /etc/zabbix/zabbix_server.conf

# Reiniciar y habilitar servicios
echo "Reiniciando y habilitando servicios..."
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

echo "Instalación de Zabbix completada. Accede a http://<tu_host>/zabbix para finalizar la configuración."
