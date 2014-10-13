/*
Department of Computer Engineering
University of Peradeniya
CO226 - Database Systems
Tutorial Number	: 1 
Topic       	: SQL 
Posted on      	: 2014-08-25
Due date       	: 2014-09-08
Submission   	: Submit your answers as a handwritten hard copy to the department.

Author			: Dhammika Marasinghe (E/11/258) 
*/

-- Question 1
/*
1.  Define the following terms:
	Data definition language, 
		language for defining data structures, especially database schemas.
	data manipulation language, 
		language used for selecting, inserting, deleting and updating data in a database.
	primary key, 
		primary key is a single field or combination of fields that uniquely defines a record.
	foreign key, 
		foreign key is a field (or collection of fields) in one table that uniquely identifies a row of another table. is used to establish and enforce a link between two tables.
	referential integrity, 
		Referential integrity is a concept for ensuring that relationships between database tables remain consistent. In other words, references to data must be valid
	correlated subquery, 
		Correlated Subquery is a sub-query that uses values from the outer query. 
	natural join, 
		A natural join is a type of equi-join where the join predicate arises implicitly by comparing all columns in both tables that have the same column-names in the joined tables. The resulting joined table contains only one column for each pair of equally named columns.
	view, 
		a view is a virtual table based on the result-set of an SQL statement. A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.
	trigger
		A trigger is a special kind of stored procedure that automatically executes when an event occurs in the database server. DML triggers execute when a user tries to modify data through a data manipulation language (DML) event.

2.  Explain the differences in ON UPDATE RESTRICT/CASCADE/SET NULL clauses.
	Example:
    ON UPDATE RESTRICT : the default : 
		if you try to update a company_id in table COMPANY the engine will reject the operation if one USER at least links on this company.
    ON UPDATE CASCADE : the best one usually : 
		if you update a company_id in a row of table COMPANY the engine will update it accordingly on all USER rows referencing this COMPANY (but no triggers activated on USER table, warning). The engine will track the changes for you, it's good.
    ON UPDATE SET NULL : 
		if you update a company_id in a row of table COMPANY the engine will set related USERs company_id to NULL (should be available in USER company_id field).

3.  What happens if the ON DELETE CASCADE clause is set?
	ON DELETE CASCADE : dangerous : 
		if you delete a company row in table COMPANY the engine will delete as well the related USERs. This is dangerous but can be used de make automatic cleanups on secondary tables (so it can be something you want, but quite certainly not for a COMPANY<->USER example)
*/

-- Question 2
/*
Consider a MySQL table containing drink information. 
DRINKS (ID, Drink_Name, Cost, Color, Ice, Calories) 
*/
  
CREATE TABLE DRINKS(
	ID INT PRIMARY KEY, 
	Drink_Name VARCHAR(20), 
	Cost FLOAT, 
	Color VARCHAR(15), 
	Ice CHAR(1), 
	Calories INT
);

-- Perform the following operations on the table DRINKS. 

-- 1.  Display the average calorie amount of a drink as Avg_Cal.
SELECT AVG(Calories) AS Avg_Cal 
FROM DRINKS;

-- 2.  Display the table according to the alphabetical order of the names and the increasing order of  the prices. 
SELECT * 
FROM DRINKS 
ORDER BY Drink_Name, Cost DESC;

-- 3.  Display only the information from third row to sixth row.
SELECT *
FROM DRINKS 
LIMIT 2,4;

-- 4.  Display the names, calories and cost of drinks that contain no more than 30 calories and cost more than Rs. 3.00.
SELECT Drink_Name, Calories, Cost 
FROM DRINKS 
WHERE Calories <= 30 AND Cost > 3;

-- 5.  Display the name and cost of drinks that start with the letter 'B' or that cost less than Rs. 3.00.
SELECT Drink_Name, Cost 
FROM DRINKS 
WHERE Drink_Name LIKE 'B%' OR Cost < 3;

-- 6.  Display the first two letters of each drink as First_Two_Letters.
SELECT LEFT(Drink_Name, 2) AS First_Two_Letters
FROM DRINKS ;

-- 7.  A person wants to buy one bottle from each drink. Display the total cost for the bottles.
SELECT SUM(Cost)
FROM DRINKS;

-- 8.  Rename the table to 'DRINK_INFO' and then change the column Drink_Name to Dname.
RENAME TABLE DRINKS TO DRINK_INFO;
ALTER TABLE DRINK_INFO CHANGE Drink_Name Dname VARCHAR(20);

-- 9.  Change drink color values from 'yellow' to 'gold'.
UPDATE DRINK_INFO 
SET Color = 'gold'
WHERE Color = 'yellow';

-- 10. Make all the drinks that cost Rs. 2.50 to be Rs. 3.50, and make all the drinks that cost Rs. 3.50 to be Rs. 4.50.
UPDATE DRINK_INFO 
SET Cost = 4.50
WHERE Cost = 2.50 OR Cost = 3.50;

-- Question 3
/*
Consider the following database schema.
CLIENTS(CID, Cname)
BRANCHES(BID, Bdesc, Bloc, Cid)
SERVICES(SID, Sname, Sfee)
BRANCHES_SERVICES(BID,SID)
 
Definitions for attributes are as follows.
CID,Cid : Client ID, Cname: Client name
BID: Branch id, Bdesc: Branch description, Bloc: Branch location,
SID: Service ID, Sname: Service name, Sfee: Service fee
*/

CREATE TABLE CLIENTS (
	CID INT,
	Cname VARCHAR(20),
	PRIMARY KEY (CID)
);
  
CREATE TABLE BRANCHES (
	BID INT,
	Bdesc VARCHAR(25),
	Bloc VARCHAR(25),
	CID INT,
	PRIMARY KEY (BID),
    FOREIGN KEY (CID)
		REFERENCES CLIENTS (CID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
	
CREATE TABLE SERVICES (
	SID INT,
	Sname VARCHAR(25),
	Sfee FLOAT,
	PRIMARY KEY (SID)
);

CREATE TABLE BRANCHES_SERVICES (
	BID INT,
	SID INT,
	PRIMARY KEY (BID, SID),
    FOREIGN KEY (BID)
		REFERENCES BRANCHES (BID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (SID)
		REFERENCES SERVICES (SID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);

-- Perform the following queries using both joins and subqueries. You may use the subqueries as specified.

-- 1. Joins or Subqueries within WHERE or HAVING Clause or both.
-- a)  List all branch offices belonging to the client, 'Rabbit Foods'.
SELECT Bdesc 
FROM BRANCHES NATURAL JOIN CLIENTS 
WHERE Cname = 'Rabbit Foods';

-- b)  List all services offered by the client 'SED Agency'.
SELECT Sname 
FROM BRANCHES_SERVICES NATURAL JOIN BRANCHES NATURAL JOIN CLIENTS NATURAL JOIN SERVICES 
WHERE Cname = 'SED Agency';

-- c)  List all clients having exactly two branch offices.
SELECT Cname
FROM BRANCHES NATURAL JOIN CLIENTS 
GROUP BY Cname
HAVING COUNT(BID) = 2;

-- d)  Find all clients charging a service fee that is the maximum service fee.
SELECT Cname 
FROM BRANCHES_SERVICES NATURAL JOIN BRANCHES NATURAL JOIN SERVICES NATURAL JOIN CLIENTS
WHERE Sfee = (SELECT MAX(Sfee) FROM SERVICES);

-- 2. Joins or Subqueries with Logical and Comparison Operators or both.
-- a)   Find all branches offering more than 50% of all available services.
SELECT Bdesc 
FROM BRANCHES_SERVICES NATURAL JOIN BRANCHES 
GROUP BY BID 
HAVING COUNT(SID) > (SELECT COUNT(*) FROM SERVICES)/2;

-- b)  Find all clients which are offering all available services across their branch offices.
SELECT Cname 
FROM BRANCHES_SERVICES NATURAL JOIN BRANCHES NATURAL JOIN CLIENTS
GROUP BY CID 
HAVING COUNT(SID) = (SELECT COUNT(*) FROM SERVICES);

-- 3. Joins or Subqueries with IN Membership Test or both.
-- a)  List all services offered by N Region HO branch office.
SELECT Sname 
FROM BRANCHES_SERVICES NATURAL JOIN SERVICES 
WHERE BID IN (SELECT BID FROM BRANCHES WHERE Bdesc = 'N Region HO');

-- b)   List all branches offering the Accounting service.
SELECT Bdesc 
FROM BRANCHES_SERVICES NATURAL JOIN SERVICES NATURAL JOIN BRANCHES 
WHERE Sname = 'Accounting';

-- c)  List all branches with their customer name offering the accounting service.
SELECT Cname, Bdesc 
FROM BRANCHES_SERVICES NATURAL JOIN SERVICES NATURAL JOIN BRANCHES NATURAL JOIN CLIENTS
WHERE Sname = 'Accounting';

-- d)  List all clients offering the Accounting services.
SELECT DISTINCT Cname
FROM BRANCHES_SERVICES NATURAL JOIN SERVICES NATURAL JOIN BRANCHES NATURAL JOIN CLIENTS
WHERE Sname = 'Accounting';

-- e)  List all branches that do not offer the Accounting service.
SELECT Bdesc 
FROM BRANCHES
WHERE BID NOT IN (
	SELECT BID 
	FROM BRANCHES_SERVICES NATURAL JOIN SERVICES
	WHERE Sname = 'Accounting');

-- 4. Joins or Subqueries with the EXISTS operator or both
-- a)  Check whether there are clients whose branches offering 5 or more services.
SELECT Cname 
FROM BRANCHES_SERVICES NATURAL JOIN BRANCHES NATURAL JOIN CLIENTS
GROUP BY CID
HAVING COUNT(SID) >= 5;

-- 5. Joins or Subqueries in the FROM Clause or both
-- a)  List average number of services offered by each branch.
SELECT Bdesc, AVG(SID) 
FROM BRANCHES_SERVICES NATURAL JOIN BRANCHES 
GROUP BY BID;

-- b)  List all branches offering services which is above the average number of services
SELECT Bdesc 
FROM BRANCHES_SERVICES NATURAL JOIN BRANCHES 
GROUP BY BID
HAVING AVG(SID) > (
	SELECT COUNT(SID)/COUNT(DISTINCT BID) 
	FROM BRANCHES_SERVICES);

-- 6. Both Joins and Subqueries
-- a)  List all clients, those do not have any branch, using a Left join and a subquery
SELECT Cname 
FROM CLIENTS LEFT JOIN BRANCHES ON CLIENTS.CID = BRANCHES.CID
WHERE BID IS NULL;

-- 7. Subqueries and Other DML Statements (UPDATE and DELETE)
-- a)  All branches located in California have decided to offer the security service instead of the administration service. Implement this change.
UPDATE BRANCHES_SERVICES 
SET SID = (SELECT SID FROM SERVICES WHERE Sname = 'Security') 
WHERE SID = (SELECT SID FROM SERVICES WHERE Sname = 'Administration') AND BID IN (SELECT BID FROM BRANCHES WHERE Bloc = 'California');

-- b)  Find out the services that are used by three or more branch offices and then increase the fee for those services by 25 percent.
UPDATE SERVICES 
SET Sfee = 1.25 * Sfee 
WHERE SID IN (
	SELECT SID 
	FROM BRANCHES_SERVICES
	GROUP BY SID
	HAVING COUNT(SID) >= 3); 

-- c)  Delete all branches using the Recruitment service.
DELETE 
FROM BRANCHES 
WHERE BID IN (
	SELECT BID 
	FROM BRANCHES_SERVICES NATURAL JOIN SERVICES
	WHERE Sname = 'Recruitment');
	
-- d)  Delete all clients any of whose branch offices generate service fee revenues of $500 or less.
DELETE 
FROM CLIENTS 
WHERE CID IN (
	SELECT DISTINCT CID 
	FROM BRANCHES_SERVICES NATURAL JOIN SERVICES NATURAL JOIN BRANCHES
	WHERE Sfee <= 500); 

	
/*
-- http://www.devshed.com/c/a/mysql/using-subqueries-in-mysql-part-1/

CREATE TABLE clients (
	cid tinyint(4) NOT NULL default '0',
	cname varchar(255) NOT NULL default "",
	PRIMARY KEY (cid)
);

CREATE TABLE services (
	sid tinyint(4) NOT NULL default '0',
	sname varchar(255) NOT NULL default "",
	sfee float(6,2) NOT NULL default '0.00',
	PRIMARY KEY (sid)
);

CREATE TABLE branches (
	bid int(8) NOT NULL default '0',
	cid tinyint(4) NOT NULL default '0',
	bdesc varchar(255) NOT NULL default "",
	bloc char(3) NOT NULL default ''
);

CREATE TABLE branches_services (
	bid int(8) NOT NULL default '0',
	sid tinyint(4) NOT NULL default '0'
);

INSERT INTO clients (cid, cname) VALUES (101, 'JV Real Estate'); 
INSERT INTO clients (cid, cname) VALUES (102, 'ABC Talent Agency'); 
INSERT INTO clients (cid, cname) VALUES (103, 'DMW Trading'); 
INSERT INTO clients (cid, cname) VALUES (104, 'Rabbit Foods Inc'); 
INSERT INTO clients (cid, cname) VALUES (110, 'Sharp Eyes Detective Agency');

INSERT INTO services (sid, sname, sfee) VALUES (1, 'Accounting', '1500.00');
INSERT INTO services (sid, sname, sfee) VALUES (2, 'Recruitment', '500.00'); 
INSERT INTO services (sid, sname, sfee) VALUES (3, 'Data Management', '300.00'); 
INSERT INTO services (sid, sname, sfee) VALUES (4, 'Administration', '500.00'); 
INSERT INTO services (sid, sname, sfee) VALUES (5, 'Customer Support', '2500.00'); 
INSERT INTO services (sid, sname, sfee) VALUES (6, 'Security', '600.00'); 

INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1011, 101, 'Corporate HQ', 'CA'); 
INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1012, 101, 'Accounting Department', 'NY'); 
INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1013, 101, 'Customer Grievances Department', 'KA'); 
INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1041, 104, 'Branch Office (East)', 'MA'); 
INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1042, 104, 'Branch Office (West)', 'CA'); 
INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1101, 110, 'Head Office', 'CA'); 
INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1031, 103, 'N Region HO', 'ME'); 
INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1032, 103, 'NE Region HO', 'CT'); 
INSERT INTO branches (bid, cid, bdesc, bloc) VALUES (1033, 103, 'NW Region HO', 'NY');

INSERT INTO branches_services (bid, sid) VALUES (1011, 1); 
INSERT INTO branches_services (bid, sid) VALUES (1011, 2); 
INSERT INTO branches_services (bid, sid) VALUES (1011, 3); 
INSERT INTO branches_services (bid, sid) VALUES (1011, 4); 
INSERT INTO branches_services (bid, sid) VALUES (1012, 1); 
INSERT INTO branches_services (bid, sid) VALUES (1013, 5); 
INSERT INTO branches_services (bid, sid) VALUES (1041, 1); 
INSERT INTO branches_services (bid, sid) VALUES (1041, 4); 
INSERT INTO branches_services (bid, sid) VALUES (1042, 1); 
INSERT INTO branches_services (bid, sid) VALUES (1042, 4); 
INSERT INTO branches_services (bid, sid) VALUES (1101, 1); 
INSERT INTO branches_services (bid, sid) VALUES (1031, 2); 
INSERT INTO branches_services (bid, sid) VALUES (1031, 3); 
INSERT INTO branches_services (bid, sid) VALUES (1031, 4); 
INSERT INTO branches_services (bid, sid) VALUES (1032, 3); 
INSERT INTO branches_services (bid, sid) VALUES (1033, 4);

*/