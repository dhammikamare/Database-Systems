/*
 * CO226: lab 06 Writing SQL Queries – Part II (2014 fall)
 * Author: Marasinghe, M.M.D.B. (E/11/258)
 * Date:  2014-08-27 15:36:22 
 */


-- Lab Task01

-- Write the following SQL queries using MySQL, to retrieve the data from the database, you created in the previous lab.

-- 1. Write a nested query to list the details of the movies directed by a director,
-- a. who is also a reviewer. (1 mark)

SELECT *
FROM MOVIE
WHERE Director IN (
	SELECT ReviewerName 
	FROM REVIEWER);
/*
+---------+---------+------+---------------+
| MovieID | Title   | Year | Director      |
+---------+---------+------+---------------+
|     105 | Titanic | 1997 | James Cameron |
|     107 | Avatar  | 2009 | James Cameron |
+---------+---------+------+---------------+
2 rows in set (0.00 sec)

*/

-- b. who is not a reviewer. (1 mark)

SELECT *
FROM MOVIE
WHERE Director NOT IN (
	SELECT ReviewerName 
	FROM REVIEWER);
/*
+---------+-------------------------+------+------------------+
| MovieID | Title                   | Year | Director         |
+---------+-------------------------+------+------------------+
|     101 | Gone with the Wind      | 1939 | Victor Fleming   |
|     102 | Star Wars               | 1977 | George Lucas     |
|     103 | The Sound of Music      | 1965 | Robert Wise      |
|     104 | E.T.                    | 1982 | Steven Spielberg |
|     108 | Raiders of the Lost Ark | 1981 | Steven Spielberg |
+---------+-------------------------+------+------------------+
5 rows in set (0.00 sec)

*/

-- 2. Write a nested query to list the details of the movie ratings,
-- a. reviewed by the reviewer ‘Sarah Martinez’. (1 mark)

SELECT * 
FROM RATING 
WHERE ReviewerID = (
	SELECT ReviewerID 
	FROM REVIEWER 
	WHERE ReviewerName = 'Sarah Martinez');
/*
+------------+---------+-------+------------+
| ReviewerID | MovieID | Stars | RatingDate |
+------------+---------+-------+------------+
|        201 |     101 |     2 | 2011-01-22 |
|        201 |     101 |     4 | 2011-01-27 |
+------------+---------+-------+------------+
2 rows in set (0.00 sec)

*/

-- b. not reviewed by the reviewer ‘Sarah Martinez’. (1 mark)

SELECT * 
FROM RATING 
WHERE ReviewerID != (
	SELECT ReviewerID 
	FROM REVIEWER 
	WHERE ReviewerName = 'Sarah Martinez');
/*
+------------+---------+-------+------------+
| ReviewerID | MovieID | Stars | RatingDate |
+------------+---------+-------+------------+
|        202 |     106 |     4 | NULL       |
|        203 |     103 |     2 | 2011-01-20 |
|        203 |     108 |     4 | 2011-01-12 |
|        203 |     108 |     2 | 2011-01-30 |
|        204 |     101 |     3 | 2011-01-09 |
|        205 |     103 |     3 | 2011-01-27 |
|        205 |     104 |     2 | 2011-01-22 |
|        205 |     108 |     4 | NULL       |
|        206 |     107 |     3 | 2011-01-15 |
|        206 |     106 |     5 | 2011-01-19 |
|        207 |     107 |     5 | 2011-01-20 |
|        208 |     104 |     3 | 2011-01-02 |
+------------+---------+-------+------------+
12 rows in set (0.00 sec)

*/

-- 3. Write a nested query to list the movie ids where each movie has some rating
-- a. less than to any of the ratings received by the movie which has a movie id equal to 103. (1 mark)

SELECT DISTINCT MovieID 
FROM RATING
WHERE Stars < (
	SELECT MIN(Stars) 
	FROM RATING 
	WHERE MovieID = 103);
/*
Empty set (0.00 sec)

*/

-- b. less than or equal to any of the ratings received by the movie which has a movie id equal to 103. (1 mark)

SELECT DISTINCT MovieID 
FROM RATING
WHERE Stars <= ANY(
	SELECT Stars 
	FROM RATING 
	WHERE MovieID = 103);
/*
+---------+
| MovieID |
+---------+
|     101 |
|     103 |
|     104 |
|     107 |
|     108 |
+---------+
5 rows in set (0.00 sec)

*/

-- c. equal to any of the ratings received by the movie which has a movie id equal to 103. (1 mark)

SELECT DISTINCT MovieID 
FROM RATING
WHERE Stars = ANY(
	SELECT Stars 
	FROM RATING 
	WHERE MovieID = 103);
/*
+---------+
| MovieID |
+---------+
|     101 |
|     103 |
|     104 |
|     107 |
|     108 |
+---------+
5 rows in set (0.00 sec)

*/

-- d. greater than to any of the ratings received by the movie which has a movie id equal to 103. (1 mark)

SELECT DISTINCT MovieID 
FROM RATING
WHERE Stars > (
	SELECT MAX(Stars) 
	FROM RATING 
	WHERE MovieID = 103);
/*
+---------+
| MovieID |
+---------+
|     101 |
|     106 |
|     107 |
|     108 |
+---------+
4 rows in set (0.00 sec)

*/

-- e. greater than or equal to any of the ratings received by the movie which has a movie id equal to 103. (1 mark)

SELECT DISTINCT MovieID 
FROM RATING
WHERE Stars >= ANY(
	SELECT Stars 
	FROM RATING 
	WHERE MovieID = 103);
/*
+---------+
| MovieID |
+---------+
|     101 |
|     103 |
|     104 |
|     106 |
|     107 |
|     108 |
+---------+
6 rows in set (0.00 sec)

*/

-- f. not equal to any of the ratings received by the movie which has a movie id equal to 103. (1 mark)

SELECT DISTINCT MovieID 
FROM RATING
WHERE Stars != ANY(
	SELECT Stars 
	FROM RATING 
	WHERE MovieID = 103);
/*
+---------+
| MovieID |
+---------+
|     101 |
|     103 |
|     104 |
|     106 |
|     107 |
|     108 |
+---------+
6 rows in set (0.01 sec)
*/

-- 4. Write a nested query to list the reviewer ids who has the same (movie id, stars) combination on some movie which has a rating date equal to 2011-01-12. (5 marks)

SELECT ReviewerID 
FROM RATING
WHERE (MovieID, Stars) IN (
	SELECT MovieID, Stars 
	FROM RATING 
	WHERE RatingDate = '2011-01-12');
/*
+------------+
| ReviewerID |
+------------+
|        203 |
|        205 |
+------------+
2 rows in set (0.00 sec)

*/

-- 5. Find all the years that have a movie that received a rating of 4 or 5 and sort them in increasing order of the year. Write,
-- a. a non-nested query. (5 marks)

SELECT DISTINCT Year
FROM MOVIE NATURAL JOIN RATING 
WHERE Stars = 4 OR Stars = 5 
ORDER BY Year;
/*
+------+
| Year |
+------+
| 1937 |
| 1939 |
| 1981 |
| 2009 |
+------+
4 rows in set (0.00 sec)

*/
-- b. a non-correlated nested query. (5 marks)

SELECT DISTINCT Year
FROM MOVIE  
WHERE MovieID IN (
	SELECT MovieID 
	FROM RATING 
	WHERE Stars = 4 OR Stars = 5) 
ORDER BY Year;
/*
+------+
| Year |
+------+
| 1937 |
| 1939 |
| 1981 |
| 2009 |
+------+
4 rows in set (0.00 sec)

*/

-- 6. Find the titles of all movies that have no ratings. Write,
-- a .non-correlated nested query. (5 marks)

SELECT Title 
FROM MOVIE 
WHERE MovieID NOT IN (
	SELECT MovieID 
	FROM RATING);
/*
+-----------+
| Title     |
+-----------+
| Star Wars |
| Titanic   |
+-----------+
2 rows in set (0.00 sec)

*/

-- b. a correlated nested query. (5 marks)



-- 8. Some reviewers did not provide a date with their rating. Find the names of all reviewers who have a NULL value for the date. Write,
-- a. a non-nested query. (5 marks)

SELECT ReviewerName 
FROM REVIEWER NATURAL JOIN RATING
WHERE RatingDate IS NULL;
/*
+---------------+
| ReviewerName  |
+---------------+
| Daniel Lewis  |
| Chris Jackson |
+---------------+
2 rows in set (0.00 sec)

*/

-- b. a non-correlated nested query. (5 marks)

SELECT ReviewerName 
FROM REVIEWER 
WHERE ReviewerID IN (
	SELECT ReviewerID 
	FROM RATING 
	WHERE RatingDate IS NULL);

-- c. a correlated nested query. (5 marks)



-- 9. For each movie that has some rating, find
-- a. the highest stars value received. (2 marks)

SELECT Title, MAX(Stars) 
FROM RATING NATURAL JOIN MOVIE
GROUP BY MovieID
ORDER BY Title;
/*
+-------------------------+------------+
| Title                   | MAX(Stars) |
+-------------------------+------------+
| Avatar                  |          5 |
| E.T.                    |          3 |
| Gone with the Wind      |          4 |
| Raiders of the Lost Ark |          4 |
| Snow White              |          5 |
| The Sound of Music      |          3 |
+-------------------------+------------+
6 rows in set (0.00 sec)

*/

-- b. the least stars value received. (2 marks)

SELECT Title, MIN(Stars) 
FROM RATING NATURAL JOIN MOVIE
GROUP BY MovieID
ORDER BY Title;
/*
+-------------------------+------------+
| Title                   | MIN(Stars) |
+-------------------------+------------+
| Avatar                  |          3 |
| E.T.                    |          2 |
| Gone with the Wind      |          2 |
| Raiders of the Lost Ark |          2 |
| Snow White              |          4 |
| The Sound of Music      |          2 |
+-------------------------+------------+
6 rows in set (0.00 sec)

*/

-- c. the average value of stars received. (2 marks)

SELECT Title, AVG(Stars) 
FROM RATING NATURAL JOIN MOVIE
GROUP BY MovieID
ORDER BY Title;
/*
+-------------------------+------------+
| Title                   | AVG(Stars) |
+-------------------------+------------+
| Avatar                  |     4.0000 |
| E.T.                    |     2.5000 |
| Gone with the Wind      |     3.0000 |
| Raiders of the Lost Ark |     3.3333 |
| Snow White              |     4.5000 |
| The Sound of Music      |     2.5000 |
+-------------------------+------------+
6 rows in set (0.00 sec)

*/

-- d. the sum of all the stars received. (2 marks)

SELECT Title, SUM(Stars) 
FROM RATING NATURAL JOIN MOVIE
GROUP BY MovieID
ORDER BY Title;
/*
+-------------------------+------------+
| Title                   | SUM(Stars) |
+-------------------------+------------+
| Avatar                  |          8 |
| E.T.                    |          5 |
| Gone with the Wind      |          9 |
| Raiders of the Lost Ark |         10 |
| Snow White              |          9 |
| The Sound of Music      |          5 |
+-------------------------+------------+
6 rows in set (0.00 sec)

*/

-- e. the number of times each movie was rated. (2marks)

SELECT Title, COUNT(Stars) 
FROM RATING NATURAL JOIN MOVIE
GROUP BY MovieID
ORDER BY Title;

/*
+-------------------------+--------------+
| Title                   | COUNT(Stars) |
+-------------------------+--------------+
| Avatar                  |            2 |
| E.T.                    |            2 |
| Gone with the Wind      |            3 |
| Raiders of the Lost Ark |            3 |
| Snow White              |            2 |
| The Sound of Music      |            2 |
+-------------------------+--------------+
6 rows in set (0.00 sec)

*/

-- In each of the above cases, return the movie title and asked stars value. Sort the results by movie title.

-- 10. Find the names of all the reviewers who have contributed three or more ratings. Write,
-- a. a non-nested query. (5 marks)

SELECT ReviewerName 
FROM REVIEWER NATURAL JOIN RATING
GROUP BY ReviewerID 
HAVING COUNT(Stars) >= 3;
/*
+-----------------+
| ReviewerName    |
+-----------------+
| Brittany Harris |
| Chris Jackson   |
+-----------------+
2 rows in set (0.00 sec)
*/

-- b. a non-correlated nested query. (5 marks)

SELECT ReviewerName 
FROM REVIEWER 
WHERE ReviewerID IN (
	SELECT ReviewerID 
	FROM RATING 
	GROUP BY ReviewerID 
	HAVING COUNT(Stars) >= 3); 
/*
+-----------------+
| ReviewerName    |
+-----------------+
| Brittany Harris |
| Chris Jackson   |
+-----------------+
2 rows in set (0.00 sec)

*/
-- c. a correlated nested query. (5 marks)



-- 11. List the movie titles and average ratings, from the highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. (5 marks)

SELECT Title, AVG(Stars) 
FROM RATING NATURAL JOIN MOVIE
GROUP BY MovieID
ORDER BY AVG(Stars) DESC, Title;
/*
+-------------------------+------------+
| Title                   | AVG(Stars) |
+-------------------------+------------+
| Snow White              |     4.5000 |
| Avatar                  |     4.0000 |
| Raiders of the Lost Ark |     3.3333 |
| Gone with the Wind      |     3.0000 |
| E.T.                    |     2.5000 |
| The Sound of Music      |     2.5000 |
+-------------------------+------------+
6 rows in set (0.00 sec)

*/

-- 12. Remove all ratings where the movie's year is before 1970 or after 2000. (5 marks)

DELETE 
FROM RATING 
WHERE MovieID IN (
	SELECT MovieID 
	FROM MOVIE 
	WHERE Year < 1970 OR Year > 2000);
/*
Query OK, 9 rows affected (0.00 sec)

SELECT * FROM RATING;
+------------+---------+-------+------------+
| ReviewerID | MovieID | Stars | RatingDate |
+------------+---------+-------+------------+
|        203 |     108 |     4 | 2011-01-12 |
|        203 |     108 |     2 | 2011-01-30 |
|        205 |     104 |     2 | 2011-01-22 |
|        205 |     108 |     4 | NULL       |
|        208 |     104 |     3 | 2011-01-02 |
+------------+---------+-------+------------+

*/


-- 13. Remove all ratings where the rating date is NULL. (5 marks)

DELETE 
FROM RATING 
WHERE RatingDate IS NULL;
/*
Query OK, 1 row affected (0.00 sec)

SELECT * FROM RATING;
+------------+---------+-------+------------+
| ReviewerID | MovieID | Stars | RatingDate |
+------------+---------+-------+------------+
|        203 |     108 |     4 | 2011-01-12 |
|        203 |     108 |     2 | 2011-01-30 |
|        205 |     104 |     2 | 2011-01-22 |
|        208 |     104 |     3 | 2011-01-02 |
+------------+---------+-------+------------+
4 rows in set (0.00 sec)

*/

-- 14. Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL. (5 marks)



-- 15. For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples. Do not insert new tuples). (5 marks)

UPDATE MOVIE 
SET Year = Year + 25
WHERE MovieID IN (
	SELECT MovieID 
	FROM RATING 
	GROUP BY MovieID
	HAVING AVG(Stars) >= 4);

-- End of the CO226 lab06.
