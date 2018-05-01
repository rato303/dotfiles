#!/bin/sh

mkdir -p ~/.vim/dein/toml

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
sh /tmp/installer.sh ~/.vim/dein/

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/toml/plugins.toml ~/.vim/dein/toml/plugins.toml
ln -sf ~/dotfiles/toml/plugins_lazy.toml ~/.vim/dein/toml/plugins_lazy.toml
