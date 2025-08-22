#!/usr/bin/env bash
set -eu

ENV_FILE="${HOME}/.config/scripts/.env.run-ide"
SLEEP_TIME=10s

while [ $# -gt 0 ]; do
  case "$1" in
    -e|--env-file) ENV_FILE="$2"; shift 2;;
		-t|--sleep-time) SLEEP_TIME="$2"; shift 2;;
    *) echo 'unknown argument !' ; exit 1;;
  esac
done

openProjects() {
    if [ -z "$1" ]; then
        echo 'no args !'
        return 1
    fi

    for IT in "$@"; do
        echo "opening \`${IT}\` project ..."
        /bin/sh -c "nohup idea $IT > /dev/null 2>&1 &"
        sleep "$SLEEP_TIME"
    done
}

if [ ! -f "$ENV_FILE" ]; then
	echo "env file \`${ENV_FILE}\` does not exist"
	exit 1
fi 

set -a ; source "$ENV_FILE" ; set +a
openProjects $PROJECTS

