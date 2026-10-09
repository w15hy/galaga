#!/bin/sh
printf '\033c\033]0;%s\a' Galaga
base_path="$(dirname "$(realpath "$0")")"
"$base_path/galaga.x86_64" "$@"
