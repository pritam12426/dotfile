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
