#!/bin/bash

PSQL="psql --username=zivile --dbname=books"

# Create tables book, genre, setting, award, star, publication and load data into.
echo -e "--book table--"
$PSQL << PSQL_INPUT
DROP TABLE book CASCADE;
DROP TABLE publication CASCADE;
CREATE TABLE IF NOT EXISTS book(
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    firstPublishDate VARCHAR(20),
    characters TEXT[]);
ALTER SEQUENCE book_id_seq RESTART WITH 1                                                                                                                                                                 
PSQL_INPUT

$PSQL << PSQL_INPUT
COPY book(title, author, firstPublishDate, characters) FROM
       '/home/zivile/Documents/asmeniniai/07_turing/01_module/Turing-project/goodreads/docs/book.csv'
       WITH CSV HEADER DELIMITER ',' QUOTE '"' ESCAPE '\';
PSQL_INPUT

echo -e "--genre table--"
$PSQL << PSQL_INPUT
DROP TABLE IF EXISTS genre;
CREATE TABLE IF NOT EXISTS genre(
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    author TEXT NOT NULL,
    title TEXT NOT NULL,
    genre VARCHAR(30) NOT NULL);
ALTER SEQUENCE genre_id_seq RESTART WITH 1                                                                                                                                                                  
PSQL_INPUT

$PSQL << PSQL_INPUT
COPY genre(title, author, genre) FROM
       '/home/zivile/Documents/asmeniniai/07_turing/01_module/Turing-project/goodreads/docs/genre.csv'
       WITH CSV HEADER DELIMITER ',' QUOTE '"' ESCAPE '\';
PSQL_INPUT

echo -e "--setting table--"
$PSQL << PSQL_INPUT
DROP TABLE IF EXISTS setting;
CREATE TABLE IF NOT EXISTS setting(
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    author TEXT NOT NULL,
    title TEXT NOT NULL,
    setting VARCHAR(100) NOT NULL);
ALTER SEQUENCE setting_id_seq RESTART WITH 1                                                                                                                                                                   
PSQL_INPUT

$PSQL << PSQL_INPUT
COPY setting(title, author, setting) FROM
       '/home/zivile/Documents/asmeniniai/07_turing/01_module/Turing-project/goodreads/docs/setting.csv'
       WITH CSV HEADER DELIMITER ',' QUOTE '"' ESCAPE '\';
PSQL_INPUT

echo -e "--award table--"
$PSQL << PSQL_INPUT
DROP TABLE IF EXISTS award;
CREATE TABLE IF NOT EXISTS award(
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    isbn VARCHAR(15) NOT NULL,
    award TEXT NOT NULL,
    award_year VARCHAR(4));
ALTER SEQUENCE award_id_seq RESTART WITH 1                                                                                                                                                                  
PSQL_INPUT

$PSQL << PSQL_INPUT
COPY award(isbn, award, award_year) FROM
       '/home/zivile/Documents/asmeniniai/07_turing/01_module/Turing-project/goodreads/docs/award.csv'
       WITH CSV HEADER DELIMITER ',' QUOTE '"' ESCAPE '\';
PSQL_INPUT

echo -e "--star table--"
$PSQL << PSQL_INPUT
DROP TABLE IF EXISTS star;
CREATE TABLE IF NOT EXISTS star(
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    isbn VARCHAR(15) NOT NULL,
    ratingsByStar INT NOT NULL,
    star VARCHAR(3));
ALTER SEQUENCE star_id_seq RESTART WITH 1                                                                                                                                                                   
PSQL_INPUT

$PSQL << PSQL_INPUT
COPY star(isbn, ratingsByStar, star) FROM
       '/home/zivile/Documents/asmeniniai/07_turing/01_module/Turing-project/goodreads/docs/star.csv'
       WITH CSV HEADER DELIMITER ',' QUOTE '"' ESCAPE '\';
PSQL_INPUT

echo -e "--publication table--"
$PSQL << PSQL_INPUT
CREATE TABLE publication(
  id SERIAL NOT NULL UNIQUE PRIMARY KEY,
  isbn VARCHAR(15) NOT NULL,
  bookFormat VARCHAR(35),
  publisher VARCHAR(110),
  publishDate VARCHAR(20),
  description TEXT,
  series VARCHAR(100),
  rating DECIMAL(6,2) NOT NULL,
  language VARCHAR(40),
  edition TEXT,                                                                                                                                                             
  pages INT,
  numRatings INT NOT NULL,                                                                                                                                                                   
  likedPercent DECIMAL(4, 1),
  coverImg VARCHAR(110),
  bbeScore INT NOT NULL,
  bbeVotes INT NOT NULL,
  price DECIMAL(7,2),
  author TEXT NOT NULL,
  title TEXT NOT NULL);
ALTER SEQUENCE publication_id_seq RESTART WITH 1
PSQL_INPUT

$PSQL << PSQL_INPUT
COPY publication(isbn, bookFormat, publisher, publishDate, description,
       series, rating, language, edition, pages, numRatings,
       likedPercent, coverImg, bbeScore, bbeVotes, price, author, title)
       FROM '/home/zivile/Documents/asmeniniai/07_turing/01_module/Turing-project/goodreads/docs/publication.csv'
       WITH CSV HEADER DELIMITER ',' QUOTE '"' ESCAPE '\';
PSQL_INPUT

# Show created tables
$PSQL -c '\dt'
