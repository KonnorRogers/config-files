#!/bin/bash

sudo sed -i 's/^\([^#]*\)peer\|trust/\1md5/g' /etc/postgresql/11/main/pg_hba.conf
sudo service postgresql restart
