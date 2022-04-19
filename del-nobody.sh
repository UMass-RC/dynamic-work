#!/bin/bash

mail=$(ldapsearch -LLL -H ldap://identity/ -x -b "ou=users,dc=unity,dc=rc,dc=umass,dc=edu" -s sub "(objectClass=posixAccount)" uid | sed -n 's/^[ \t]*uid:[ \t]*\(.*\)/\1/p')
uidvals=$(echo $mail | sed -e 's/\s\+/,/g')

for i in ${uidvals//,/ }
do
    if [ -d "/work/$i" ]; then
        uname2="$(stat --format '%U' "/work/$i")"
        if [ "x${uname2}" = "xhsaplakoglu_umass_edu" ]; then
            echo "Deleting /work/$i"
            rm -rf /work/$i
        fi
    fi
done
