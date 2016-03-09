#!/bin/bash

. ./funcs.sh

mkdir -p /opt/slapd/config
mkdir -p /opt/slapd/db
ENCPASSWD=`slapd -T passwd -s $LDAP_ADMIN_PASSWD`
for i in `ls *ldif`
do
    sed -i "s#@password@#$ENCPASSWD#g" $i
    sed -i "s#@basedn@#$BASEDN#g" $i
done
slapadd -F /opt/slapd/config -bcn=config -l conf_db.ldif
chmod -R 0700 /opt/slapd/
chown -R openldap:openldap /opt/slapd/

startslapd&
sleep 1
ldapadd  -x -H ldap://127.0.0.1 -D cn=root,cn=config -w $LDAP_ADMIN_PASSWD -f /etc/ldap/schema/core.ldif
ldapadd  -x -H ldap://127.0.0.1 -D cn=root,cn=config -w $LDAP_ADMIN_PASSWD -f /etc/ldap/schema/cosine.ldif
ldapadd  -x -H ldap://127.0.0.1 -D cn=root,cn=config -w $LDAP_ADMIN_PASSWD -f /etc/ldap/schema/inetorgperson.ldif
ldapadd  -x -H ldap://127.0.0.1 -D cn=root,cn=config -w $LDAP_ADMIN_PASSWD -f /etc/ldap/schema/nis.ldif
ldapadd  -x -H ldap://127.0.0.1 -D cn=root,cn=config -w $LDAP_ADMIN_PASSWD -f user_db.ldif
killall slapd
