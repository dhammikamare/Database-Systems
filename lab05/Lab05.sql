/*
 * CO226: lab 05 Writing SQL Queries – Part I (2014 fall)
 * Author: Marasinghe, M.M.D.B. (E/11/258)
 * Date: 2014-08-13 15:15:13 
 */


-- Lab Task01

-- Creating a ‘Movie Rating’ database

DROP DATABASE IF EXISTS E11258Lab05;

CREATE DATABASE E11258Lab05;
 
USE E11258Lab05;

/*
-- If you want run in university pc using ur account

USE e11258;
 
DROP TABLE IF EXISTS RATING;
DROP TABLE IF EXISTS MOVIE;
DROP TABLE IF EXISTS REVIEWER;
*/

CREATE TABLE MOVIE(
	MovieID INT PRIMARY KEY,
	Title VARCHAR(45) NOT NULL,
	Year YEAR NOT NULL,
	Director VARCHAR(30)
);

CREATE TABLE REVIEWER(
	ReviewerID INT PRIMARY KEY,
	ReviewerName VARCHAR(30) NOT NULL
);

CREATE TABLE RATING(
	ReviewerID INT NOT NULL,
	MovieID INT NOT NULL,
	Stars INT(1) NOT NULL,
	RatingDate DATE,
	FOREIGN KEY (ReviewerID) REFERENCES REVIEWER(ReviewerID)
	ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (MovieID) REFERENCES MOVIE(MovieID)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

DESCRIBE MOVIE;
/*
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| MovieID  | int(11)     | NO   | PRI | NULL    |       |
| Title    | varchar(45) | NO   |     | NULL    |       |
| Year     | year(4)     | NO   |     | NULL    |       |
| Director | varchar(30) | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)
*/

DESCRIBE REVIEWER;
/*
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| ReviewerID   | int(11)     | NO   | PRI | NULL    |       |
| ReviewerName | varchar(30) | NO   |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)
*/

DESCRIBE RATING;
/*
+------------+---------+------+-----+---------+-------+
| Field      | Type    | Null | Key | Default | Extra |
+------------+---------+------+-----+---------+-------+
| ReviewerID | int(11) | NO   | MUL | NULL    |       |
| MovieID    | int(11) | NO   | MUL | NULL    |       |
| Stars      | int(1)  | NO   |     | NULL    |       |
| RatingDate | date    | YES  |     | NULL    |       |
+------------+---------+------+-----+---------+-------+
4 rows in set (0.00 sec)

*/

-- Populate a ‘Movie Rating’ database

INSERT INTO MOVIE VALUES 
	(101, 'Gone with the Wind', 1939, 'Victor Fleming'), 
	(102, 'Star Wars', 1977, 'George Lucas'), 
	(103, 'The Sound of Music', 1965, 'Robert Wise'), 
	(104, 'E.T.', 1982, 'Steven Spielberg'), 
	(105, 'Titanic', 1997, 'James Cameron'), 
	(106, 'Snow White', 1937, NULL), 
	(107, 'Avatar', 2009, 'James Cameron'), 
	(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

INSERT INTO REVIEWER VALUES
	(201, 'Sarah Martinez'),
	(202, 'Daniel Lewis'),
	(203, 'Brittany Harris'),
	(204, 'Mike Anderson'),
	(205, 'Chris Jackson'),
	(206, 'Elizabeth Thomas'),
	(207, 'James Cameron'),
	(208, 'Ashley White');

INSERT INTO RATING VALUES
	(201, 101, 2, '2011-01-22'),
	(201, 101, 4, '2011-01-27'),
	(202, 106, 4, NULL),
	(203, 103, 2, '2011-01-20'),
	(203, 108, 4, '2011-01-12'),
	(203, 108, 2, '2011-01-30'),
	(204, 101, 3, '2011-01-09'),
	(205, 103, 3, '2011-01-27'),
	(205, 104, 2, '2011-01-22'),
	(205, 108, 4, NULL),
	(206, 107, 3, '2011-01-15'),
	(206, 106, 5, '2011-01-19'),
	(207, 107, 5, '2011-01-20'),
	(208, 104, 3, '2011-01-02');

-- Lab Task02

-- Quering through ‘Movie Rating’ database

-- 1. Find all the details about the movies presented in the populated MOVIE table.

SELECT * 
FROM MOVIE;
/*
+---------+-------------------------+------+------------------+
| MovieID | Title                   | Year | Director         |
+---------+-------------------------+------+------------------+
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |
|     102 | Star Wars               | 1977 | George Lucas     |
|     103 | The Sound of Music      | 1965 | Robert Wise      |
|     104 | E.T.                    | 1982 | Steven Spielberg |
|     105 | Titanic                 | 1997 | James Cameron    |
|     106 | Snow White              | 1937 | NULL             |
|     107 | Avatar                  | 2009 | James Cameron    |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |
+---------+-------------------------+------+------------------+
8 rows in set (0.00 sec)

*/

-- 2. Find all the details about the movies directed by ‘James Cameron’.

SELECT * 
FROM MOVIE 
WHERE Director = 'James Cameron';
/*
+---------+---------+------+---------------+
| MovieID | Title   | Year | Director      |
+---------+---------+------+---------------+
|     105 | Titanic | 1997 | James Cameron |
|     107 | Avatar  | 2009 | James Cameron |
+---------+---------+------+---------------+
2 rows in set (0.00 sec)

*/

-- 3. Find all the details about the movies directed by ‘James Cameron’, on or after year 2000.

SELECT * 
FROM MOVIE 
WHERE Director = 'James Cameron' AND Year >= 2000;
/*
+---------+--------+------+---------------+
| MovieID | Title  | Year | Director      |
+---------+--------+------+---------------+
|     107 | Avatar | 2009 | James Cameron |
+---------+--------+------+---------------+
1 row in set (0.00 sec)

*/

-- 4. Find all the stars presented in the rating table.

SELECT Stars 
FROM RATING;
/*
+-------+
| Stars |
+-------+
|     2 |
|     4 |
|     4 |
|     2 |
|     4 |
|     2 |
|     3 |
|     3 |
|     2 |
|     4 |
|     3 |
|     5 |
|     5 |
|     3 |
+-------+
14 rows in set (0.00 sec)

*/

-- 5. Find the distinct stars presented in the table.

SELECT DISTINCT Stars 
FROM RATING;
/*
+-------+
| Stars |
+-------+
|     2 |
|     4 |
|     3 |
|     5 |
+-------+
4 rows in set (0.00 sec)

*/

-- 6. Find movie ids and each movie’s director.

SELECT MovieID, Director 
FROM MOVIE;
/*
+---------+------------------+
| MovieID | Director         |
+---------+------------------+
|     101 | Victor Fleming   |
|     102 | George Lucas     |
|     103 | Robert Wise      |
|     104 | Steven Spielberg |
|     105 | James Cameron    |
|     106 | NULL             |
|     107 | James Cameron    |
|     108 | Steven Spielberg |
+---------+------------------+
8 rows in set (0.00 sec)

*/

-- 7. Find movie ids, titles, years of the movies directed by ‘Steven Spielberg’.

SELECT MovieID, Title, Year 
FROM MOVIE 
WHERE Director = 'Steven Spielberg';
/*
+---------+-------------------------+------+
| MovieID | Title                   | Year |
+---------+-------------------------+------+
|     104 | E.T.                    | 1982 |
|     108 | Raiders of the Lost Ark | 1981 |
+---------+-------------------------+------+
2 rows in set (0.00 sec)

*/

-- 8. Obtain the Cartesian product of the details presented in two tables MOVIE and RATING.

SELECT * 
FROM MOVIE, RATING;
/*
+---------+-------------------------+------+------------------+------------+---------+-------+------------+
| MovieID | Title                   | Year | Director         | ReviewerID | MovieID | Stars | RatingDate |
+---------+-------------------------+------+------------------+------------+---------+-------+------------+
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        201 |     101 |     2 | 2011-01-22 |
|     102 | Star Wars               | 1977 | George Lucas     |        201 |     101 |     2 | 2011-01-22 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        201 |     101 |     2 | 2011-01-22 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        201 |     101 |     2 | 2011-01-22 |
|     105 | Titanic                 | 1997 | James Cameron    |        201 |     101 |     2 | 2011-01-22 |
|     106 | Snow White              | 1937 | NULL             |        201 |     101 |     2 | 2011-01-22 |
|     107 | Avatar                  | 2009 | James Cameron    |        201 |     101 |     2 | 2011-01-22 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        201 |     101 |     2 | 2011-01-22 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        201 |     101 |     4 | 2011-01-27 |
|     102 | Star Wars               | 1977 | George Lucas     |        201 |     101 |     4 | 2011-01-27 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        201 |     101 |     4 | 2011-01-27 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        201 |     101 |     4 | 2011-01-27 |
|     105 | Titanic                 | 1997 | James Cameron    |        201 |     101 |     4 | 2011-01-27 |
|     106 | Snow White              | 1937 | NULL             |        201 |     101 |     4 | 2011-01-27 |
|     107 | Avatar                  | 2009 | James Cameron    |        201 |     101 |     4 | 2011-01-27 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        201 |     101 |     4 | 2011-01-27 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        202 |     106 |     4 | NULL       |
|     102 | Star Wars               | 1977 | George Lucas     |        202 |     106 |     4 | NULL       |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        202 |     106 |     4 | NULL       |
|     104 | E.T.                    | 1982 | Steven Spielberg |        202 |     106 |     4 | NULL       |
|     105 | Titanic                 | 1997 | James Cameron    |        202 |     106 |     4 | NULL       |
|     106 | Snow White              | 1937 | NULL             |        202 |     106 |     4 | NULL       |
|     107 | Avatar                  | 2009 | James Cameron    |        202 |     106 |     4 | NULL       |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        202 |     106 |     4 | NULL       |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        203 |     103 |     2 | 2011-01-20 |
|     102 | Star Wars               | 1977 | George Lucas     |        203 |     103 |     2 | 2011-01-20 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        203 |     103 |     2 | 2011-01-20 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        203 |     103 |     2 | 2011-01-20 |
|     105 | Titanic                 | 1997 | James Cameron    |        203 |     103 |     2 | 2011-01-20 |
|     106 | Snow White              | 1937 | NULL             |        203 |     103 |     2 | 2011-01-20 |
|     107 | Avatar                  | 2009 | James Cameron    |        203 |     103 |     2 | 2011-01-20 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        203 |     103 |     2 | 2011-01-20 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        203 |     108 |     4 | 2011-01-12 |
|     102 | Star Wars               | 1977 | George Lucas     |        203 |     108 |     4 | 2011-01-12 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        203 |     108 |     4 | 2011-01-12 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        203 |     108 |     4 | 2011-01-12 |
|     105 | Titanic                 | 1997 | James Cameron    |        203 |     108 |     4 | 2011-01-12 |
|     106 | Snow White              | 1937 | NULL             |        203 |     108 |     4 | 2011-01-12 |
|     107 | Avatar                  | 2009 | James Cameron    |        203 |     108 |     4 | 2011-01-12 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        203 |     108 |     4 | 2011-01-12 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        203 |     108 |     2 | 2011-01-30 |
|     102 | Star Wars               | 1977 | George Lucas     |        203 |     108 |     2 | 2011-01-30 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        203 |     108 |     2 | 2011-01-30 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        203 |     108 |     2 | 2011-01-30 |
|     105 | Titanic                 | 1997 | James Cameron    |        203 |     108 |     2 | 2011-01-30 |
|     106 | Snow White              | 1937 | NULL             |        203 |     108 |     2 | 2011-01-30 |
|     107 | Avatar                  | 2009 | James Cameron    |        203 |     108 |     2 | 2011-01-30 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        203 |     108 |     2 | 2011-01-30 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        204 |     101 |     3 | 2011-01-09 |
|     102 | Star Wars               | 1977 | George Lucas     |        204 |     101 |     3 | 2011-01-09 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        204 |     101 |     3 | 2011-01-09 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        204 |     101 |     3 | 2011-01-09 |
|     105 | Titanic                 | 1997 | James Cameron    |        204 |     101 |     3 | 2011-01-09 |
|     106 | Snow White              | 1937 | NULL             |        204 |     101 |     3 | 2011-01-09 |
|     107 | Avatar                  | 2009 | James Cameron    |        204 |     101 |     3 | 2011-01-09 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        204 |     101 |     3 | 2011-01-09 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        205 |     103 |     3 | 2011-01-27 |
|     102 | Star Wars               | 1977 | George Lucas     |        205 |     103 |     3 | 2011-01-27 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        205 |     103 |     3 | 2011-01-27 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        205 |     103 |     3 | 2011-01-27 |
|     105 | Titanic                 | 1997 | James Cameron    |        205 |     103 |     3 | 2011-01-27 |
|     106 | Snow White              | 1937 | NULL             |        205 |     103 |     3 | 2011-01-27 |
|     107 | Avatar                  | 2009 | James Cameron    |        205 |     103 |     3 | 2011-01-27 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        205 |     103 |     3 | 2011-01-27 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        205 |     104 |     2 | 2011-01-22 |
|     102 | Star Wars               | 1977 | George Lucas     |        205 |     104 |     2 | 2011-01-22 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        205 |     104 |     2 | 2011-01-22 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        205 |     104 |     2 | 2011-01-22 |
|     105 | Titanic                 | 1997 | James Cameron    |        205 |     104 |     2 | 2011-01-22 |
|     106 | Snow White              | 1937 | NULL             |        205 |     104 |     2 | 2011-01-22 |
|     107 | Avatar                  | 2009 | James Cameron    |        205 |     104 |     2 | 2011-01-22 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        205 |     104 |     2 | 2011-01-22 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        205 |     108 |     4 | NULL       |
|     102 | Star Wars               | 1977 | George Lucas     |        205 |     108 |     4 | NULL       |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        205 |     108 |     4 | NULL       |
|     104 | E.T.                    | 1982 | Steven Spielberg |        205 |     108 |     4 | NULL       |
|     105 | Titanic                 | 1997 | James Cameron    |        205 |     108 |     4 | NULL       |
|     106 | Snow White              | 1937 | NULL             |        205 |     108 |     4 | NULL       |
|     107 | Avatar                  | 2009 | James Cameron    |        205 |     108 |     4 | NULL       |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        205 |     108 |     4 | NULL       |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        206 |     107 |     3 | 2011-01-15 |
|     102 | Star Wars               | 1977 | George Lucas     |        206 |     107 |     3 | 2011-01-15 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        206 |     107 |     3 | 2011-01-15 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        206 |     107 |     3 | 2011-01-15 |
|     105 | Titanic                 | 1997 | James Cameron    |        206 |     107 |     3 | 2011-01-15 |
|     106 | Snow White              | 1937 | NULL             |        206 |     107 |     3 | 2011-01-15 |
|     107 | Avatar                  | 2009 | James Cameron    |        206 |     107 |     3 | 2011-01-15 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        206 |     107 |     3 | 2011-01-15 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        206 |     106 |     5 | 2011-01-19 |
|     102 | Star Wars               | 1977 | George Lucas     |        206 |     106 |     5 | 2011-01-19 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        206 |     106 |     5 | 2011-01-19 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        206 |     106 |     5 | 2011-01-19 |
|     105 | Titanic                 | 1997 | James Cameron    |        206 |     106 |     5 | 2011-01-19 |
|     106 | Snow White              | 1937 | NULL             |        206 |     106 |     5 | 2011-01-19 |
|     107 | Avatar                  | 2009 | James Cameron    |        206 |     106 |     5 | 2011-01-19 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        206 |     106 |     5 | 2011-01-19 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        207 |     107 |     5 | 2011-01-20 |
|     102 | Star Wars               | 1977 | George Lucas     |        207 |     107 |     5 | 2011-01-20 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        207 |     107 |     5 | 2011-01-20 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        207 |     107 |     5 | 2011-01-20 |
|     105 | Titanic                 | 1997 | James Cameron    |        207 |     107 |     5 | 2011-01-20 |
|     106 | Snow White              | 1937 | NULL             |        207 |     107 |     5 | 2011-01-20 |
|     107 | Avatar                  | 2009 | James Cameron    |        207 |     107 |     5 | 2011-01-20 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        207 |     107 |     5 | 2011-01-20 |
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |        208 |     104 |     3 | 2011-01-02 |
|     102 | Star Wars               | 1977 | George Lucas     |        208 |     104 |     3 | 2011-01-02 |
|     103 | The Sound of Music      | 1965 | Robert Wise      |        208 |     104 |     3 | 2011-01-02 |
|     104 | E.T.                    | 1982 | Steven Spielberg |        208 |     104 |     3 | 2011-01-02 |
|     105 | Titanic                 | 1997 | James Cameron    |        208 |     104 |     3 | 2011-01-02 |
|     106 | Snow White              | 1937 | NULL             |        208 |     104 |     3 | 2011-01-02 |
|     107 | Avatar                  | 2009 | James Cameron    |        208 |     104 |     3 | 2011-01-02 |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |        208 |     104 |     3 | 2011-01-02 |
+---------+-------------------------+------+------------------+------------+---------+-------+------------+
112 rows in set (0.00 sec)

*/
-- 9. Obtain the Cartesian product of the movie id and title from MOVIE table with movie id, reviewer id and stars from RATING table.

SELECT  MOVIE.MovieID, Title, RATING.MovieID, ReviewerID, Stars
FROM RATING, MOVIE;
/*
+---------+-------------------------+---------+------------+-------+
| MovieID | Title                   | MovieID | ReviewerID | Stars |
+---------+-------------------------+---------+------------+-------+
|     101 | Gone with the Wind      |     101 |        201 |     2 |
|     102 | Star Wars               |     101 |        201 |     2 |
|     103 | The Sound of Music      |     101 |        201 |     2 |
|     104 | E.T.                    |     101 |        201 |     2 |
|     105 | Titanic                 |     101 |        201 |     2 |
|     106 | Snow White              |     101 |        201 |     2 |
|     107 | Avatar                  |     101 |        201 |     2 |
|     108 | Raiders of the Lost Ark |     101 |        201 |     2 |
|     101 | Gone with the Wind      |     101 |        201 |     4 |
|     102 | Star Wars               |     101 |        201 |     4 |
|     103 | The Sound of Music      |     101 |        201 |     4 |
|     104 | E.T.                    |     101 |        201 |     4 |
|     105 | Titanic                 |     101 |        201 |     4 |
|     106 | Snow White              |     101 |        201 |     4 |
|     107 | Avatar                  |     101 |        201 |     4 |
|     108 | Raiders of the Lost Ark |     101 |        201 |     4 |
|     101 | Gone with the Wind      |     106 |        202 |     4 |
|     102 | Star Wars               |     106 |        202 |     4 |
|     103 | The Sound of Music      |     106 |        202 |     4 |
|     104 | E.T.                    |     106 |        202 |     4 |
|     105 | Titanic                 |     106 |        202 |     4 |
|     106 | Snow White              |     106 |        202 |     4 |
|     107 | Avatar                  |     106 |        202 |     4 |
|     108 | Raiders of the Lost Ark |     106 |        202 |     4 |
|     101 | Gone with the Wind      |     103 |        203 |     2 |
|     102 | Star Wars               |     103 |        203 |     2 |
|     103 | The Sound of Music      |     103 |        203 |     2 |
|     104 | E.T.                    |     103 |        203 |     2 |
|     105 | Titanic                 |     103 |        203 |     2 |
|     106 | Snow White              |     103 |        203 |     2 |
|     107 | Avatar                  |     103 |        203 |     2 |
|     108 | Raiders of the Lost Ark |     103 |        203 |     2 |
|     101 | Gone with the Wind      |     108 |        203 |     4 |
|     102 | Star Wars               |     108 |        203 |     4 |
|     103 | The Sound of Music      |     108 |        203 |     4 |
|     104 | E.T.                    |     108 |        203 |     4 |
|     105 | Titanic                 |     108 |        203 |     4 |
|     106 | Snow White              |     108 |        203 |     4 |
|     107 | Avatar                  |     108 |        203 |     4 |
|     108 | Raiders of the Lost Ark |     108 |        203 |     4 |
|     101 | Gone with the Wind      |     108 |        203 |     2 |
|     102 | Star Wars               |     108 |        203 |     2 |
|     103 | The Sound of Music      |     108 |        203 |     2 |
|     104 | E.T.                    |     108 |        203 |     2 |
|     105 | Titanic                 |     108 |        203 |     2 |
|     106 | Snow White              |     108 |        203 |     2 |
|     107 | Avatar                  |     108 |        203 |     2 |
|     108 | Raiders of the Lost Ark |     108 |        203 |     2 |
|     101 | Gone with the Wind      |     101 |        204 |     3 |
|     102 | Star Wars               |     101 |        204 |     3 |
|     103 | The Sound of Music      |     101 |        204 |     3 |
|     104 | E.T.                    |     101 |        204 |     3 |
|     105 | Titanic                 |     101 |        204 |     3 |
|     106 | Snow White              |     101 |        204 |     3 |
|     107 | Avatar                  |     101 |        204 |     3 |
|     108 | Raiders of the Lost Ark |     101 |        204 |     3 |
|     101 | Gone with the Wind      |     103 |        205 |     3 |
|     102 | Star Wars               |     103 |        205 |     3 |
|     103 | The Sound of Music      |     103 |        205 |     3 |
|     104 | E.T.                    |     103 |        205 |     3 |
|     105 | Titanic                 |     103 |        205 |     3 |
|     106 | Snow White              |     103 |        205 |     3 |
|     107 | Avatar                  |     103 |        205 |     3 |
|     108 | Raiders of the Lost Ark |     103 |        205 |     3 |
|     101 | Gone with the Wind      |     104 |        205 |     2 |
|     102 | Star Wars               |     104 |        205 |     2 |
|     103 | The Sound of Music      |     104 |        205 |     2 |
|     104 | E.T.                    |     104 |        205 |     2 |
|     105 | Titanic                 |     104 |        205 |     2 |
|     106 | Snow White              |     104 |        205 |     2 |
|     107 | Avatar                  |     104 |        205 |     2 |
|     108 | Raiders of the Lost Ark |     104 |        205 |     2 |
|     101 | Gone with the Wind      |     108 |        205 |     4 |
|     102 | Star Wars               |     108 |        205 |     4 |
|     103 | The Sound of Music      |     108 |        205 |     4 |
|     104 | E.T.                    |     108 |        205 |     4 |
|     105 | Titanic                 |     108 |        205 |     4 |
|     106 | Snow White              |     108 |        205 |     4 |
|     107 | Avatar                  |     108 |        205 |     4 |
|     108 | Raiders of the Lost Ark |     108 |        205 |     4 |
|     101 | Gone with the Wind      |     107 |        206 |     3 |
|     102 | Star Wars               |     107 |        206 |     3 |
|     103 | The Sound of Music      |     107 |        206 |     3 |
|     104 | E.T.                    |     107 |        206 |     3 |
|     105 | Titanic                 |     107 |        206 |     3 |
|     106 | Snow White              |     107 |        206 |     3 |
|     107 | Avatar                  |     107 |        206 |     3 |
|     108 | Raiders of the Lost Ark |     107 |        206 |     3 |
|     101 | Gone with the Wind      |     106 |        206 |     5 |
|     102 | Star Wars               |     106 |        206 |     5 |
|     103 | The Sound of Music      |     106 |        206 |     5 |
|     104 | E.T.                    |     106 |        206 |     5 |
|     105 | Titanic                 |     106 |        206 |     5 |
|     106 | Snow White              |     106 |        206 |     5 |
|     107 | Avatar                  |     106 |        206 |     5 |
|     108 | Raiders of the Lost Ark |     106 |        206 |     5 |
|     101 | Gone with the Wind      |     107 |        207 |     5 |
|     102 | Star Wars               |     107 |        207 |     5 |
|     103 | The Sound of Music      |     107 |        207 |     5 |
|     104 | E.T.                    |     107 |        207 |     5 |
|     105 | Titanic                 |     107 |        207 |     5 |
|     106 | Snow White              |     107 |        207 |     5 |
|     107 | Avatar                  |     107 |        207 |     5 |
|     108 | Raiders of the Lost Ark |     107 |        207 |     5 |
|     101 | Gone with the Wind      |     104 |        208 |     3 |
|     102 | Star Wars               |     104 |        208 |     3 |
|     103 | The Sound of Music      |     104 |        208 |     3 |
|     104 | E.T.                    |     104 |        208 |     3 |
|     105 | Titanic                 |     104 |        208 |     3 |
|     106 | Snow White              |     104 |        208 |     3 |
|     107 | Avatar                  |     104 |        208 |     3 |
|     108 | Raiders of the Lost Ark |     104 |        208 |     3 |
+---------+-------------------------+---------+------------+-------+
112 rows in set (0.00 sec)

*/

-- 10. Select movie ids of each movie with its title, reviewer id and stars received.

SELECT  MOVIE.MovieID, Title, ReviewerID, Stars
FROM RATING, MOVIE
WHERE MOVIE.MovieID = RATING.MovieID;
/*
+---------+-------------------------+------------+-------+
| MovieID | Title                   | ReviewerID | Stars |
+---------+-------------------------+------------+-------+
|     101 | Gone with the Wind      |        201 |     2 |
|     101 | Gone with the Wind      |        201 |     4 |
|     101 | Gone with the Wind      |        204 |     3 |
|     103 | The Sound of Music      |        203 |     2 |
|     103 | The Sound of Music      |        205 |     3 |
|     104 | E.T.                    |        205 |     2 |
|     104 | E.T.                    |        208 |     3 |
|     106 | Snow White              |        202 |     4 |
|     106 | Snow White              |        206 |     5 |
|     107 | Avatar                  |        206 |     3 |
|     107 | Avatar                  |        207 |     5 |
|     108 | Raiders of the Lost Ark |        203 |     4 |
|     108 | Raiders of the Lost Ark |        203 |     2 |
|     108 | Raiders of the Lost Ark |        205 |     4 |
+---------+-------------------------+------------+-------+
14 rows in set (0.00 sec)

*/

-- 11. Select movie ids of each movie with its title, reviewer id and stars received, where number of stars are less than or equal to three.

SELECT  MOVIE.MovieID, Title, ReviewerID, Stars
FROM RATING, MOVIE
WHERE MOVIE.MovieID = RATING.MovieID AND Stars <= 3;
/*
+---------+-------------------------+------------+-------+
| MovieID | Title                   | ReviewerID | Stars |
+---------+-------------------------+------------+-------+
|     101 | Gone with the Wind      |        201 |     2 |
|     101 | Gone with the Wind      |        204 |     3 |
|     103 | The Sound of Music      |        203 |     2 |
|     103 | The Sound of Music      |        205 |     3 |
|     104 | E.T.                    |        205 |     2 |
|     104 | E.T.                    |        208 |     3 |
|     107 | Avatar                  |        206 |     3 |
|     108 | Raiders of the Lost Ark |        203 |     2 |
+---------+-------------------------+------------+-------+
8 rows in set (0.00 sec)

*/

-- 12. Select movie ids of each movie with its title, reviewer id and stars received, where number of stars is between two and four (two and four inclusive).

SELECT  MOVIE.MovieID, Title, ReviewerID, Stars
FROM RATING, MOVIE
WHERE MOVIE.MovieID = RATING.MovieID AND Stars BETWEEN 2 AND 4;
/*
+---------+-------------------------+------------+-------+
| MovieID | Title                   | ReviewerID | Stars |
+---------+-------------------------+------------+-------+
|     101 | Gone with the Wind      |        201 |     2 |
|     101 | Gone with the Wind      |        201 |     4 |
|     101 | Gone with the Wind      |        204 |     3 |
|     103 | The Sound of Music      |        203 |     2 |
|     103 | The Sound of Music      |        205 |     3 |
|     104 | E.T.                    |        205 |     2 |
|     104 | E.T.                    |        208 |     3 |
|     106 | Snow White              |        202 |     4 |
|     107 | Avatar                  |        206 |     3 |
|     108 | Raiders of the Lost Ark |        203 |     4 |
|     108 | Raiders of the Lost Ark |        203 |     2 |
|     108 | Raiders of the Lost Ark |        205 |     4 |
+---------+-------------------------+------------+-------+
12 rows in set (0.01 sec)

*/

-- 13. Select reviewer ids with the corresponding movie ids reviewed by each reviewer.

SELECT ReviewerID, MovieID 
FROM RATING;
/*
+------------+---------+
| ReviewerID | MovieID |
+------------+---------+
|        201 |     101 |
|        201 |     101 |
|        202 |     106 |
|        203 |     103 |
|        203 |     108 |
|        203 |     108 |
|        204 |     101 |
|        205 |     103 |
|        205 |     104 |
|        205 |     108 |
|        206 |     107 |
|        206 |     106 |
|        207 |     107 |
|        208 |     104 |
+------------+---------+
14 rows in set (0.00 sec)
*/

-- 14. Select distinct tuples from the results produced by the execution of the above query (query number 13).

SELECT DISTINCT ReviewerID, MovieID 
FROM RATING;
/*
+------------+---------+
| ReviewerID | MovieID |
+------------+---------+
|        201 |     101 |
|        202 |     106 |
|        203 |     103 |
|        203 |     108 |
|        204 |     101 |
|        205 |     103 |
|        205 |     104 |
|        205 |     108 |
|        206 |     107 |
|        206 |     106 |
|        207 |     107 |
|        208 |     104 |
+------------+---------+
12 rows in set (0.00 sec)

*/

-- 15. Select each movie id with its corresponding title, reviewer id, reviewer name and stars received.

SELECT rt.MovieID, Title, rt.ReviewerID, ReviewerName, Stars
FROM RATING rt, MOVIE m, REVIEWER rv
WHERE rt.MovieID = m.MovieID AND rt.ReviewerID = rv.ReviewerID;
/*
+---------+-------------------------+------------+------------------+-------+
| MovieID | Title                   | ReviewerID | ReviewerName     | Stars |
+---------+-------------------------+------------+------------------+-------+
|     101 | Gone with the Wind      |        201 | Sarah Martinez   |     2 |
|     101 | Gone with the Wind      |        201 | Sarah Martinez   |     4 |
|     101 | Gone with the Wind      |        204 | Mike Anderson    |     3 |
|     103 | The Sound of Music      |        203 | Brittany Harris  |     2 |
|     103 | The Sound of Music      |        205 | Chris Jackson    |     3 |
|     104 | E.T.                    |        205 | Chris Jackson    |     2 |
|     104 | E.T.                    |        208 | Ashley White     |     3 |
|     106 | Snow White              |        202 | Daniel Lewis     |     4 |
|     106 | Snow White              |        206 | Elizabeth Thomas |     5 |
|     107 | Avatar                  |        206 | Elizabeth Thomas |     3 |
|     107 | Avatar                  |        207 | James Cameron    |     5 |
|     108 | Raiders of the Lost Ark |        203 | Brittany Harris  |     4 |
|     108 | Raiders of the Lost Ark |        203 | Brittany Harris  |     2 |
|     108 | Raiders of the Lost Ark |        205 | Chris Jackson    |     4 |
+---------+-------------------------+------------+------------------+-------+
14 rows in set (0.00 sec)

*/

-- 16. Select each movie id with its corresponding title, reviewer id, reviewer name and stars received, where number of stars received is equal to five.

SELECT rt.MovieID, Title, rt.ReviewerID, ReviewerName, Stars
FROM RATING rt, MOVIE m, REVIEWER rv
WHERE rt.MovieID = m.MovieID AND rt.ReviewerID = rv.ReviewerID AND Stars = 5;
/*
+---------+------------+------------+------------------+-------+
| MovieID | Title      | ReviewerID | ReviewerName     | Stars |
+---------+------------+------------+------------------+-------+
|     106 | Snow White |        206 | Elizabeth Thomas |     5 |
|     107 | Avatar     |        207 | James Cameron    |     5 |
+---------+------------+------------+------------------+-------+
2 rows in set (0.00 sec)

*/

-- 17. Select movie title with its corresponding reviewer name and stars, where movie’s rating date is missing.

SELECT Title, ReviewerName, Stars
FROM RATING rt, MOVIE m, REVIEWER rv
WHERE rt.MovieID = m.MovieID AND rt.ReviewerID = rv.ReviewerID AND RatingDate IS NULL;
/*
+-------------------------+---------------+-------+
| Title                   | ReviewerName  | Stars |
+-------------------------+---------------+-------+
| Snow White              | Daniel Lewis  |     4 |
| Raiders of the Lost Ark | Chris Jackson |     4 |
+-------------------------+---------------+-------+
2 rows in set (0.00 sec)

*/

-- 18. Select all the movie director names and reviewer names into one column. Do not include null values.

SELECT Director FROM MOVIE WHERE Director IS NOT NULL
UNION 
SELECT ReviewerName FROM REVIEWER WHERE ReviewerName IS NOT NULL;
/*
+------------------+
| Director         |
+------------------+
| Victor Fleming   |
| George Lucas     |
| Robert Wise      |
| Steven Spielberg |
| James Cameron    |
| Sarah Martinez   |
| Daniel Lewis     |
| Brittany Harris  |
| Mike Anderson    |
| Chris Jackson    |
| Elizabeth Thomas |
| Ashley White     |
+------------------+
12 rows in set (0.00 sec)

*/

-- 19. Select the details about the reviewers who have a last name called ‘Martinez’.

SELECT * 
FROM REVIEWER 
WHERE ReviewerName LIKE '%Martinez';
/*
+------------+----------------+
| ReviewerID | ReviewerName   |
+------------+----------------+
|        201 | Sarah Martinez |
+------------+----------------+
1 row in set (0.01 sec)

*/

-- 20. Select the details about the ratings which have been rated before the 10 th day of the month. Use substring comparison.

SELECT * 
FROM RATING 
WHERE RatingDate LIKE '____-__-0_';
/*
+------------+---------+-------+------------+
| ReviewerID | MovieID | Stars | RatingDate |
+------------+---------+-------+------------+
|        204 |     101 |     3 | 2011-01-09 |
|        208 |     104 |     3 | 2011-01-02 |
+------------+---------+-------+------------+
2 rows in set, 1 warning (0.00 sec)

*/

-- 21. Write the above query (query number 20) without using substring comparison.

SELECT * 
FROM RATING 
WHERE DAY(RatingDate) < 10;
/*
+------------+---------+-------+------------+
| ReviewerID | MovieID | Stars | RatingDate |
+------------+---------+-------+------------+
|        204 |     101 |     3 | 2011-01-09 |
|        208 |     104 |     3 | 2011-01-02 |
+------------+---------+-------+------------+
2 rows in set (0.00 sec)

*/

-- 22. Show the effect of giving one more star to the movies reviewed by ‘Brittany Harris’. Here select relevant details from RATING table.

SELECT ReviewerID, MovieID, Stars+1, RatingDate 
FROM RATING
WHERE ReviewerID IN (SELECT ReviewerID FROM REVIEWER WHERE ReviewerName = 'Brittany Harris');
/*
+------------+---------+---------+------------+
| ReviewerID | MovieID | Stars+1 | RatingDate |
+------------+---------+---------+------------+
|        203 |     103 |       3 | 2011-01-20 |
|        203 |     108 |       5 | 2011-01-12 |
|        203 |     108 |       3 | 2011-01-30 |
+------------+---------+---------+------------+
3 rows in set (0.00 sec)

*/
-- OR Are we asked to update? (Question not clear.)
UPDATE RATING 
SET Stars = Stars+1 
WHERE ReviewerID IN (SELECT ReviewerID FROM REVIEWER WHERE ReviewerName = 'Brittany Harris');
/*
Query OK, 3 rows affected (0.00 sec)
Rows matched: 3  Changed: 3  Warnings: 0

*/

-- 23. Select movie titles with its reviewer name and stars received. Order the result by movie title in the alphabetical order.

SELECT Title, ReviewerName, Stars
FROM RATING rt, MOVIE m, REVIEWER rv
WHERE rt.MovieID = m.MovieID AND rt.ReviewerID = rv.ReviewerID
ORDER BY Title;
/*
+-------------------------+------------------+-------+
| Title                   | ReviewerName     | Stars |
+-------------------------+------------------+-------+
| Avatar                  | Elizabeth Thomas |     3 |
| Avatar                  | James Cameron    |     5 |
| E.T.                    | Chris Jackson    |     2 |
| E.T.                    | Ashley White     |     3 |
| Gone with the Wind      | Sarah Martinez   |     2 |
| Gone with the Wind      | Sarah Martinez   |     4 |
| Gone with the Wind      | Mike Anderson    |     3 |
| Raiders of the Lost Ark | Brittany Harris  |     5 |
| Raiders of the Lost Ark | Brittany Harris  |     3 |
| Raiders of the Lost Ark | Chris Jackson    |     4 |
| Snow White              | Daniel Lewis     |     4 |
| Snow White              | Elizabeth Thomas |     5 |
| The Sound of Music      | Brittany Harris  |     3 |
| The Sound of Music      | Chris Jackson    |     3 |
+-------------------------+------------------+-------+
14 rows in set (0.01 sec)

*/

-- 24. Select movie titles with its stars received and rating date. Order the result by movie title in the alphabetical order, then by stars and rating date both in descending order.

SELECT Title, Stars, RatingDate
FROM RATING rt, MOVIE m, REVIEWER rv
WHERE rt.MovieID = m.MovieID AND rt.ReviewerID = rv.ReviewerID
ORDER BY Title, Stars DESC, RatingDate DESC;
/*
+-------------------------+-------+------------+
| Title                   | Stars | RatingDate |
+-------------------------+-------+------------+
| Avatar                  |     5 | 2011-01-20 |
| Avatar                  |     3 | 2011-01-15 |
| E.T.                    |     3 | 2011-01-02 |
| E.T.                    |     2 | 2011-01-22 |
| Gone with the Wind      |     4 | 2011-01-27 |
| Gone with the Wind      |     3 | 2011-01-09 |
| Gone with the Wind      |     2 | 2011-01-22 |
| Raiders of the Lost Ark |     5 | 2011-01-12 |
| Raiders of the Lost Ark |     4 | NULL       |
| Raiders of the Lost Ark |     3 | 2011-01-30 |
| Snow White              |     5 | 2011-01-19 |
| Snow White              |     4 | NULL       |
| The Sound of Music      |     3 | 2011-01-27 |
| The Sound of Music      |     3 | 2011-01-20 |
+-------------------------+-------+------------+
14 rows in set (0.00 sec)

*/
-- 25. Write a nested query to retrieve the details of the movies directed by a director who is also a reviewer.

SELECT * 
FROM MOVIE 
WHERE Director IN (SELECT ReviewerName FROM REVIEWER);
/*
+---------+---------+------+---------------+
| MovieID | Title   | Year | Director      |
+---------+---------+------+---------------+
|     105 | Titanic | 1997 | James Cameron |
|     107 | Avatar  | 2009 | James Cameron |
+---------+---------+------+---------------+
2 rows in set (0.00 sec)

*/

-- End of the CO226 lab05.
