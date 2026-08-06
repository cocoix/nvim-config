vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.cursorline = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = 'split'

vim.opt.scrolloff = 10

vim.opt.expandtab = true   -- Tab 转为空格
vim.opt.tabstop = 2        -- 一个 tab 显示为 4 个空格
vim.opt.shiftwidth = 2     -- 自动缩进使用 4 个空格
vim.opt.softtabstop = 2    -- 按 Tab 插入 4 个空格

require("core.autocmd")

vim.pack.add({{ src = "https://github.com/folke/lazy.nvim.git", version = "stable" }})

require("lazy").setup({
  spec = {
    { import = "plugins" }, -- 导入 plugins 目录下的插件 spec
  },
  install = { colorscheme = { "gruvbox-material" } }, -- 安装插件界面使用的配色方案
  checker = { enabled = true }, -- 自动检查更新
})

vim.cmd.colorscheme("cendre")
