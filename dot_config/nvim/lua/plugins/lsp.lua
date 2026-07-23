-- lsp.lua - LSP configuration for Julia, Vue, TypeScript

return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- Neovim 0.11 native LSP API: vim.lsp.config() + vim.lsp.enable().
      -- nvim-lspconfig ships the base lsp/*.lua definitions that these merge
      -- on top of; we never call lspconfig.<server>.setup() here.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = { prefix = "●", source = "if_many" },
        float = { border = "rounded", source = true },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Shared defaults for every server
      vim.lsp.config("*", { capabilities = capabilities })

      -- LSP keymaps, set when any server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("faerieconfig_lsp_attach", { clear = true }),
        callback = function(ev)
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
          map("n", "gr", vim.lsp.buf.references, "Goto References")
          map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
          map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
          map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("v", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format")

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight") then
            local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = ev.buf, group = group })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              group = group, buffer = ev.buf, callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              group = group, buffer = ev.buf, callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Julia
      vim.lsp.config("julials", {
        settings = {
          julia = {
            lint = { missingrefs = "all", iter = true, lazy = true, modname = true },
          },
        },
      })

      -- Vue + TypeScript in HYBRID MODE (Vue 3 tooling / vue_ls, formerly volar):
      -- ts_ls owns TypeScript with the @vue/typescript-plugin loaded, and
      -- vue_ls handles the template/SFC half. This is the modern replacement
      -- for the single all-in-one volar server.
      local vue_ls_path = vim.fn.expand(
        "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
      )
      vim.lsp.config("ts_ls", {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_ls_path,
              languages = { "vue" },
            },
          },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- vue_ls runs in hybrid mode by default in 3.0 (takeOverMode off).
      vim.lsp.config("vue_ls", {})

      -- Lua (for Neovim config)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = { callSnippet = "Replace" },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      })

      -- Bash / Python / JSON
      vim.lsp.config("bashls", {})
      vim.lsp.config("pylsp", {
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = { enabled = false },
              pylint = { enabled = false },
              flake8 = { enabled = false },
            },
          },
        },
      })
      vim.lsp.config("jsonls", {})

      -- Turn the configured servers on.
      vim.lsp.enable({
        "julials", "ts_ls", "vue_ls", "lua_ls", "bashls", "pylsp", "jsonls",
      })
    end,
  },

  -- Mason - LSP installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason LSP config bridge
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "julials",
        "ts_ls",
        "vue_ls",
        "bashls",
        "pylsp",
        "jsonls",
      },
      -- We enable servers explicitly via vim.lsp.enable() in lsp.lua, so keep
      -- mason-lspconfig from auto-enabling them a second time.
      automatic_enable = false,
    },
  },
}
