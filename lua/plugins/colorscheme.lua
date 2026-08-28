return {
  {
    "nvim-mini/mini.base16",
    lazy = false,
    priority = 1000,
    opts = {
      palette = {
        base00 = "#202020",
        base01 = "#292929",
        base02 = "#343434",
        base03 = "#626262",
        base04 = "#969696",
        base05 = "#D0D0CB",
        base06 = "#E2E2DC",
        base07 = "#F2F1E9",
        base08 = "#E98B91",
        base09 = "#EBAA78",
        base0A = "#F0D986",
        base0B = "#A8D18D",
        base0C = "#88CFCA",
        base0D = "#86B9E8",
        base0E = "#B6A4DB",
        base0F = "#D2A07F",
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
