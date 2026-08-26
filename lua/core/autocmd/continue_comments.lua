return function(group)
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Do not continue comments on new lines",
    callback = function()
      vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
  })
end
