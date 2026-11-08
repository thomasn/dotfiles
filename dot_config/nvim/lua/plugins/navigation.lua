-- navigation.lua - Telescope, Treesitter, Oil

return {
  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    },
    opts = {
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
  },

  -- Treesitter (main branch: parsers + queries only; highlighting, folds and
  -- incremental selection (v_an / v_in) are Neovim built-ins). Installing
  -- parsers needs the tree-sitter CLI. The plugin does not support lazy-loading.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "bash", "c", "diff", "html", "javascript", "jsdoc", "json", "julia",
        "lua", "luadoc", "luap", "markdown", "markdown_inline", "python",
        "query", "regex", "toml", "tsx", "typescript", "vim", "vimdoc", "vue",
        "yaml",
      }
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("faerieconfig_treesitter", { clear = true }),
        callback = function(ev)
          -- Start only where a parser exists for this filetype.
          if not pcall(vim.treesitter.start, ev.buf) then
            return
          end
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Treesitter motions. The af/if/ac/ic selections come from mini.ai
  -- (editor.lua), so only the moves are mapped here. Class moves use ]k/[k
  -- so that ]c/[c keep jumping between changes in diff mode.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter-textobjects").setup({ move = { set_jumps = true } })
      local move = require("nvim-treesitter-textobjects.move")
      local maps = {
        { "]f", "goto_next_start", "@function.outer", "Next function start" },
        { "]F", "goto_next_end", "@function.outer", "Next function end" },
        { "[f", "goto_previous_start", "@function.outer", "Previous function start" },
        { "[F", "goto_previous_end", "@function.outer", "Previous function end" },
        { "]k", "goto_next_start", "@class.outer", "Next class start" },
        { "]K", "goto_next_end", "@class.outer", "Next class end" },
        { "[k", "goto_previous_start", "@class.outer", "Previous class start" },
        { "[K", "goto_previous_end", "@class.outer", "Previous class end" },
      }
      for _, m in ipairs(maps) do
        vim.keymap.set({ "n", "x", "o" }, m[1], function()
          move[m[2]](m[3], "textobjects")
        end, { desc = m[4] })
      end
    end,
  },

  -- Oil.nvim file manager, standing in for netrw (disabled in init.lua).
  -- Loaded at startup so `:e .`, `:e dir/` and `nvim .` open it; lazy-loading
  -- left those as blank buffers. `-` opens the current file's directory, and
  -- `-` inside Oil goes up a level (vim-vinegar style).
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open File Explorer" },
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      -- netrw long-listing style
      columns = { "icon", "permissions", "size", "mtime" },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
      },
    },
  },
}
