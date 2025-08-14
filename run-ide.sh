# /home/anton/code/run-idea.sh idea /home/anton/code/.env.run-idea

function exitWithMsg() {
  echo $1; exit 1
}

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

if [ $# -eq 0 ]; then
  ENV_FILE=/home/senioravanti/projects/devops/scripts/.env.run-idea
fi

if [ ! -f "$ENV_FILE" ]; then
  exitWithMsg 'no .env file !'
fi 

set -a ; source "$ENV_FILE" ; set +a
if [ -z "$PROJECTS" ]; then
  exitWithMsg 'projects variable is missing'
fi

openProjects $PROJECTS
