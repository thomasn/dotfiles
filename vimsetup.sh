#!/bin/bash
echo 'Execute linkall.sh before this script [press enter to continue]'
read dummy
cd ~/dotfiles
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# Install dein for use by both vim and neovim:
sh installer.sh ~/.cache/dein
echo 'Need pip3 to install the neovim python provider - install python-pip if not present [press enter to continue]'
pip3 install --user --upgrade neovim
echo 'Open nvim and execute:'
echo ':call dein#install()'
echo ':UpdateRemotePlugins'
