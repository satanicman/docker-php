#!/usr/bin/env bash

source ./config.sh

re='^[0-9]+\.?[0-9]{2}$'
if ! [[ $2 =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

PWD="/var/www/proautomoto/proautomoto.com"

if [[ $1 = "up" ]]
    then
    rsync -czavP --password-file=./rsync_pass ./${2}/up/ ${SSH_USER}@${SSH_HOST}:${PWD} --files-from="./$2/patch.txt"
elif [[ $1 = "down" ]]
    then
    rsync -czavP ./${2}/down/ ${SSH_USER}@${SSH_HOST}:${PWD} --files-from="./$2/patch.txt" --password-file=./rsync_pass
fi
