-- @title Neovim init.lua
-- @author Thomas Nichols <thomas@nexus10.com>
-- @date 2023-03-08

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'sudormrfbin/cheatsheet.nvim'
  use 'nvim-lua/completion-nvim'
  use 'kdheepak/JuliaFormatter.vim'

  use 'williamboman/mason.nvim'
  require('mason').setup()

  use 'williamboman/mason-lspconfig.nvim'
  use 'simrat39/rust-tools.nvim'
  use 'sharkdp/fd'  -- disable if unused
  use 'sudormrfbin/cheatsheet.nvim'
  use 'tpope/vim-fugitive'


  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/vim-vsnip"

  -- Rust --
  local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- Julia --
-- TODO



-- WIP migration from vimrc --
--
--[[
" let g:diagnostic_auto_popup_while_jump = 0
" let g:diagnostic_enable_virtual_text = 0
" let g:diagnostic_enable_underline = 0
" let g:completion_timer_cycle = 200 "default value is 80

" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
--]]


end)
  
