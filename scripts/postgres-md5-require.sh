#!/bin/bash

shopt -s dotglob
shopt -s nullglob

array=(/etc/postgresql/*/main/pg_hba.conf)

printf "Changing (peer | trust) auth options to md5 in the following directories\n\n"

for dir in "${array[@]}"; do
  echo "$dir"
  sudo sed -i 's/^\([^#]*\)peer\|trust/\1md5/g' "$dir"
done

sudo /etc/init.d/postgresql restart
