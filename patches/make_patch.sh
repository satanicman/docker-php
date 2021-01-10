#!/usr/bin/env bash

source ./config.sh

re='^[0-9]+\.?[0-9]{2}$'
if ! [[ $2 =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

if [[ $1 = "up" ]]
    then
    rsync -czavP ../app/ ./${2}/up/ --files-from="./$2/patch.txt"
elif [[ $1 = "down" ]]
    then
    rsync -czavP ../app/ ./${2}/down/ --files-from="./$2/patch.txt"
fi
