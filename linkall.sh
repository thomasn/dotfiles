#!/bin/bash
[ -d ~/.vim ] || mkdir ~/.vim

ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/screenrc ~/.screenrc
ln -s ~/dotfiles/vimrc ~/.vim/vimrc
