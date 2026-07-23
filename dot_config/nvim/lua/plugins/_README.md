# Neovim Plugins Configuration

This directory contains all plugin configurations for faerieconfig.

## Plugin Categories:

1. **ai.lua** - AI assistants (Copilot, Avante, llm.nvim)
2. **lsp.lua** - Language Server Protocol configuration
3. **completion.lua** - nvim-cmp autocompletion
4. **navigation.lua** - Telescope, Oil, Treesitter
5. **julia.lua** - Julia language support
6. **vue-ts.lua** - Vue/TypeScript support
7. **git.lua** - Git integration (Gitsigns, Fugitive)
8. **ui.lua** - UI enhancements (Which-key, Noice, etc.)
9. **editor.lua** - Editor utilities (surround, comments, etc.)

Core config is created by 5-create-neovim.sh; plugin specs by
6-neovim-plugins.sh (ai, lsp, completion) and 7-complete-setup.sh
(navigation, julia, vue-ts, git, ui, editor).
