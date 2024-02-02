USE z511s24vpawar0; #replace z511f21choika0book with your database name

CREATE TABLE book
( title VARCHAR(25) NOT NULL,
authorfname VARCHAR(25) NOT NULL,
authorlname VARCHAR(25) NOT NULL,
ryear int NOT NULL,
wordcount int NOT NULL,
genre VARCHAR(25),
PRIMARY KEY (title)
);

INSERT INTO book VALUES ('Eat, Pray, Love','Elizabeth','Gilbert',2006,
130000,'memoir');
INSERT INTO book VALUES ('Big Magic','Elizabeth','Gilbert',2015,44370,'self-
help');
INSERT INTO book(title,authorfname, authorlname, ryear,wordcount) VALUES ('The Joy
Luck Club','Amy','Tan',1989,89682);
INSERT INTO book VALUES ('The Gifts of
Imperfection','Brene','Brown',2010,40890,'self-help');
INSERT INTO book(title,authorfname, authorlname, ryear,wordcount) VALUES ('Herbal
Medicine','Cyndi','Gilbert',2015,49998);

CREATE TABLE song
( title VARCHAR(25) NOT NULL,
artist VARCHAR(25) NOT NULL,
ryear int NOT NULL,
wordcount int NOT NULL,
lyrics VARCHAR(100) NOT NULL,
genre VARCHAR(25),
PRIMARY KEY (title, RYear)
);

INSERT INTO song VALUES ('crazy in love','beyonce',2003,799,'yes its so crazy
right','pop');
INSERT INTO song VALUES ('like a rolling stone','bob dylan',1965,391,'once upon a
time you' ,'folk');
INSERT INTO song VALUES ('best i ever had','drake',2009,802,'you know a lot
of','rap');
INSERT INTO song VALUES ('lose yourself','eminem',2002,822,'look if you had
one' ,'rap');
INSERT INTO song VALUES ('poker face','lady gaga',2009,517,'i wanna hold em
like' ,'dance');
INSERT INTO song(title, artist, ryear, wordcount, lyrics) VALUES ('bad
romance','lady gaga',2010,473,'oh oh oh oh oh oh');
INSERT INTO song VALUES ('born this way','lady gaga',2011,527,'it doesnt matter if
you','pop');
INSERT INTO song VALUES ('smells like teen spirit','nirvana',1992,244,'load up on
guns bring','alternative');
INSERT INTO song VALUES ('gangnam style','psy',2012,569,'oppa gangnam style
gangnam','kpop');
INSERT INTO song VALUES ('gangnam style','psy',2013,569,'oppa gangnam style
gangnam','kpop');
INSERT INTO song VALUES ('bohemian rhapsody','queen',1976,367,'is this the real
life','rock');
INSERT INTO song(title, artist, ryear, wordcount, lyrics) VALUES ('the sound of
silence','simon garfunkel',1966,217,'hello darkness my old friend');
INSERT INTO song VALUES ('chasing cars','snow patrol',2006,224,'well do it all
everything','rock');
