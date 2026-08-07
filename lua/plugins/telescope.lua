return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },

  keys = {
    vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end,
      { desc = "Files" }),

    vim.keymap.set("n", "<leader>fg", function() require("telescope.builtin").live_grep() end,
      { desc = "Live Grep" }),

    vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers() end,
      { desc = "Buffers" }),

    vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags() end,
      { desc = "Help" }),
  }
}
