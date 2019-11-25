#!/bin/bash

sudo sed -i 's/^\([^#]*\)md5\|peer/\1trust/g' /etc/postgresql/11/main/pg_hba.conf
sudo service postgresql restart
