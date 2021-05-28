"vimrc
"@author Thomas Nichols <thomas@nexus10.com>
"@date 2020-03-27

set encoding=utf-8

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Required by dein:
set runtimepath+=/home/thomasn/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/thomasn/.cache/dein')
  call dein#begin('/home/thomasn/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/thomasn/.cache/dein/repos/github.com/Shougo/dein.vim')




  " ==== plugins ========================
  "
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('lervag/vimtex')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  if has('nvim')
    call dein#add('nvim-lua/popup.nvim')
    call dein#add('nvim-lua/plenary.nvim')
    call dein#add('nvim-telescope/telescope.nvim')
  endif

  let g:deoplete#enable_at_startup = 1

"  call dein#add('preservim/nerdtree')
  
  " Required by dein:
  call dein#end()
  call dein#save_state()
endif 
  " Required by dein:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

colorscheme industry



