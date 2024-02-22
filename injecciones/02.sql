CREATE DATABASE SqlInjectionExample;

CREATE TABLE users (
    id INT(6) AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL
);

INSERT INTO users (id, login, password) VALUES (NULL, 'bill', '1234');
INSERT INTO users (id, login, password) VALUES (NULL, 'mark', '1111');

