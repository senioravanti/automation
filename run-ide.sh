#!/usr/bin/env bash
set -eu

function openProjects() {
    if [ -z "$1" ]; then
        echo 'no args !'
        return 1
    fi

    for IT in "$@"; do
        echo "open $IT"
        /bin/sh -c "nohup idea $IT > /dev/null 2>&1 &"
        sleep 10s
    done
}

ENV_FILE="/home/senioravanti/.config/scripts/.env.run-idea"

if [ ! -f "$ENV_FILE" ]; then
	echo "env file \`${ENV_FILE}\` does not exist"
	exit 1
fi 

set -a ; source "$ENV_FILE" ; set +a

openProjects $PROJECTS

