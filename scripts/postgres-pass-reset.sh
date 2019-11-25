#!/bin/bash

shopt -s dotglob
shopt -s nullglob

array=(/etc/postgresql/*/main/pg_hba.conf)

printf "Changing postgres auth options to 'trust' in the following directories...\n\n"

postgres_options="md5\|peer\|reject\|password\|gss\|sspi\|ident\|peer\|pam\|ldap\|radius\|cert"
for dir in "${array[@]}"; do
  echo "$dir"
  sudo sed -i "s/^\([^#]*\)$postgres_options/\1trust/g" "$dir"
done

sudo /etc/init.d/postgresql restart
printf "\n\nTo change your password run the following:\n\n"

echo "psql -U postgres"
echo "alter user postgres with password 'NEW_PASSWORD'"
echo "\q"

printf "\nThen run the postgres-md5-require.sh script to secure your database"

