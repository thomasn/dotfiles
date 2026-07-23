-- julia.lua - Julia language support

return {
  {
    "JuliaEditorSupport/julia-vim",
    -- Loaded eagerly (not ft-lazy): its ftdetect installs a global BufEnter
    -- autocmd calling LaTeXtoUnicode#Refresh, and under lazy-loading the
    -- autoload isn't yet on runtimepath -> E117. Eager load keeps it defined.
    lazy = false,
    init = function()
      -- Tab-completion of LaTeX -> Unicode in Julia files. `auto` (convert as
      -- you type in ALL buffers) installs a global BufEnter hook that errors
      -- with "E117: Unknown function: LaTeXtoUnicode#Refresh" on non-Julia
      -- buffers under lazy-loading, so keep it off. Set in init (before load).
      vim.g.latex_to_unicode_tab = 1
      vim.g.latex_to_unicode_auto = 0
    end,
  },

  {
    "jpalardy/vim-slime",
    ft = "julia",
    keys = {
      { "<C-c><C-c>", "<Plug>SlimeParagraphSend", desc = "Send paragraph to REPL", ft = "julia" },
      { "<C-c><C-c>", "<Plug>SlimeRegionSend", desc = "Send region to REPL", mode = "v", ft = "julia" },
      { "<leader>rr", "<cmd>SlimeSend1 exit()<CR>", desc = "Restart Julia REPL", ft = "julia" },
      { "<leader>rc", "<cmd>SlimeSend1 clear()<CR>", desc = "Clear REPL", ft = "julia" },
    },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{right}",
      }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_no_mappings = 1
    end,
  },
}
