local autocmd_group = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

require("core.autocmd.detect_indent")(autocmd_group)
require("core.autocmd.trim_whitespace")(autocmd_group)
