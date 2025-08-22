#!/usr/bin/env bash
set -eu

ENV_FILE="${HOME}/.config/scripts/.env.spring-start"

if [ ! -f "$ENV_FILE" ]; then
	echo "env file \`${ENV_FILE}\` does not exist"
	exit 1
fi

set -a; . "$ENV_FILE"; set +a

if [ ! -d "$PROJECT_LOCATION" ]; then
  mkdir -p "$PROJECT_LOCATION"
fi

spring init \
  -a "$PROJECT_NAME" \
  -g 'ru.manannikov' \
  -j 21 \
  -l "$LANG" \
  --boot-version 3.5.3 \
  --format project \
  --build "$BUILD_TOOL" \
  -p jar \
  -v '0.1' \
  -d "$PROJECT_DEPENDENCIES" \
  "$PROJECT_LOCATION"

