# Instalación de Zabbix

Este script automatiza la instalación y configuración de Zabbix en un servidor Ubuntu 24.04.

## Prerrequisitos

Asegúrate de tener acceso root y una conexión a internet para instalar los paquetes necesarios.

## Pasos de Instalación

1. Clona este repositorio:
    ```bash
    git clone https://github.com/tu_usuario/zabbix-install.git
    cd zabbix-install
    ```

2. Haz ejecutable el script:
    ```bash
    chmod +x install_zabbix.sh
    ```

3. Ejecuta el script:
    ```bash
    ./install_zabbix.sh
    ```

4. Accede a la interfaz web:
    - Abre tu navegador y ve a `http://<tu_host>/zabbix`.

## Configuración

Durante la instalación, se crean las siguientes configuraciones:

- Base de datos:
  - Nombre: `zabbix`
  - Usuario: `zabbix`
  - Contraseña: `@Lasalle2599`

- Archivo de configuración: `/etc/zabbix/zabbix_server.conf`
  - Línea modificada: `DBPassword=password`

## Servicios

Los siguientes servicios se habilitan y configuran automáticamente:

- Apache
- MySQL
- Zabbix Server
- Zabbix Agent

## Notas

- Cambia `<tu_host>` en la URL por la dirección IP o el nombre de dominio de tu servidor.
- Por razones de seguridad, modifica la contraseña predeterminada de la base de datos después de la instalación.

