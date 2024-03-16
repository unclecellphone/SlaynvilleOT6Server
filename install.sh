sudo apt update && sudo apt upgrade -y
sudo apt install nginx php-fpm mariadb-server -y
sudo apt install phpmyadmin -y
sudo php -v
sudo apt install vim -y
sudo apt-get install git cmake build-essential liblua5.2-dev libgmp3-dev libmysqlclient-dev libboost-system-dev libboost-iostreams-dev libboost-filesystem-dev libpugixml-dev libcrypto++-dev libfmt-dev htop valgrind gdb

sudo apt-get update
sudo apt-get install libboost-all-dev

sudo vim /etc/nginx/sites-available/default


# add index.php to line 24
# uncomment the lines with fastcgi_pass unix:...php7.2-fpm.s
# uncomment lines with  location ~ \.php$ {
#               include snippets/fastcgi-php.conf;


