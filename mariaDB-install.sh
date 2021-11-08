#!/bin/bash
# This Script automates the MariaDB Installation & Configuration Process needed for CM
clear

# Install and Start MariaDB
echo "Installing MariaDB...."
yum install -y mariadb mariadb-server
systemctl enable mariadb --now

# Performs Secure Installation
echo "Securing Installation of MariaDB....."
echo "
Y
cloudera
cloudera
Y
Y
Y
Y"| /usr/bin/mysql_secure_installation
echo "MariaDB secured!"


# Create Databases, Users and set Privileges
echo "Creating Databases, Users and setting Privileges....."
mysql -u root -pcloudera << SQL_COMMANDS
CREATE DATABASE scm;
CREATE DATABASE hive;
CREATE DATABASE oozie;
CREATE DATABASE hue;
CREATE DATABASE reportmanager;
CREATE USER 'hive'@'%' IDENTIFIED BY 'cloudera';
CREATE USER 'oozie'@'%' IDENTIFIED BY 'cloudera';
CREATE USER 'hue'@'%' IDENTIFIED BY 'cloudera';
CREATE USER 'rm'@'%' IDENTIFIED BY 'cloudera';
CREATE USER 'scm'@'%' IDENTIFIED BY 'cloudera';
GRANT ALL PRIVILEGES ON scm.* TO 'scm'@'%';
GRANT ALL PRIVILEGES ON hive.* TO 'hive'@'%';
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'%';
GRANT ALL PRIVILEGES ON hue.* TO 'hue'@'%';
GRANT ALL PRIVILEGES ON reportmanager.* TO 'rm'@'%';
FLUSH PRIVILEGES;
SQL_COMMANDS

echo "Done."
