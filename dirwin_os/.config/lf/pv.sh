#!/bin/sh

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *) bat --paging=never --style=numbers --terminal-width $(($2-5)) -f "$1" || true;;
esac
