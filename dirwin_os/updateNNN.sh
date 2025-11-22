#!/bin/bash -x

# working file with nnn v5.1

cd $HOME/Developer/git_repository/nnn

echo $PWD

git clean -dfx
git checkout -f
git pull

command cp -p "$DOT_FILE/global/nnn.h" src/nnn.h


export O_PCRE2=1
export O_NOMOUSE=1
export O_NOX11=1
export O_GITSTATUS=1
make clean strip install
