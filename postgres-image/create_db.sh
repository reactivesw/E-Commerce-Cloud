#!/bin/bash
set -e

POSTGRES="psql --username ${POSTGRES_USER}"

$POSTGRES <<EOSQL
CREATE DATABASE cart;
CREATE DATABASE category;
CREATE DATABASE customer_authentication;
CREATE DATABASE customer_info;
CREATE DATABASE inventory;
CREATE DATABASE orders;
CREATE DATABASE payment;
CREATE DATABASE product;
CREATE DATABASE product_type;
EOSQL