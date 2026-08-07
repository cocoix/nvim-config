local function detect_indent_width(bufnr)
  if vim.bo[bufnr].buftype ~= "" or not vim.bo[bufnr].modifiable then
    return
  end

  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, math.min(line_count, 1000), false)
  local widths = {}
  local previous_indent

  for _, line in ipairs(lines) do
    if line:find("\t") == 1 then
      previous_indent = nil
    elseif line:find("%S") then
      local indent = #(line:match("^ *") or "")

      if previous_indent and indent > previous_indent then
        local width = indent - previous_indent
        if width >= 2 and width <= 8 then
          widths[width] = (widths[width] or 0) + 1
        end
      end

      previous_indent = indent
    end
  end

  local detected
  local best_count = 0
  for width = 2, 8 do
    local count = widths[width] or 0
    if count > best_count then
      detected = width
      best_count = count
    end
  end

  if detected then
    vim.bo[bufnr].shiftwidth = detected
    vim.bo[bufnr].tabstop = detected
    vim.bo[bufnr].softtabstop = detected
  end
end

return function(group)
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    desc = "Detect indentation width for the current buffer",
    callback = function(args)
      detect_indent_width(args.buf)
    end,
  })
end
