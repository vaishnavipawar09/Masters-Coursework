USE z511s24vpawar0; #replace z511s21choika0 with your database name

# Run labweek06_tables.sql to create and populate tables for your lab task
# Write queries to labweek06.sql and submit the sql script.
#################################################################
###########

#1 Retrieve the entire contents of the relation SONG

SELECT * FROM song;

#2 For the relation SONG, show the columns Title and Artist

SELECT title, artist FROM song;

#3 Retrieve the Artist value for each record in the relation SONG

SELECT artist FROM song;

#4 Show one instance of all the different Artist values in the relation SONG

SELECT DISTINCT artist FROM song;

#5 Show a list of all unique pair of a song and an artist in the relation SONG

SELECT DISTINCT title, artist FROM song;

#6 Sort the song titles in alphabetical order

SELECT *
FROM song
ORDER BY title;

#7 Order the songs from most recent to least

SELECT *
FROM song
ORDER BY ryear DESC;

#8 Retrieve the entire contents of the relation SONG. Sort by Year and then by Title.

SELECT *
FROM song
ORDER BY ryear, title;

#9 Retrieve the entire contents of the relation SONG. Sort by Year from most recent to least and then by Title in alphabetic order.

SELECT *
FROM song
ORDER BY ryear DESC, title;

#10 Show the columns Title and Artist for the 2 most recent songs

SELECT title, artist
FROM song
ORDER BY ryear DESC
LIMIT 2;

#11 Find the two longest songs and show the columns Title, Artist, and WordCount

SELECT title, artist, wordcount
FROM song
ORDER BY wordcount DESC
LIMIT 2;

#12 Find the 8th shortest songs and show the columns Title, Artist, and WordCount

SELECT title, artist, wordcount
FROM song
ORDER BY wordcount
LIMIT 7, 1;

#13 Retrieve songs released in the 20th century

SELECT *
FROM song
WHERE ryear < 2000;

#14 Retrieve all songs that were not released in 2013

SELECT *
FROM song
WHERE ryear !=2013;

#15 List all books released in the 20th century whose word count is greater than 45,000

SELECT *
FROM book
WHERE ryear <2000 AND wordcount >45000;

#16 List books whose genre is not Self-help

SELECT *
FROM book
WHERE genre != 'self-help' OR genre IS NULL;

#17 Select all books released between 2010 and 2015

SELECT *
FROM book
WHERE ryear >= 2010 AND ryear <=2015;

#18 Select all songs whose genre are rap or pop

SELECT *
FROM song
WHERE genre = 'rap' OR genre = 'pop';

#19 Select all books released in 2015 or 1989

SELECT *
FROM book
WHERE ryear = 2015 OR ryear = 1989;

#20 Select all songs with a title starting with

SELECT *
FROM song
WHERE title LIKE 'b%';

#21 Select all songs whose lyrics have

SELECT *
FROM song
WHERE lyrics LIKE '%you%';

#22 Find all songs with a NULL value in the Genre column

SELECT *
FROM song
WHERE genre IS NULL;

#23 Find all songs with a value in the Genre column

SELECT *
FROM song
WHERE genre IS NOT NULL;
