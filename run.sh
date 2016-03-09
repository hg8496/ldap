#!/bin/bash
. ./funcs.sh
if [ ! -d /opt/slapd/db ]; then
    ./init_slapd.sh
fi
startslapd

