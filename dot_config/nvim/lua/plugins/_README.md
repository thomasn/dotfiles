# Neovim Plugins Configuration

One lazy.nvim spec file per concern. Edit these in the chezmoi source
(`~/faerieconfig/chezmoi/dot_config/nvim/`), not in `~/.config/nvim`.

1. **ai.lua** - AI assistants (Copilot inline, Avante chat, llm.nvim + Ollama)
2. **lsp.lua** - LSP via Neovim's `vim.lsp.config()`, Mason, lazydev
3. **completion.lua** - nvim-cmp autocompletion and LuaSnip
4. **navigation.lua** - Telescope, Treesitter (`main` branch), textobject moves, Oil
5. **julia.lua** - Julia language support and vim-slime REPL
6. **vue-ts.lua** - Vue/TypeScript support (hybrid-mode work parked)
7. **git.lua** - Gitsigns, Fugitive
8. **ui.lua** - Colourscheme, which-key, Trouble, lualine, bufferline
9. **editor.lua** - mini.surround, mini.pairs, mini.ai, autotag

Plugin versions are pinned by `lazy-lock.json` (tracked in chezmoi).
See `docs/KEYBINDINGS.md` for the key reference.
