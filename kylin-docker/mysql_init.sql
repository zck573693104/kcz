mysqld --user=root
SET PASSWORD FOR 'root'@'localhost'= "yier34wu6";
GRANT ALL PRIVILEGES ON *.* TO root@"%" IDENTIFIED BY "yier34wu6" WITH GRANT OPTION ;
FLUSH PRIVILEGES;
