#!/bin/bash
pg_user="postgres"
pg_dir="/var/lib/postgresql"
pg_data="/var/lib/postgresql/data"

# Installs postgresql
sudo apt update && sudo apt install \
  postgresql postgresql-contrib postgresql-common libpq-dev -y

# Creates the postgres user and postgres group
sudo groupadd "$pg_user"
sudo useradd -r -g "$pg_user" --home-dir="$pg_dir" --shell=/bin/bash "$pg_user"

sudo mkdir -p "$pg_dir"
sudo chown -R "$pg_user":"$pg_user" "$pg_dir"

sudo mkdir -p "$pg_dir" && sudo chown -R "$pg_user":"$pg_user" "$pg_dir" && \
  sudo chmod 2777 /var/run/postgresql


# this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)
sudo mkdir -p "$pg_data" \
  && sudo chown -R "$pg_user":"$pg_user" "$pg_data" \
  && sudo chmod 777 "$pg_data"

