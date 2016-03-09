#!/bin/bash
function startslapd {
    slapd -u openldap -g openldap -F /opt/slapd/config -d 256
}
