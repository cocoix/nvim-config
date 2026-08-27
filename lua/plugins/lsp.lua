return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local hostname = vim.uv.os_gethostname()

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

      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
        },
        filetypes = {
          "c",
          "cpp",
          "objc",
          "objcpp",
        },
        root_markers = {
          ".clangd",
          "compile_commands.json",
          "compile_flags.txt",
          ".git",
        },
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
      vim.lsp.enable("clangd")

      vim.lsp.config("nixd", {
        cmd = { "nixd" },
        filetypes = { "nix" },
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        root_markers = {
          "flake.nix",
          "default.nix",
          ".git",
        },
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            formatting = {
              command = { "nixfmt" },
            },
            options = {
              nixos = {
                expr = string.format(
                  '(builtins.getFlake (toString ./.)).nixosConfigurations.%q.options',
                  hostname
                ),
              },
            }
          }
        }
      })
      vim.lsp.enable("nixd")
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
  }
}
