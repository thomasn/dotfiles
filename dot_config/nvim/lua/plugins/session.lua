-- session.lua - per-directory sessions (persistence.nvim)
--
-- Sessions are saved silently and are NOT restored automatically when
-- nvim starts; a plain `nvim` still opens an empty buffer. Restore with
-- <leader>qs, or `nvim +SessionRestore`, which is what tmux-resurrect runs
-- when it brings a pane back (see @resurrect-processes in tmux.conf).

return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- start recording once a real file is opened
    init = function()
      -- Defined in init (not config) so it exists at startup, before the
      -- plugin is loaded, for `nvim +SessionRestore`.
      vim.api.nvim_create_user_command("SessionRestore", function()
        require("persistence").load()
      end, { desc = "Restore the session for the current directory" })

      -- persistence saves on VimLeavePre, which never runs when WSL shuts
      -- down or the tmux server is killed. Save on buffer switches and focus
      -- loss too, so the last session on disk is never more than a step old.
      -- Runs persistence's own VimLeavePre hook rather than save(), so its
      -- filter applies (no save with only scratch/gitcommit buffers), and
      -- never while a session file is still being sourced (g:SessionLoad).
      vim.api.nvim_create_autocmd({ "BufEnter", "FocusLost" }, {
        group = vim.api.nvim_create_augroup("fc_session_autosave", { clear = true }),
        callback = function()
          if vim.g.SessionLoad then
            return
          end
          local p = package.loaded["persistence"]
          if p and p.active() then
            vim.api.nvim_exec_autocmds("VimLeavePre", { group = "persistence" })
          end
        end,
      })
    end,
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session (this dir)" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save this session" },
    },
  },
}
