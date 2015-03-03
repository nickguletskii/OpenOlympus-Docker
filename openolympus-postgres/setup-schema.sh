#!/bin/bash
echo "******CREATING DOCKER DATABASE******"
gosu postgres postgres --single <<- EOSQL
CREATE DATABASE openolympus WITH ENCODING='UTF8' OWNER=postgres LC_COLLATE='en_US.utf8' LC_CTYPE='en_US.utf8' CONNECTION LIMIT=-1;
EOSQL
echo "******DOCKER DATABASE CREATED******"
