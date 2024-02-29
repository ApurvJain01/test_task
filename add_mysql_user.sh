#!/bin/bash
# This shell script is being used to configure a user in the mysql database 

set -eo

# Generating random password for the new db user
PASSWORD=$(cat /dev/random | tr -dc '[:alnum:]' | head -c 20)
USERNAME=test_user
HOSTNAME=localhost

export NEW_USERNAME=${USERNAME}
export NEW_PASSWORD=${PASSWORD}

#Creating a new user in database
mysql -e "CREATE USER '${USERNAME}'@'${HOSTNAME}' IDENTIFIED WITH authentication_plugin BY '${PASSWORD}';"

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('${PASSWORD}') WHERE User = '${USERNAME}'"

