require("plugins")

local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tab and indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true

-- line warping
opt.wrap = false

-- serarch stting
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
-- opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- nice to have
-- keymap.set("n", "<leader>w", ":w<CR>")
-- keymap.set("n", "<leader>q", ":q!<CR>")
-- keymap.set("n", "<leader>x", ":x<CR>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

