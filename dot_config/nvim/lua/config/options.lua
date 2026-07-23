-- options.lua - Neovim settings

local opt = vim.opt

-- Mouse
opt.mouse = "a"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true

-- Wrapping
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Colors
opt.termguicolors = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300
opt.lazyredraw = false

-- Folds
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldlevel = 99

-- Grep
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case --hidden"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Backups
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Command line
opt.cmdheight = 1
opt.showmode = false

-- Misc
opt.confirm = true
opt.conceallevel = 0
opt.fileencoding = "utf-8"
opt.spell = false
opt.spelllang = "en_us"
opt.virtualedit = "block"
opt.inccommand = "split"
opt.iskeyword:append("-")

-- Format options
opt.formatoptions = "jcroqlnt"

-- Short messages
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Fillchars
opt.fillchars = {
  foldopen = "▾",
  foldclose = "▸",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- List chars (show whitespace)
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Persistent undo directory
local undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir
