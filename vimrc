"vimrc
"@author Thomas Nichols <thomas@nexus10.com>
"@date 2020-03-27

set encoding=utf-8

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Reuired by dein:
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
lua << EOF
require 'lspconfig'.julials.setup{}
EOF
    " call dein#add('deoplete-plugins/deoplete-lsp')
    " enable completion for Julia
    autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc


"         using diagnostic-nvim
"     nvim_lsp.julials.setup({on_attach=require'diagnostic'.on_attach})

"
" call dein#add('autozimu/LanguageClient-neovim', {
" \ 'rev': 'next',
" \ 'build': 'bash install.sh',
" \ })

  endif " has_nvim
  
  let g:deoplete#enable_at_startup = 1

  call dein#add('JuliaEditorSupport/julia-vim')
  call dein#add('tpope/vim-fugitive')

  " Required by dein:
  call dein#end()
  call dein#save_state()


nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>


endif " dein#load_state
" Required by dein:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

colorscheme industry
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
set number
filetype plugin indent on
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

