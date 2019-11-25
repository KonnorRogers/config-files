#!/bin/bash

# This is a sample script of how to get multiple directories into an array

# /etc/postgresql/11/main/pg_hba.conf
# /etc/postgresql/10/main/pg_hba.conf
# /etc/postgresql/9.5/main/pg_hba.conf
shopt -s dotglob
shopt -s nullglob
array=(/etc/postgresql/*/main/pg_hba.conf)
for dir in "${array[@]}"; do echo "$dir"; done
