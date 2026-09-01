return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function ()
      local wk = require("which-key")

      wk.setup({
        preset = "helix"
      })

      wk.add({
        { "<leader>f", group = "Picker" },
        { "<leader>g", group = "Git" },
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
