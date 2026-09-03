vim.api.nvim_create_user_command("Indent", function(args)
  local width = tonumber(args.args)

  if not width or width <= 0 or width % 1 ~= 0 then
    error("Indent width must be a positive integer")
  end

  vim.bo.expandtab = true
  vim.bo.shiftwidth = width
  vim.bo.tabstop = width
  vim.bo.softtabstop = width

  vim.notify(string.format("Indent width set to %d spaces", width), vim.log.levels.INFO)
end, {
  nargs = 1,
  desc = "Set indentation width for the current buffer",
})
