#!/bin/bash

mail=$(ldapsearch -LLL -H ldap://identity/ -x -b "ou=users,dc=unity,dc=rc,dc=umass,dc=edu" -s sub "(objectClass=posixAccount)" uid | sed -n 's/^[ \t]*uid:[ \t]*\(.*\)/\1/p')
uidvals=$(echo $mail | sed -e 's/\s\+/,/g')

for i in ${uidvals//,/ }
do
    if [ ! -d "/work/$i" ]
    then
        echo "Creating directory /work/$i"
        mkdir /work/$i
        chown $i:$i /work/$i
    fi
done
