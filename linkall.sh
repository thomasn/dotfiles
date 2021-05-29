#!/bin/bash

mkdir ~/.vim
mkdir -p ~/.config/nvim
mkdir -p ~/.cache/dein
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/screenrc ~/.screenrc
ln -s ~/dotfiles/vimrc ~/.vim/vimrc
ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim
