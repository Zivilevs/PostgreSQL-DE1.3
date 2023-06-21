#!/bin/bash 

PSQL="psql --username=zivile --dbname=books"

$PSQL << PSQL_INPUT
TRUNCATE TABLE book;
ALTER SEQUENCE book_id_seq RESTART WITH 1;
INSERT INTO book (isbn, title, series, author, rating, description, firstPublishDate)
    SELECT DISTINCT isbn, title, series, author, rating, description, firstPublishDate FROM books_raw ORDER BY 1;
SELECT COUNT(*) total FROM book;
PSQL_INPUT