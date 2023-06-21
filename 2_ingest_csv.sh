#!/bin/bash

PSQL="psql --username=zivile --dbname=books"

$PSQL << PSQL_INPUT
DROP TABLE IF EXISTS books_raw;
CREATE TABLE IF NOT EXISTS books_raw (
    bookId varchar(150) not null,
    title text not null,
    series varchar(100),
    author text not null,
    rating decimal(6,2) not null,
    description text,
    language varchar(40),
    isbn varchar(15) not null,
    genres text[],
    characters text[],
    bookFormat varchar(35),                                                                                                                                                                       
    edition text,                                                                                                                                                                      
    pages int,                                                                                                                                                                          
    publisher varchar(110),                                                                                                                                                                     
    publishDate varchar(20),                                                                                                                                                                
    firstPublishDate varchar(20),                                                                                                                                                                       
    awards text[],                                                                                                                                                                       
    numRatings int not null,                                                                                                                                                                    
    ratingsByStars int[],                                                                                                                                                                         
    likedPercent decimal(4, 1),
    setting text[],
    coverImg varchar(110),
    bbeScore int not null,
    bbeVotes int not null,
    price decimal(7,2));
PSQL_INPUT

$PSQL << PSQL_INPUT
COPY books_raw(bookId, title, series, author, rating, description,
       language, isbn, genres, characters, bookFormat, edition,
       pages, publisher, publishDate, firstPublishDate, awards,
       numRatings, ratingsByStars, likedPercent, setting, coverImg,
       bbeScore, bbeVotes, price) FROM
       '/home/zivile/Documents/asmeniniai/07_turing/01_module/Turing-project/goodreads/data-preparation.csv'
       WITH CSV HEADER DELIMITER ',' QUOTE '"' ESCAPE '\';

PSQL_INPUT