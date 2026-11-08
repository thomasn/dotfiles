-- ui.lua - UI enhancements

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- mini.icons supplies which-key's group/keymap icons (v3 prefers it).
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- which-key v3 spec: groups are { "<lhs>", group = "name" }. lazy applies
    -- opts automatically (require("which-key").setup(opts)), so no config fn.
    opts = {
      spec = {
        { "<leader>a", group = "avante/ai" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "hunks" },
        { "<leader>l", group = "llm" },
        { "<leader>r", group = "repl" },
        { "<leader>x", group = "diagnostics" },
      },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        -- lsp_status: spinner while a server starts or indexes, ✓ when ready
        lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
      },
    },
  },
}
