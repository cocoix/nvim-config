return {
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "Aejkatappaja/cendre",
    lazy = false,
    priority = 1000,
    opts = {
      background = "medium", -- "hard" | "medium" | "soft"
      italic_virtual_text = false,
      italic_comments = false;
    }
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_bold = false
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_disable_italic_comment = false
    end
  },
}
