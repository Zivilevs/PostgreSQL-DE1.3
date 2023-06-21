#!/bin/bash

# create role for login to db. My role name is zivile.
sudo -u postgres createuser -P -d -s -e zivile

# Create database books with the owner zivile.
sudo -u postgres createdb -O zivile -e books
