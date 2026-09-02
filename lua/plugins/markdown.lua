return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons"
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = {
        lsp = { enabled = true }
      },
      preset = "obsidian", -- none | obsidian | lazy
      heading = {
        -- PUA glyphs are configured as double-width, so a trailing space
        -- would make sign_text three cells wide and Neovim would reject it.
        signs = { "󰫎" },
      },
    },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false, -- this will be removed in 4.0.0
      ui = { enable = false },
      workspaces = {
        {
          name = "Moss",
          path = "~/Notes/Moss",
        },
      },
    },
  }
}
