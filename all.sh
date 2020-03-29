#!/bin/bash

type=$(uname|awk -F"-" '{print $2}')
if [[ "$type" == "MSYS_NT" ]];then
    export MSYS="winsymlinks:lnk"
fi

[ -d "$HOME/.local" ] || mkdir $HOME/.local

subdirs=("bsh.d" "vim.d" "git.d")

for dir in ${subdirs[*]}; do
    cd $dir && sh dep.sh && cd ..
    if [ $? -ne 0 ]; then
        echo $(pwd)/$dir
        break
    fi
done

echo "success"

