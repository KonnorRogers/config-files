#!/bin/bash

shopt -s dotglob
shopt -s nullglob

array=(/etc/postgresql/*/main/pg_hba.conf)

postgres_options="trust\|peer\|reject\|password\|gss\|sspi\|ident\|peer\|pam\|ldap\|radius\|cert"
printf "Changing all auth options to md5 in the following directories\n\n"

for dir in "${array[@]}"; do
  echo "$dir"
  sudo sed -i "s/^\([^#]*\)$postgres_options/\1md5/g" "$dir"
done

sudo /etc/init.d/postgresql restart

printf "\n Your postgres now uses md5 based passwords!"
