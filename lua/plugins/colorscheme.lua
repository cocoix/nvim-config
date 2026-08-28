return {
  {
    "nvim-mini/mini.base16",
    lazy = false,
    priority = 1000,
    opts = {
      palette = {
        base00 = "#202020",
        base01 = "#292929",
        base02 = "#373634",
        base03 = "#686661",
        base04 = "#A09D95",
        base05 = "#D8D4C8",
        base06 = "#E9E4D7",
        base07 = "#F7F1E3",
        base08 = "#EFA3A9",
        base09 = "#EFB68A",
        base0A = "#F2D98B",
        base0B = "#ADD39B",
        base0C = "#99D5CE",
        base0D = "#9FC7EA",
        base0E = "#C5AFE2",
        base0F = "#C58F78",
      },
    },
  },
  {
    "dgox16/oldworld.nvim",
    lazy = true,
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
