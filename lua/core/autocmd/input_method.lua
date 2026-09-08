return function(group)
  if vim.fn.executable("fcitx5-remote") ~= 1 then
    return
  end

  vim.api.nvim_create_autocmd("ModeChanged", {
    group = group,
    pattern = "*:n",
    desc = "Switch Fcitx 5 to the English input method in Normal mode",
    callback = function()
      vim.system({ "fcitx5-remote", "-c" })
    end,
  })
end
