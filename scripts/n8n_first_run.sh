#!/bin/sh

if test -f "/home/node/.n8n/.has_been_run"; then
    exit 0
fi

#/usr/local/bin/n8n import:credentials --separate --input=/backup/credentials && 
/usr/local/bin/n8n import:workflow --separate --input=/resources/n8n-workflows

touch /home/node/.n8n/.has_been_run
