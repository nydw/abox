#!/bin/bash

rm -fr $HOME/.vim
ln -sf $(pwd)/vimrc $HOME/.vimrc
ln -sf $(pwd)/dist/ctags_lang $HOME/.ctags
