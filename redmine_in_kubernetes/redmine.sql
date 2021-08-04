CREATE DATABASE redmine CHARACTER SET utf8mb4;
CREATE USER 'redmine'@'%' IDENTIFIED WITH mysql_native_password BY 'emptypassword';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'%';
