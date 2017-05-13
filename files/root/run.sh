if [ ! -f /var/lib/mysql/ibdata1 ]; then
    /usr/bin/mysql_install_db
    /etc/init.d/mysql start
    /usr/bin/mysqladmin --user=root password "root"
    /usr/bin/mysql --user=root --execute="GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION"
    /usr/bin/mysql --user=root --execute="FLUSH PRIVILEGES"
    /etc/init.d/mysql stop
fi
/bin/mkdir --parents /var/netenberg/fantastico_f3/sources/options
/bin/echo '/usr/sbin/apache2' > /var/netenberg/fantastico_f3/sources/options/apache.txt
/bin/echo '/usr/bin/mysql' > /var/netenberg/fantastico_f3/sources/options/mysql.txt
/bin/echo '/usr/bin/php' > /var/netenberg/fantastico_f3/sources/options/php.txt
/bin/echo 'user:/root:172.17.0.2:/root/public_html' > /var/netenberg/fantastico_f3/sources/options/users.txt
/etc/init.d/apache2 start
/etc/init.d/mysql start
/etc/init.d/php7.0-fpm start
/etc/init.d/ssh start
/bin/bash
