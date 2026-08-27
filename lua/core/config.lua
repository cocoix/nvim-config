vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
vim.opt.cursorline = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split"

vim.opt.scrolloff = 5

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.autoindent = true
-- `smartindent` treats a leading `#` as a C preprocessor directive and
-- forces it to column 0, which breaks indented comments in Python, shell,
-- YAML, and other filetypes that use `#` for comments.
vim.opt.smartindent = false

vim.opt.signcolumn = "yes"
