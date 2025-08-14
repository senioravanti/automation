#!/usr/bin/env zsh
set -eu

COMMIT='feat: sync'
GIT_DIR="${HOME}/.dotfiles"
WORK_TREE="${HOME}/.config"

gconf() {
	git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" "$@"
}

while [ $# -gt 0 ]; do
	case "$1" in
		-c|--commit) COMMIT="$2"; shift 2;;
		*) echo 'unknown argument'; exit 1;;
	esac
done

if [ ! -d "$GIT_DIR" ]; then
	echo "init bare repo \`${GIT_DIR}\` ..."
	mkdir "${GIT_DIR}/"
	git init --bare "$GIT_DIR"
	gconf branch -m main
	gconf config --local status.showUntrackedFiles no
	gconf remote add origin 'git@github.com:senioravanti/dotfiles.git'
fi

if [ ! -f "${WORK_TREE}/.gitignore" ]; then
	cat <<-EOF > "${WORK_TREE}/.gitignore"
	.*
	!.zshrc
EOF
fi

gconf add "zsh"
gconf add "tmux/tmux.conf"
gconf add "alacritty/alacritty.toml"

gconf add "nvim/lua"
gconf add "nvim/init.lua"

gconf commit -m "$COMMIT"
gconf push origin main

