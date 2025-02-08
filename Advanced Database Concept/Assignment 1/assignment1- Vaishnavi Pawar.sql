/*
Assignment 1 will examine your knowledge about SQL using
a subset of the UMLS dataset

Please note that you can only use what we covered so far
by the time this assigment is released.
For example, aggregation is not allowed (e.g., group by)

Please answer every block marked with "## Please ..."
Each mistake deducts 5 points from a total of 100 points
If more than 100 points are deducted, you will get 0 still
*/

---- ADC Assignment 1 : Vaishnavi Vishwas Pawar -----
------ PART I: Single-Table Queries ------

-- Q1: Check 100 tuples in the "mrrel" table 
-- Requirement: Please self-study https://www.w3schools.com/sql/sql_top.asp
-- You can use "limit n" to check a few tuples in a table to get familiar with its data and schema
-- This is helpful when you formulate queries below


SELECT * FROM mrrel LIMIT 100;

-- Q2: Find the CUIs of concepts that have synonyms (i.e., more than 1 AUI)
-- Hint: there are 592,039 results like "C0000005", "C0000039", "C0000052"

SELECT DISTINCT m1.CUI
FROM mrconso m1
JOIN mrconso m2 ON m1.CUI = m2.CUI AND m1.AUI <> m2.AUI;

-- Q3: Find the CUIs of concepts that only have one 1 AUI, create it as a materialized view "mrconso_ oneAUI"
-- Hint: there are 178,595 results like "C0000266", "C0000353", "C0000666"

CREATE MATERIALIZED VIEW mrconso_oneAUI AS
SELECT DISTINCT a.CUI
FROM mrconso a
LEFT JOIN mrconso b ON a.CUI = b.CUI AND a.AUI <> b.AUI
WHERE b.CUI IS NULL;

-- Q4: With the help of view "mrconso_oneAUI" above, recover their complete tuples, order by CUI
-- Requirement: Use NATRUAL JOIN !!!

SELECT mrconso.*
FROM mrconso
NATURAL JOIN mrconso_oneAUI
ORDER BY CUI;


-- Q5: With the help of view "mrconso_oneAUI" above, recover their complete tuples, order by CUI
-- Requirement: Use SET PREDICATE !!!

SELECT *
FROM mrconso
WHERE CUI IN (SELECT CUI FROM mrconso_oneAUI)
ORDER BY CUI;


-- Q6: Find cui, aui, tty, str of all concepts whose string field (str) contains the word "tooth" and is from source (sab) "MSH", order by CUI
-- Requirement: Please self-study string matching in SQL from https://www.w3schools.com/sql/sql_like.asp
-- Hint: there are 19 results

SELECT CUI, AUI, TTY, STR
FROM mrconso
WHERE STR LIKE '%tooth%'
AND SAB = 'MSH'
ORDER BY CUI;


-- Q7: Find all different possible values of (rel, rela) pairs for source (sab) "MSH"
-- Requirement: Look up "REL Description" in https://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/release/abbreviations.html
-- Hint: there are 22 results

SELECT DISTINCT rel, rela
FROM mrrel
WHERE sab = 'MSH'
ORDER BY rel, rela;

-- Q8: Find all different possible values of (rel, rela, sab) triples where source (sab) is not "MSH"
-- Hint: there are 244 results

SELECT DISTINCT rel, rela, sab
FROM mrrel
WHERE sab != 'MSH'
ORDER BY rel, rela, sab;

-- Q9: Find the common (rel, rela) pairs shared by both sources "MSH" and "SNOMEDCT_US"
-- Hint: use set operation; the result is empty

SELECT DISTINCT rel, rela
FROM mrrel
WHERE sab = 'MSH'

INTERSECT

SELECT DISTINCT rel, rela
FROM mrrel
WHERE sab = 'SNOMEDCT_US'
ORDER BY rel, rela;

-- Q10: Find the common "rela" shared by both sources "MSH" and "SNOMEDCT_US"
-- Hint: use set operation; there are 2 results

SELECT DISTINCT rela
FROM mrrel
WHERE sab = 'MSH'
AND rela IS NOT NULL

INTERSECT

SELECT DISTINCT rela
FROM mrrel
WHERE sab = 'SNOMEDCT_US'
AND rela IS NOT NULL;


-- Q11: Find all the possible (tui, sty) values
-- Hint: check table "mrsty"; there are 127 results

SELECT DISTINCT tui, sty
FROM mrsty
ORDER BY tui;


------ PART II: Multi-Table Queries ------

-- Q12: Find (cui, aui, sab, str) of all those concepts under semantic type T018 ("Embryonic Structure")
-- Hint: there are 3235 results

SELECT DISTINCT mrconso.cui, mrconso.aui, mrconso.sab, mrconso.str
FROM mrconso
JOIN mrsty ON mrconso.cui = mrsty.cui
WHERE mrsty.tui = 'T018'
ORDER BY mrconso.cui;


-- Q13: Find all those relations of "Alzheimer's disease" and its synonyms
-- Hint: in SQL, to include a single quote character within a string literal, you need to escape it by using two consecutive single quotes.
-- Hint: there are 264 results

---- Step 1: Finds all CUIs with str = "Alzheimer's disease", and see what are the CUIs?

SELECT cui
FROM mrconso
WHERE str LIKE 'Alzheimer''s disease';

---- Step 2: Find all synonyms of the CUIs above, return (aui, str, sab) only

SELECT aui, str, sab
FROM mrconso
WHERE cui IN (
    SELECT cui
    FROM mrconso
    WHERE str LIKE 'Alzheimer''s disease'
);


---- Step 3: Find all relations in mrrel where an end-concept is Alzheimer's disease, name it as a view "rel_AD"


CREATE VIEW rel_AD AS
SELECT *
FROM mrrel
WHERE cui1 IN (
    SELECT cui
    FROM mrconso
    WHERE str LIKE 'Alzheimer''s disease'
)
OR cui2 IN (
    SELECT cui
    FROM mrconso
    WHERE str LIKE 'Alzheimer''s disease'
);

SELECT * FROM rel_AD;

-- Q14: The relations above only has IDs like cui and aui. Please create a new version of this table listing (aui1, str1, rela, aui2, str2, sab)

---- Step 1: create a view recording Python-dict-style mapping: aui_str[aui] = str

CREATE VIEW aui_str AS
SELECT aui, str
FROM mrconso;

---- Step 2: use it to convert the result table of Q14, return tuples with format (aui1, str1, rela, aui2, str2, sab)
---- Hint: self-join on mrconso is needed since we have (aui1, aui2)

SELECT
    rel.aui1,
    map1.str AS str1,
    rel.rela,
    rel.aui2,
    map2.str AS str2,
    rel.sab
FROM
    rel_AD AS rel
INNER JOIN aui_str AS map1 ON rel.aui1 = map1.aui
INNER JOIN aui_str AS map2 ON rel.aui2 = map2.aui;



---- Step 3:
---- UMLS is actually a knowledge graph better modeled as an RDF database rather than a relational database.
---- An RDF database stores S-P-O (Subject-Predicate-Object) relations as in our mrrel table, but is more graph-query friendly.
---- However, only MeSH is currently supported with SPARQL API: https://id.nlm.nih.gov/mesh/
---- We are basically using SQL to solve graph queries, which takes quite some joins.

---- Now, check the results from Step 2, such as
---- "Alzheimer's disease"	"isa"	"A27169206"	"Alzheimer's disease co-occurrent with delirium"	"SNOMEDCT_US"
---- Answer the question: is aui1 the subject or the object? is aui2 the subject or the object?
---- Hint: getting your understanding of the relation edge direction correct is important for the later queries to complete.
/*
---- ################################################################
---- ## Answer: 

	According to the observation,
	aui1 is regarded as the Object in this relationship. 
	In the context of knowledge representation, the object refers to the term described or classified by the relationship. 
	The term "Alzheimer's disease" is the focus of this classification.

	aui2 is the subject. 
	In a knowledge representation context, the subject is the term that represents the classification or description being used. 
	It is what "Alzheimer's disease" is classified as or associated with. 
	In this case, AUI2 represents a more specific concept that incorporates "Alzheimer's disease" into its definition or classification.

---- ################################################################
*/
-- Q15. find the overlapped relations (aui, paui) between mrrel and mrhier, return tuples of the form (cui, aui, paui, str, pstr)
-- Hint: paui is parent-aui based on "isa" relationship, it is important to have a correct understanding of edge direction in Step 3 of Q15 above
-- Hint: str can be obtained from the materialized view "aui_str", pstr is parent-str to be created for result relation
-- Hint: there are 602431 results

SELECT DISTINCT
    mrhier.cui,
    mrhier.aui,
    mrhier.paui,
    aui_str.str AS str,
    paui_str.str AS pstr
FROM 
    mrrel
JOIN 
    mrhier ON mrhier.aui = mrrel.aui2 AND mrhier.paui = mrrel.aui1
JOIN 
    aui_str AS aui_str ON mrhier.aui = aui_str.aui
JOIN 
    aui_str AS paui_str ON mrhier.paui = paui_str.aui;



-- Q16. [Recursive View]
-- We consider only the hierarchy defined by the "isa" relationship
-- Find all concepts BELOW "Alzheimer's disease" and one level above "Alzheimer's disease" (i.e., its parents), return tuples of the form (aui, paui, str, pstr)
-- Hint: recall the slide about recursive view
-- Hint: inductive rule: if (aui_A, paui_A) is in the current result relation R, then (aui_B, paui_B = aui_A) in mrhier should be added to R
-- Hint: there are 30 results

---- Step 1: create a view "rel_isa" that filters out tuples with rela = 'isa' in mrhier

CREATE VIEW rel_isa AS
SELECT aui, paui
FROM mrhier
WHERE rela = 'isa';


---- Step 2: use the view "rel_isa" to facilitate the writing of recursive view.

WITH RECURSIVE azhierarchy AS (
    SELECT 
        conso.aui, 
        hier.paui, 
        conso.str AS str, 
        parent_conso.str AS pstr
    FROM 
        mrhier AS hier
    JOIN 
        mrconso AS conso ON hier.aui = conso.aui
    JOIN 
        mrconso AS parent_conso ON hier.paui = parent_conso.aui
    WHERE 
        conso.str = 'Alzheimer''s disease' AND hier.rela = 'isa'
    
    UNION ALL
    
    SELECT 
        hier.aui, 
        hier.paui, 
        child_conso.str, 
        parent_conso.str
    FROM 
        mrhier AS hier
    JOIN 
        azhierarchy AS prev ON hier.paui = prev.aui
    JOIN 
        mrconso AS child_conso ON hier.aui = child_conso.aui
    JOIN 
        mrconso AS parent_conso ON hier.paui = parent_conso.aui
    WHERE 
        hier.rela = 'isa'
)
SELECT DISTINCT 
    aui, 
    paui, 
    str, 
    pstr 
FROM 
    azhierarchy;


---- Step 3: visualize the result hierarchy

---- ################################################################
---- ## Please save your result and rename the file as "result.csv"
---- ## Please visualize the result using "hierViz.py"
---- ## Please rename the figure as "hier_down.png"
---- ################################################################


-- Q17. [Recursive View]
-- We consider only the hierarchy defined by the "isa" relationship
-- Find all concepts ABOVE "Alzheimer's disease", return tuples of the form (aui, paui, str, pstr)
-- Hint: recall the slide about recursive view
-- Hint: inductive rule: if (aui_A, paui_A) is in the current result relation R, then (aui_B = paui_A, paui_A) in mrhier should be added to R
-- Hint: there are 33 results
-- WARNING: this one is time consuming since there are many recurive iterations (deep rather than flat), so please be patient to wait for minutes

---- Step 1: use the view "rel_isa" to facilitate the writing of recursive view.

WITH RECURSIVE ancestors AS (
  SELECT 
    mrconso.aui, 
    rel_isa.paui, 
    mrconso.str AS str, 
    parent.str AS pstr
  FROM 
    rel_isa
  JOIN 
    mrconso ON rel_isa.aui = mrconso.aui
  JOIN 
    mrconso AS parent ON rel_isa.paui = parent.aui
  WHERE 
    mrconso.str = 'Alzheimer''s disease'
  
  UNION ALL
  
  SELECT 
    ancestors.paui AS aui, 
    parent_rel.paui, 
    parent.str AS str, 
    grandparent.str AS pstr
  FROM 
    ancestors
  JOIN 
    rel_isa AS parent_rel ON ancestors.paui = parent_rel.aui
  JOIN 
    mrconso AS parent ON parent_rel.aui = parent.aui
  JOIN 
    mrconso AS grandparent ON parent_rel.paui = grandparent.aui
)
SELECT DISTINCT 
    aui, 
    paui, 
    str, 
    pstr 
FROM 
    ancestors;

---- Step 2: visualize the result hierarchy

---- ################################################################
---- ## Please save your result and rename the file as "result.csv"
---- ## Please visualize the result using "hierViz.py"
---- ## Please rename the figure as "hier_up.png"
---- ################################################################
