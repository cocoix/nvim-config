return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      vim.lsp.config("lua_ls", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              -- Load Neovim's generated Lua type definitions (vim.api,
              -- vim.fn, vim.opt, ...), not each runtime `lua` directory as
              -- an unrelated workspace library.
              library = { vim.env.VIMRUNTIME },
            },
          },
        },
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
      },
    },
  }
}
