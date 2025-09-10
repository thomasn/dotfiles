-- @title Neovim init.lua (Lazy.nvim version)
-- @author Thomas Nichols
-- @date 2025-09-09

-- Bootstrap Lazy.nvim if not already installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- List of plugins
local plugins = {
  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
  'nvim-telescope/telescope.nvim',
  'sudormrfbin/cheatsheet.nvim',
  'nvim-lua/completion-nvim',
  'kdheepak/JuliaFormatter.vim',
  -- { 'neoclide/coc.nvim', branch = 'release' },
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'simrat39/rust-tools.nvim',
  'sharkdp/fd',
  'tpope/vim-fugitive',
  'tpope/vim-dispatch',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-vsnip',
  -- 'hrsh7th/nvim-cmp',
  'hrsh7th/vim-vsnip',
  'nvim-treesitter/nvim-treesitter',
  'L3MON4D3/LuaSnip',
}

require('lazy').setup(plugins)

-- Rust Tools Setup (unchanged)
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- nvim-cmp Setup (unchanged)
-- local cmp = require'cmp'
--  cmp.setup({
-- snippet = {
--   expand = function(args)
--   vim.fn["vsnip#anonymous"](args.body)
--    end,
--  },

 -- weird nvim-cmp behaviour...
-- window = {
-- documentation = cmp.config.window.bordered(),
-- },
--
--   mapping = cmp.mapping.preset.insert({
--     [''] = cmp.mapping.select_prev_item(),
--     [''] = cmp.mappig.select_next_item(),
--     [''] = cmp.mapping.scroll_docs(-4),
--     [''] = cmp.mapping.scroll_docs(4),
--     [''] = cmp.mapping.complete(),
--     [''] = cmp.mapping.close(),
--     [''] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       select = true,
--     }),
--   }),

sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua', keyword_length = 2 },
    { name = 'buffer', keyword_length = 2 },
    { name = 'vsnip', keyword_length = 2 },
    { name = 'calc' },
  },

  -- window = {
  --   completion = cmp.config.window.bordered(),
  --   documentation = cmp.config.window.bordered(),
  -- },
  
  -- formatting = {
  --   fields = {'menu', 'abbr', 'kind'},
  --   format = function(entry, item)
  --     local menu_icon = {
  --       nvim_lsp = 'λ',
  --       vsnip = '⋗',
  --       buffer = 'Ω',
  --       path = '🖫',
  --     }
  --     item.menu = menu_icon[entry.source.name]
  --     return item
  --   end,
  -- },
})
