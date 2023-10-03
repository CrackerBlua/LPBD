CREATE DATABASE IF NOT EXISTS imobiliaria_bd;

USE imobiliaria_bd;

DROP TABLE tipo_registros;

CREATE TABLE IF NOT EXISTS tipo_registros(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(80) NOT NULL,
	developer_name VARCHAR(120) NOT NULL,
	table_object VARCHAR(80) NOT NULL,
	PRIMARY KEY(id, developer_name),
	INDEX(id, developer_name)
);
