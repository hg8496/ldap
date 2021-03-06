FROM ubuntu

MAINTAINER hg8496@cstolz.de

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install slapd ldap-utils -y

ADD run.sh run.sh
ADD conf_db.ldif conf_db.ldif
ADD init_slapd.sh init_slapd.sh
ADD funcs.sh funcs.sh
ADD user_db.ldif user_db.ldif

CMD ["/run.sh"]

ENV LDAP_ADMIN_PASSWD P@assw0rd1
ENV BASEDN dc=test,dc=local

EXPOSE 389 636
