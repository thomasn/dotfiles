-- keymaps.lua - Key bindings

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better navigation for wrapped lines
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Better paste (don't yank replaced text)
keymap("v", "p", '"_dP')

-- Window management
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffer management
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Clear search highlight
keymap("n", "<Esc>", "<cmd>nohlsearch<cr>", opts)

-- Save file
keymap("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Quit
keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Better join
keymap("n", "J", "mzJ`z", opts)

-- Keep centered when searching
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Quickfix list
keymap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix list" })
keymap("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
keymap("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })

-- Location list
keymap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location list" })
keymap("n", "[l", "<cmd>lprev<cr>", { desc = "Previous location" })
keymap("n", "]l", "<cmd>lnext<cr>", { desc = "Next location" })

-- Diagnostic keymaps ([d / ]d and <C-w>d are Neovim built-ins;
-- <leader>e is the Oil file explorer, see navigation.lua)
keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
keymap("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Terminal mode escape
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Increment/decrement
keymap("n", "+", "<C-a>", { desc = "Increment number" })
keymap("n", "-", "<C-x>", { desc = "Decrement number" })

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- New line without insert mode
keymap("n", "<leader>o", "o<Esc>", { desc = "New line below" })
keymap("n", "<leader>O", "O<Esc>", { desc = "New line above" })
