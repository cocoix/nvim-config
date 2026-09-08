-- https://main.cmp.saghen.dev/
local signature_width = 30

local function truncate_display(text, width)
  if vim.fn.strdisplaywidth(text) <= width then
    return text
  end

  local characters = vim.fn.strchars(text)
  repeat
    characters = characters - 1
    text = vim.fn.strcharpart(text, 0, characters)
  until characters == 0 or vim.fn.strdisplaywidth(text) <= width - 1
  return text .. "…"
end

local function selected_signature(ctx)
  if ctx.idx ~= require("blink.cmp").get_selected_item_idx() then
    return ""
  end

  local kind = ctx.item.kind
  local kinds = vim.lsp.protocol.CompletionItemKind
  if kind ~= kinds.Function and kind ~= kinds.Method then
    return ""
  end

  -- labelDetails.detail is the protocol field intended to supplement the label.
  -- Some servers instead put the complete declaration in CompletionItem.detail.
  local candidates = {
    ctx.label_detail,
    ctx.item.detail,
    ctx.label_description,
  }

  for _, candidate in ipairs(candidates) do
    if type(candidate) == "string" then
      candidate = vim.trim(candidate:gsub("[\r\n]+", " "))
      if candidate:sub(1, 1) == "(" and candidate:sub(-1) == ")" then
        return candidate
      end

      -- Only strip a declaration prefix when the server repeats the exact label
      -- immediately before a parenthesized parameter list.
      local label_start, label_end = candidate:find(ctx.item.label, 1, true)
      if label_start then
        local suffix = vim.trim(candidate:sub(label_end + 1))
        if suffix:sub(1, 1) == "(" and suffix:sub(-1) == ")" then
          return suffix
        end
      end
    end
  end

  return ""
end

return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.lib",
      -- optional: provides snippets for the snippet source
      "rafamadriz/friendly-snippets",
    },
    build = function()
      -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
      -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
      require("blink.cmp").build():pwait()
    end,

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      -- "default" (recommended) for mappings similar to built-in completions (C-y to accept)
      -- "super-tab" for mappings similar to vscode (tab to accept)
      -- "enter" for enter to accept
      -- "none" for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "super-tab",
        ["<C-e>"] = { "hide", "fallback" },
      },

      -- Match insert mode's super-tab behavior in Ex commands. If automatic
      -- completion was suppressed (for example, after retyping the same text),
      -- Tab explicitly triggers it instead of falling back to a literal ^I.
      cmdline = {
        enabled = true,
        keymap = {
          preset = "super-tab",
          ["<Tab>"] = { "select_and_accept", "show" },
          ["<C-e>"] = { "hide", "fallback" },
        },
        completion = {
          menu = {
            auto_show = true,
          },
        },
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = { auto_show = true },
        menu = {
          auto_show = true,
          border = "rounded",
          min_width = 52,
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "selected_signature", gap = 1 },
            },
            components = {
              label = {
                width = { fixed = 38 },
                text = function(ctx)
                  return ctx.label
                end,
                highlight = function(ctx)
                  local highlights = {
                    { 0, #ctx.label, group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel" },
                  }
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  return highlights
                end,
              },
              selected_signature = {
                width = { fixed = signature_width },
                text = function(ctx)
                  local signature = selected_signature(ctx)
                  if signature == "" then
                    return ""
                  end

                  signature = truncate_display(signature, signature_width)
                  local padding = math.max(signature_width - vim.fn.strdisplaywidth(signature), 0)
                  return string.rep(" ", padding) .. signature
                end,
                highlight = "BlinkCmpSelectedSignature",
              },
            },
          },
        },
        trigger = {
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
        },
      },

      -- (Default) list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = { default = { "lsp", "path", "snippets", "buffer" } },

      -- Prefer the Rust matcher when it is available, but do not fail startup if
      -- the native library has not been built yet.
      fuzzy = { implementation = "rust" }
    },
    config = function(_, opts)
      local function set_signature_highlight()
        vim.api.nvim_set_hl(0, "BlinkCmpSelectedSignature", { link = "Comment", default = true })
      end
      set_signature_highlight()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("BlinkCmpSelectedSignatureHighlight", { clear = true }),
        callback = set_signature_highlight,
      })
      require("blink.cmp").setup(opts)

      -- This blink.cmp revision does not redraw component text when only the
      -- selected index changes. Redraw so selected_signature follows the row.
      local menu = require("blink.cmp.completion.windows.menu")
      if not menu._selected_signature_redraw then
        local set_selected_item_idx = menu.set_selected_item_idx
        menu.set_selected_item_idx = function(idx)
          set_selected_item_idx(idx)
          if menu.renderer and menu.context and menu.win:is_open() then
            menu.renderer:draw(menu.context, menu.win:get_buf(), menu.items)
            menu.win:set_cursor({ idx or 1, 0 })
          end
        end
        menu._selected_signature_redraw = true
      end
    end,
  }
}
