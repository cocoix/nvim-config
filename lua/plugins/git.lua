return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "dlyongemallo/diffview-plus.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  }
}
