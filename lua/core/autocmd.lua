local autocmd_group = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = autocmd_group,
  desc = "Remove trailing whitespace before saving",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! keepjumps keeppatterns %s/[ \t]\+$//e]])
    vim.fn.winrestview(view)
  end,
})
