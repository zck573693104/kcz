update user set password=password("123456");
CREATE USER 'scm'@'%' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON *.* TO  scm@"%" IDENTIFIED BY "123456";
update user set Password = password('123456') where User='scm';
GRANT ALL PRIVILEGES ON *.* TO root@"%" IDENTIFIED BY "123456" WITH GRANT OPTION ;
FLUSH PRIVILEGES;
