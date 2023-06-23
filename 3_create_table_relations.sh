#!/bin/bash

PSQL="psql --username=zivile --dbname=books"

# genre

$PSQL << PSQL_INPUT
ALTER TABLE genre ADD COLUMN book_id INT;
UPDATE genre SET book_id=book.id FROM book WHERE book.author=genre.author AND book.title=genre.title;
SELECT * FROM GENRE ORDER BY author LIMIT 3;
ALTER TABLE genre DROP COLUMN IF EXISTS author;
ALTER TABLE genre DROP COLUMN IF EXISTS title;
PSQL_INPUT


$PSQL -c '\d genre'

# setting

$PSQL << PSQL_INPUT
ALTER TABLE setting ADD COLUMN book_id INT;
UPDATE setting SET book_id=book.id FROM book WHERE book.author=setting.author AND book.title=setting.title;
SELECT * FROM setting ORDER BY author LIMIT 3;
ALTER TABLE setting DROP COLUMN IF EXISTS author;
ALTER TABLE setting DROP COLUMN IF EXISTS title;
PSQL_INPUT


$PSQL -c '\d setting'

# award

$PSQL << PSQL_INPUT
ALTER TABLE award ADD COLUMN publication_id INT;
UPDATE award SET publication_id=publication.id FROM publication WHERE publication.isbn=award.isbn;
SELECT * FROM award ORDER BY isbn LIMIT 3;
ALTER TABLE award DROP COLUMN IF EXISTS isbn;
PSQL_INPUT


$PSQL -c '\d award'

# star

$PSQL << PSQL_INPUT
ALTER TABLE star ADD COLUMN publication_id INT;
UPDATE star SET publication_id=publication.id FROM publication WHERE publication.isbn=star.isbn;
SELECT * FROM star ORDER BY isbn LIMIT 3;
ALTER TABLE star DROP COLUMN IF EXISTS isbn;
PSQL_INPUT


$PSQL -c '\d star'

# publication

$PSQL << PSQL_INPUT
ALTER TABLE publication ADD COLUMN book_id INT;
UPDATE publication SET book_id=book.id FROM book
  WHERE book.author=publication.author AND book.title=publication.title;
SELECT * FROM publication ORDER BY author LIMIT 3;
ALTER TABLE publication DROP COLUMN IF EXISTS author;
ALTER TABLE publication DROP COLUMN IF EXISTS title;
PSQL_INPUT

$PSQL -c '\d publication'

# add foreign key constraints
$PSQL << PSQL_INPUT
ALTER TABLE  genre ADD CONSTRAINT fk_genre_book FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE;
ALTER TABLE  setting ADD CONSTRAINT fk_settig_book FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE;
ALTER TABLE  publication ADD CONSTRAINT fk_publication_book FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE;
ALTER TABLE  award ADD CONSTRAINT fk_award_publication FOREIGN KEY (publication_id) REFERENCES publication (id) ON DELETE CASCADE;
ALTER TABLE  star ADD CONSTRAINT fk_star_publication FOREIGN KEY (publication_id) REFERENCES publication (id) ON DELETE CASCADE;
PSQL_INPUT
