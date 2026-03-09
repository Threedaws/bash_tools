#!/usr/bin/bash
#
# Description: This script generates a string from a random sequence of characters from A to Z,
# adding two digits from 0 to 9 and two special character from the additional alphabet.
# By default, the alphabet is defined by the sequence "~!?@#%^&_-+()[]{}><'.,:"
# Author: Dmitry G.
# Version: 3.0
#
# Tested on CentOS Linux release 7.9, Fedora Linux 39, Debian GNU/Linux 12

make_password() {
    LEN=$(( $1 - 4 ))
    ALPH=$2
    PASS=$(cat /dev/urandom | tr -cd "0-9a-zA-Z" | head -c $LEN)

    declare -a TMP=( $(fold -w1 <<< "0123456789") )
    ARR=( $(printf '%s\n' "${TMP[@]}" | shuf) )
    PASS=$PASS${ARR[0]}${ARR[1]}

    declare -a TMP=( $(fold -w1 <<< "$ALPH") )
    ARR=( $(printf '%s\n' "${TMP[@]}" | shuf) )
    PASS=$PASS${ARR[0]}${ARR[1]}

    declare -a TMP=( $(fold -w1 <<< "$PASS") )
    PASS=( $(printf '%s\n' "${TMP[@]}" | shuf) )
    printf "%s" "${PASS[@]}"
}


PASS_LEN=${1:-12}
ALPHABET=${2:-"~!?@#%^&_-+()[]{}><'.,:"}

echo $(make_password $PASS_LEN $ALPHABET)
