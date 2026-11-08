-- ai.lua - AI assistant configuration
-- Copilot: inline completion. Avante: chat and refactors. llm.nvim: local
-- Ollama completion for offline or sensitive code. See docs/WORKFLOW.md.

return {
  -- GitHub Copilot (Free tier)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
  },

  -- Avante.nvim - Claude/DeepSeek integration
  {
    "yetone/avante.nvim",
    -- Opt-in: load on first use (keys/commands), NOT at startup, so Ollama
    -- is only contacted when avante is actually invoked.
    build = "make",
    cmd = { "AvanteAsk", "AvanteToggle", "AvanteEdit", "AvanteRefresh", "AvanteChat" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    keys = {
      { "<leader>ai", "<cmd>AvanteToggle<cr>", desc = "Toggle Avante" },
      { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante Ask", mode = { "n", "v" } },
      { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante Refresh" },
      { "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Avante Edit", mode = "v" },
      { "<leader>as", "<cmd>AvanteSwitchProvider<cr>", desc = "Switch AI Provider" },
    },
    opts = {
      provider = "ollama",
      auto_suggestions_provider = "ollama",
      -- Local Ollama provider (no auth, no subscription). Requires Ollama
      -- running with the model pulled (the `ai` Ansible role does this).
      -- avante is opt-in, so Ollama is only contacted when you invoke avante.
      providers = {
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          model = "deepseek-coder-v2:16b-lite-instruct-q4_K_M",
          extra_request_body = {
            options = {
              temperature = 0,
              num_ctx = 4096,
            },
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },
      mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      hints = { enabled = true },
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
    },
  },

  -- llm.nvim - Local LLM integration (Ollama)
  {
    "huggingface/llm.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>lm", "<cmd>LLMToggleAutoSuggest<cr>", desc = "Toggle LLM auto-suggest" },
      { "<leader>ls", "<cmd>LLMSuggestion<cr>", desc = "LLM Suggestion", mode = { "n", "v" } },
    },
    opts = {
      backend = "ollama",
      model = "deepseek-coder-v2:16b-lite-instruct-q4_K_M",
      url = "http://localhost:11434/api/generate",
      request_body = {
        options = {
          temperature = 0.2,
          top_p = 0.95,
        },
      },
      -- llm-ls builds the prompt as prefix..before..suffix..after..middle,
      -- so DeepSeek's <｜fim▁hole｜> is "suffix" and <｜fim▁end｜> is "middle".
      fim = {
        enabled = true,
        prefix = "<｜fim▁begin｜>",
        suffix = "<｜fim▁hole｜>",
        middle = "<｜fim▁end｜>",
      },
      debounce_ms = 150,
      accept_keymap = "<C-y>",
      dismiss_keymap = "<C-n>",
      context_window = 4096,
      enable_suggestions_on_startup = false,
      enable_suggestions_on_files = "*.jl,*.vue,*.ts,*.js,*.py",
    },
  },
}
