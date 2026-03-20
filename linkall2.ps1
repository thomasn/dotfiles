echo "Expecting to be executed from Admin Powershell."
read x
# See Obsidian notes - use cmd\c mklink to create symlinks
mkdir ~\.vim
mkdir ~\.config
mkdir ~\.config\nvim
mkdir ~\.cache
mkdir ~\.cache\dein
cd ~
cmd /c mklink .tmux.conf ~\dotfiles\tmux.conf
cmd /c mklink .screenrc ~\dotfiles\screenrc
cd ~\.vim
cmd /c mklink vimrc ~\dotfiles\vimrc 
mkdir ~\AppData
mkdir ~\AppData\Local
mkdir ~\AppData\Local\nvim
rem cd ~\.config\nvim
cd ~\AppData\Local\nvim
 cmd /c mklink init.vim ~\dotfiles\vimrc
 cd ~
 
