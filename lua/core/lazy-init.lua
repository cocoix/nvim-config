vim.pack.add({
  {
    src = "https://github.com/folke/lazy.nvim.git",
    version = "stable",
  },
})

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "cendre" } },
  checker = { enabled = true, notify = false },
})
