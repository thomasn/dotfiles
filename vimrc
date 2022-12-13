"vimrc
"@author Thomas Nichols <thomas@nexus10.com>
"@date 2020-03-27

set encoding=utf-8

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Required by dein:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')




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
    call dein#add('sudormrfbin/cheatsheet.nvim')
     call dein#add('neovim/nvim-lspconfig')
"    call dein#add('kabouzeid/nvim-lspinstall')    -- not responding

" the below is a Lua code block
lua << EOF
 require 'lspconfig'.julials.setup{}
EOF
"  local nvim_lsp = require'lspconfig'
"     nvim_lsp.julials.setup()

"         " alternatively one can call `nvim_lsp.julials.setup()` above if not
"         using diagnostic-nvim
"     nvim_lsp.julials.setup({on_attach=require'diagnostic'.on_attach})

"
"         " enable completion (requires separate plugin such as deoplete-lsp)
"         autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc

" call dein#add('autozimu/LanguageClient-neovim', {
" \ 'rev': 'next',
" \ 'build': 'bash install.sh',
" \ })
  endif
  let g:deoplete#enable_at_startup = 1

"  call dein#add('preservim/nerdtree')
  call dein#add('JuliaEditorSupport/julia-vim')
  
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



