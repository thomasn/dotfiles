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
  " call dein#add('lervag/vimtex')
  " call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
 endif
  if has('nvim')
    call dein#add('nvim-lua/popup.nvim')
    call dein#add('nvim-lua/plenary.nvim')
    call dein#add('nvim-telescope/telescope.nvim')
    call dein#add('sudormrfbin/cheatsheet.nvim')
    " call dein#add('nvim-lua/diagnostic-nvim')
    call dein#add('nvim-lua/completion-nvim')
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('kdheepak/JuliaFormatter.vim')

    " call dein#add('deoplete-plugins/deoplete-lsp')

    autocmd BufEnter * lua require'completion'.on_attach()

"" lua << EOF
""     local nvim_lspconfig = require'lspconfig'
""     nvim_lspconfig.julials.setup{}
"" EOF


lua << EOF
require'lspconfig'.julials.setup{
    on_new_config = function(new_config,new_root_dir)
      server_path = "~/.julia/packages/LanguageServer.jl/src"
      cmd = {
        "julia",
        "--project="..server_path,
        "--startup-file=no",
        "--history-file=no",
        "-e", [[
          using Pkg;
          Pkg.instantiate()
          using LanguageServer; using SymbolServer;
          depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
          project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
          # Make sure that we only load packages from this environment specifically.
          @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
          server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
          server.runlinter = true;
          run(server);
        ]]
    };
      new_config.cmd = cmd
    end
}
EOF

let g:diagnostic_auto_popup_while_jump = 0
let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_enable_underline = 0
let g:completion_timer_cycle = 200 "default value is 80


    " enable completion for Julia
    autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc


  endif " has_nvim
  
  " let g:deoplete#enable_at_startup = 1

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

