/*
 * CO226: lab 07 Views, Triggers, Stored Procedures (2014 fall)
 * Author: Marasinghe, M.M.D.B. (E/11/258)
 * Date:  2014-09-17 15:43:42  */

CREATE DATABASE IF NOT EXISTS e11258;
USE e11258;
 
-- Following table contains grade records of some final year students of a faculty.
 
-- 1) Create a table named Student to insert the above data. Determine a suitable primary key for this table. Populate your table with these data.

CREATE TABLE STUDENT (
	RegNo INT PRIMARY KEY,
	Name VARCHAR(20),
	GPA DECIMAL(3,2),
	ConRegNo INT 
);

INSERT INTO STUDENT(Name, RegNo, GPA) VALUES 
	('Sameera', 425, 3.25),
	('Kasun', 210, 3.40),
	('Kalpa', 201, 3.10),
	('Chathura', 312, 3.85),
	('Lakmali', 473, 3.75),
	('Sidath', 352, 3.30),
	('Kumudu', 111, 3.70),
	('Nalin', 456, 3.05),
	('Rohani', 324, 3.70),
	('Chithra' , 231, 3.30);

SELECT * 
FROM STUDENT ;
/*
+-------+----------+------+----------+
| RegNo | Name     | GPA  | ConRegNo |
+-------+----------+------+----------+
|   111 | Kumudu   | 3.70 |     NULL |
|   201 | Kalpa    | 3.10 |     NULL |
|   210 | Kasun    | 3.40 |     NULL |
|   231 | Chithra  | 3.30 |     NULL |
|   312 | Chathura | 3.85 |     NULL |
|   324 | Rohani   | 3.70 |     NULL |
|   352 | Sidath   | 3.30 |     NULL |
|   425 | Sameera  | 3.25 |     NULL |
|   456 | Nalin    | 3.05 |     NULL |
|   473 | Lakmali  | 3.75 |     NULL |
+-------+----------+------+----------+
10 rows in set (0.01 sec)

*/
-- 2) Create another table named Convocation to store the details about the registration to the convocation. Table should have fields to hold the Last Name, Address, Age, Registration Number and Convocation Registration Number of each student. The Convocation Registration Number is given when a student registers for the convocation. Determine a suitable primary key and a foreign key for this table.

CREATE TABLE CONVOCATION (
	ConRegNo INT PRIMARY KEY,
	RegNo INT,
	LastName VARCHAR(20),
	Address VARCHAR(50),
	Age INT,
	FOREIGN KEY (RegNo) REFERENCES STUDENT(RegNo)
);

-- 3) Create a stored procedure to store the details about the students as one student at a time in the Convocation table when they register for the convocation. (In the registration a unique convocation registration number should be given to each student and at the same time Convocation Registration Number column in the Student table should be updated by inserting relevant registration number for that student.)

ALTER TABLE CONVOCATION 
MODIFY ConRegNo INT AUTO_INCREMENT;

DELIMITER |
CREATE PROCEDURE Register(RegNo_ INT, LastName_ VARCHAR(20), Address_ VARCHAR(50),Age_ INT)
BEGIN
	INSERT INTO CONVOCATION(RegNo, LastName, Address, Age) 
	VALUES(RegNo_, LastName_, Address_, Age_);
	
	UPDATE STUDENT 
	SET ConRegNo = (SELECT MAX(ConRegNo) FROM CONVOCATION) 
	WHERE RegNo = RegNo_;
	
END 
| DELIMITER ;

-- 4) Perform the registration for Sameera, Chathura, Lakmali, Sidath and Nalin with registration numbers 1, 2, 3, 4 and 5 respectively. Give suitable meaningful values for the rest of the columns for each of these students. Observe the updates made to the Student table.

CALL Register(425, 'Dissawa', 'Pilimathalawa', 22);
CALL Register(312, 'Namal', 'Colombo', 23);
CALL Register(473, 'Kahawatta', 'Kandy', 27);
CALL Register(352, 'Padmisiri', 'Welimada', 21);
CALL Register(456, 'Madhawa', 'Bwela', 24);

/*
mysql> CALL Register(425, 'Dissawa', 'Pilimathalawa', 22);
Query OK, 1 row affected (0.00 sec)

mysql> CALL Register(312, 'Namal', 'Colombo', 23);
Query OK, 1 row affected (0.01 sec)

mysql> CALL Register(473, 'Kahawatta', 'Kandy', 27);
Query OK, 1 row affected (0.00 sec)

mysql> CALL Register(352, 'Padmisiri', 'Welimada', 21);
Query OK, 1 row affected (0.00 sec)

mysql> CALL Register(456, 'Madhawa', 'Bwela', 24);
Query OK, 1 row affected (0.00 sec)

*/

SELECT * 
FROM STUDENT ;
/*
+-------+----------+------+----------+
| RegNo | Name     | GPA  | ConRegNo |
+-------+----------+------+----------+
|   111 | Kumudu   | 3.70 |     NULL |
|   201 | Kalpa    | 3.10 |     NULL |
|   210 | Kasun    | 3.40 |     NULL |
|   231 | Chithra  | 3.30 |     NULL |
|   312 | Chathura | 3.85 |        2 |
|   324 | Rohani   | 3.70 |     NULL |
|   352 | Sidath   | 3.30 |        4 |
|   425 | Sameera  | 3.25 |        1 |
|   456 | Nalin    | 3.05 |        5 |
|   473 | Lakmali  | 3.75 |        3 |
+-------+----------+------+----------+
10 rows in set (0.00 sec)

*/

SELECT * 
FROM CONVOCATION ;
/*
+----------+-------+-----------+---------------+------+
| ConRegNo | RegNo | LastName  | Address       | Age  |
+----------+-------+-----------+---------------+------+
|        1 |   425 | Dissawa   | Pilimathalawa |   22 |
|        2 |   312 | Namal     | Colombo       |   23 |
|        3 |   473 | Kahawatta | Kandy         |   27 |
|        4 |   352 | Padmisiri | Welimada      |   21 |
|        5 |   456 | Madhawa   | Bwela         |   24 |
+----------+-------+-----------+---------------+------+
5 rows in set (0.00 sec)

*/

-- 5) Create a view called Registered to retrieve the details Name, Registration Number, GPA, Convocation Registration Number, Address and Age of those students who have registered for the convocation. Observe the view with the respective data.

CREATE VIEW Registered AS
	SELECT Name, S.RegNo, GPA, C.ConRegNo, Address, Age 
	FROM STUDENT S, CONVOCATION C 
	WHERE S.RegNo = C.RegNo AND C.ConRegNo IS NOT NULL ;
	
SELECT * 
FROM Registered ;
/*
+----------+-------+------+----------+---------------+------+
| Name     | RegNo | GPA  | ConRegNo | Address       | Age  |
+----------+-------+------+----------+---------------+------+
| Sameera  |   425 | 3.25 |        1 | Pilimathalawa |   22 |
| Chathura |   312 | 3.85 |        2 | Colombo       |   23 |
| Lakmali  |   473 | 3.75 |        3 | Kandy         |   27 |
| Sidath   |   352 | 3.30 |        4 | Welimada      |   21 |
| Nalin    |   456 | 3.05 |        5 | Bwela         |   24 |
+----------+-------+------+----------+---------------+------+
5 rows in set (0.00 sec)

*/

-- 6) Create a view called NotRegistered to retrieve the details Name, Registration Number, GPA, Address and Age of those students who have not registered for the convocation. Observe the view with the respective data.

-- Note: Address and Age are in CONVOCATION table, which is filling at the registration. Thus NotRegistered shouldn't get values from that table.

CREATE VIEW NotRegistered AS
	SELECT Name, RegNo, GPA 
	FROM STUDENT S
	WHERE ConRegNo IS NULL ;
	
SELECT * 
FROM NotRegistered ;
/*
+---------+-------+------+
| Name    | RegNo | GPA  |
+---------+-------+------+
| Kumudu  |   111 | 3.70 |
| Kalpa   |   201 | 3.10 |
| Kasun   |   210 | 3.40 |
| Chithra |   231 | 3.30 |
| Rohani  |   324 | 3.70 |
+---------+-------+------+
5 rows in set (0.00 sec)

*/

-- 7) Create a table called LateRegistration with the same columns as Convocation table to store the details about the students who do the late registration.

CREATE TABLE LateRegistration (
	ConRegNo INT PRIMARY KEY AUTO_INCREMENT,
	RegNo INT,
	LastName VARCHAR(20),
	Address VARCHAR(50),
	Age INT,
	FOREIGN KEY (RegNo) REFERENCES STUDENT(RegNo)
);

-- 8) Write a trigger to monitor the state of LateRegistration table, so that after a late registration is done in this table, the Student table should be updated with the relevant Convocation Registration Number for that student.

DELIMITER |
CREATE TRIGGER LateRegStateMonitor 
AFTER INSERT ON LateRegistration 
FOR EACH ROW 
	UPDATE STUDENT 
	SET ConRegNo = (SELECT MAX(ConRegNo) FROM LateRegistration) 
	WHERE RegNo = 
		(SELECT RegNo FROM LateRegistration 
		WHERE ConRegNo = (SELECT MAX(ConRegNo) FROM LateRegistration));
| DELIMITER ;

-- 9) Perform the registration for Kasun, Kalpa, Kumudu, Rohani and Chithra with registration numbers 6, 7, 8, 9 and 10 respectively. Give suitable meaningful values for the rest of the columns for each of these students. Observe the updates made to the Student table.

ALTER TABLE LateRegistration AUTO_INCREMENT = 6;

INSERT INTO LateRegistration VALUES 
	(6, 210, 'Kanchana', 'Dikarawa', 23), 
	(7, 201, 'Nadeeshan', 'Welimada', 19), 
	(8, 111, 'Wathsala', 'Colombo', 22), 
	(9, 324, 'Premalatha', 'Kinigama', 29), 
	(10, 231, 'Wajirapriya', 'Loonuwaththa', 26);
	
SELECT * 
FROM LateRegistration ;
/*
+----------+-------+-------------+--------------+------+
| ConRegNo | RegNo | LastName    | Address      | Age  |
+----------+-------+-------------+--------------+------+
|        6 |   210 | Kanchana    | Dikarawa     |   23 |
|        7 |   201 | Nadeeshan   | Welimada     |   19 |
|        8 |   111 | Wathsala    | Colombo      |   22 |
|        9 |   324 | Premalatha  | Kinigama     |   29 |
|       10 |   231 | Wajirapriya | Loonuwaththa |   26 |
+----------+-------+-------------+--------------+------+
5 rows in set (0.00 sec)

*/

SELECT * 
FROM STUDENT ;
/*
+-------+----------+------+----------+
| RegNo | Name     | GPA  | ConRegNo |
+-------+----------+------+----------+
|   111 | Kumudu   | 3.70 |        8 |
|   201 | Kalpa    | 3.10 |        7 |
|   210 | Kasun    | 3.40 |        6 |
|   231 | Chithra  | 3.30 |       10 |
|   312 | Chathura | 3.85 |        2 |
|   324 | Rohani   | 3.70 |        9 |
|   352 | Sidath   | 3.30 |        4 |
|   425 | Sameera  | 3.25 |        1 |
|   456 | Nalin    | 3.05 |        5 |
|   473 | Lakmali  | 3.75 |        3 |
+-------+----------+------+----------+
10 rows in set (0.00 sec)

*/

-- 10) Create a stored procedure to and fill the class column as follows.
-- a. GPA >=3.7 First class honors
-- b. GPA <3.7 and GPA>=3.3 Second class honors-upper division
-- c. GPA <3.3 and GPA>=2.7 Second class honors-lower division
-- d. GPA <2.7 and GPA>=2.0 Third class honors
-- Call the stored procedure which you created at this step and observe the class values assigned to each student.

ALTER TABLE STUDENT 
ADD COLUMN Class VARCHAR(40) ;

DELIMITER | 
CREATE PROCEDURE giveClass() 
BEGIN 
	UPDATE STUDENT 
	SET Class = CASE 
		WHEN GPA >=3.7 THEN 'First class honors' 
		WHEN GPA <3.7 AND GPA>=3.3 THEN 'Second class honors-upper division' 
		WHEN GPA <3.3 AND GPA>=2.7 THEN 'Second class honors-lower division' 
		WHEN GPA <2.7 AND GPA>=2.0 THEN 'Third class honors' 
		ELSE Class END; 
END
 | DELIMITER ;

CALL giveClass();

SELECT * 
FROM STUDENT ;
/*
+-------+----------+------+----------+------------------------------------+
| RegNo | Name     | GPA  | ConRegNo | Class                              |
+-------+----------+------+----------+------------------------------------+
|   111 | Kumudu   | 3.70 |        8 | First class honors                 |
|   201 | Kalpa    | 3.10 |        7 | Second class honors-lower division |
|   210 | Kasun    | 3.40 |        6 | Second class honors-upper division |
|   231 | Chithra  | 3.30 |       10 | Second class honors-upper division |
|   312 | Chathura | 3.85 |        2 | First class honors                 |
|   324 | Rohani   | 3.70 |        9 | First class honors                 |
|   352 | Sidath   | 3.30 |        4 | Second class honors-upper division |
|   425 | Sameera  | 3.25 |        1 | Second class honors-lower division |
|   456 | Nalin    | 3.05 |        5 | Second class honors-lower division |
|   473 | Lakmali  | 3.75 |        3 | First class honors                 |
+-------+----------+------+----------+------------------------------------+
10 rows in set (0.00 sec)

*/

