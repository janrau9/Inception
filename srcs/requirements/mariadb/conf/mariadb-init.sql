CREATE DATABASE wordpress;
CREATE USER 'user1'@'%' IDENTIFIED BY 'password1';
GRANT ALL PRIVILEGES ON wordpress.* TO 'user1'@'%';
CREATE USER 'admin_user'@'%' IDENTIFIED BY 'securepassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'admin_user'@'%';
FLUSH PRIVILEGES;
