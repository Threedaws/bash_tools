#!/usr/bin/bash
## Test SSL certificate by hostname.
##
## Usage with hostname and (optional) secondary parameter "show", if U want look at sertificate.

if [ -z $1 ]; then
    echo "Usage $0 <domain> [show]"; exit 1
else
    nslookup $1 || exit 1
fi

MODE=${2:-none}
PORT=${3:-443}
if [[ "$MODE" != "show" ]]; then
    openssl s_client -showcerts -servername $1 -connect $1:$PORT <<< "Q" | openssl x509 -text | grep -iA2 "Validity"
else
    openssl s_client -showcerts -servername $1 -connect $1:$PORT <<< "Q"
fi
