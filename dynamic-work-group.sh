#!/bin/bash

mail=$(ldapsearch -LLL -H ldap://identity/ -x -b "ou=pi_groups,dc=unity,dc=rc,dc=umass,dc=edu" -s sub "(objectClass=posixGroup)" cn | sed -n 's/^[ \t]*cn:[ \t]*\(.*\)/\1/p')
uidvals=$(echo $mail | sed -e 's/\s\+/,/g')

for i in ${uidvals//,/ }
do
    owner=${i#"pi_"}
    if [ ! -d "/work/$i" ]
    then
        echo "Creating directory /work/$i"
        mkdir /work/$i
        chown $owner:$i /work/$i
	chmod 770 /work/$i
        setfacl -d -m g:$i:rwx /work/$i
	setfacl -m g:$i:rwx /work/$i
    fi
done
