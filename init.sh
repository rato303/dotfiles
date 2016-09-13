#!/bin/sh

mkdir -p ~/.vim/dein

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
sh /tmp/installer.sh ~/.vim/dein/

ln -sf ~/dotfiles/.vimrc ~/.vimrc
