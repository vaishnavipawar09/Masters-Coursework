/*
Assignment 2 will continue to examine your knowledge about SQL
using the subset of the UMLS dataset we used in Assignment 1

This time you are free to use all SQL features we covered
unless otherwise stated.

Please answer every block marked with "## Please ..."
Each mistake deducts 5 points from a total of 100 points
If more than 100 points are deducted, you will get 0 still

Topics covered:
- SQL Functions and Expression
- Aggregate Functions and Data Partitioning
- Triggers
*/

-- VAISHNAVI PAWAR - ADC ASSIGNMENT 2 --

-- Q1: Find the cui(s) with the most number of auis
-- return the cui(s) and its number of auis

SELECT 
    cui, 
    COUNT(aui) AS numberofauis
FROM 
    mrconso
GROUP BY 
    cui
HAVING 
    COUNT(aui) = (
        SELECT MAX(total_auicnt) 
        FROM (
            SELECT 
                COUNT(aui) AS total_auicnt
            FROM 
                mrconso
            GROUP BY 
                cui
        ) AS counts
    );



-- Q2: Find all cuis whose number of auis is above the average
-- return the cuis and their number of auis


SELECT 
    cui, 
    COUNT(aui) AS numberofauis
FROM 
    mrconso
GROUP BY 
    cui
HAVING 
    COUNT(aui) > (
        SELECT AVG(total_auicnt) 
        FROM (
            SELECT 
                COUNT(aui) AS total_auicnt
            FROM 
                mrconso
            GROUP BY 
                cui
        ) AS avg_auicnt
    );



-- Q3: Find all frequent relas that appear more than 5000 times in mrrel
-- return relas and their frequency of occurrences

SELECT 
    rela, 
    COUNT(*) AS frequency
FROM 
    mrrel
GROUP BY 
    rela
HAVING 
    COUNT(*) > 5000
ORDER BY 
    frequency DESC;


-- Q4: Recall that (subject, predicate, object) = (aui2, rel, aui1)
-- for every cui, find its number of occurrences as the subject in mrrel
-- return cuis and their frequency of occurrences 
-- Hint: for cuis not involved in any relation as a subject, you should give (cui, 0)

SELECT 
    mc.cui, 
    COUNT(mr.aui2) AS frequency_of_occurrences
FROM 
    mrconso mc
LEFT JOIN 
    mrrel mr ON mc.aui = mr.aui2
GROUP BY 
    mc.cui
ORDER BY 
    frequency_of_occurrences DESC;




-- Q5: Find the maximum, minimum, and average string length (str column)
-- For each source (sab column) in the MRCONSO table

SELECT 
    sab, 
    MAX(LENGTH(str)) AS max_str_length,
    MIN(LENGTH(str)) AS min_str_length,
    AVG(LENGTH(str)) AS avg_str_length
FROM 
    mrconso
GROUP BY 
    sab;


-- Q6: Create a view that maintains only those auis in mrconso with sab = 'SRC'
-- delete a row from the view

-- Step 1: Find all distinct sources (sab) in mrconso
-- return sab and its occurrence frequency in mrconso

SELECT sab, COUNT(*) AS frequency
FROM mrconso
GROUP BY sab;


-- Step 2: create a view "mrconso_src" for auis with sab = 'SRC'
-- keep only (cui, aui)

CREATE VIEW mrconso_src AS
SELECT cui, aui
FROM mrconso
WHERE sab = 'SRC';

-- Step 3: write a trigger for deleting an aui from mrconso_src
-- you should actually delete from mrconso

CREATE OR REPLACE FUNCTION delete_aui_from_mrconso_func()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM mrconso WHERE aui = OLD.aui AND sab = 'SRC';
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_aui_from_mrconso
INSTEAD OF DELETE ON mrconso_src
FOR EACH ROW EXECUTE FUNCTION delete_aui_from_mrconso_func();


-- Step 4: delete from mrconso_src all those rows with cui = 'C1140093'
-- you should actually delete from mrconso
-- Hint: 0 rows returned for "select * from mrconso where cui = 'C1140093';"

DELETE FROM mrconso_src WHERE cui = 'C1140093';


-- Q7: Create a function named "GetUnique" that accepts a keyword as input,
-- searches the mrconso file for concepts containing this keyword in the "str" column
-- return tuples of the form (cui, aui, str)

CREATE OR REPLACE FUNCTION GetUnique(keyword VARCHAR)
RETURNS TABLE(cui TEXT, aui TEXT, str TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT mrconso.cui, mrconso.aui, mrconso.str
    FROM mrconso
    WHERE mrconso.str LIKE '%' || keyword || '%';
END;
$$ LANGUAGE plpgsql;

SELECT * FROM GetUnique('gamma');


-- Q8: Create a function get_term_status_code that takes a term status (column 'ts')
-- (e.g., 'P' for preferred term, 'S' for non-preferred term) as input
-- and returns a status code where 'P' = 1 and 'S' = 0. Then, write a query
-- using this function to select CUIs and their status codes from mrconso

CREATE OR REPLACE FUNCTION get_term_status_code(ts CHAR)
RETURNS INTEGER AS $$
BEGIN
    RETURN CASE 
        WHEN ts = 'P' THEN 1
        WHEN ts = 'S' THEN 0
        ELSE -1 
    END;
END;
$$ LANGUAGE plpgsql;

SELECT cui, get_term_status_code(ts) AS status_code
FROM mrconso;
