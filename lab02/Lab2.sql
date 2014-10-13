CREATE DATABASE E11258Lab02;

USE E11258Lab02;

CREATE TABLE tshirt_order(
	order_number INT(10), 
	size CHAR(1), 
	colour CHAR(6), 
	cap CHAR(1), 
	wrist_band CHAR(1), 
	fname VARCHAR(20), 
	lname VARCHAR(20), 
	address1 VARCHAR(20), 
	address2 VARCHAR(20), 
	address3 VARCHAR(20), 
	comments TEXT, 
	PRIMARY KEY(order_number)
	);

INSERT INTO tshirt_order VALUES (1, 'L', 'Blue', 'Y', 'N', 'Dhammika', 'Marasinghe', 'Malwaththegama', 'Bambarapana', 'Sri Lanka', 'Nice shirt...');
INSERT INTO tshirt_order VALUES (2, 'M', 'Red', 'N', 'Y', 'Miyuru', 'Rajapaksha', 'Miyuru Wasa', 'Gampaha', 'Sri Lanka', 'wow...');

UPDATE tshirt_order SET colour='Green' WHERE order_number=2;

DELETE FROM tshirt_order WHERE order_number=2;
