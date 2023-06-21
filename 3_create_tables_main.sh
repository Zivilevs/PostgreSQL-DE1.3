#!/bin/bash

PSQL="psql --username=zivile --dbname=books"

$PSQL << PSQL_INPUT
DROP TABLE IF EXISTS book;
CREATE TABLE book(
  id SERIAL NOT NULL UNIQUE PRIMARY KEY,
  isbn VARCHAR(15) NOT NULL,
  title TEXT NOT NULL,
  series VARCHAR(100),
  author TEXT NOT NULL,
  rating DECIMAL(6,2) NOT NULL,
  description TEXT,
  firstPublishDate VARCHAR(20));
PSQL_INPUT

# show created table
$PSQL -c '\d book'
  
