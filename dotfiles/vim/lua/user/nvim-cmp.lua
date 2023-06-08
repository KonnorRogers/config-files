-- Setup nvim-cmp.
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

vim.o.completeopt = "menuone,noselect,preview"

local kind_icons = {
  Text = "󰊄",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "󰚔",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  mapping = {
    ["<C-k>"] = cmp.mapping(function (fallback)
      if vim.fn['vsnip#jumpable'](1) == 1 then
          feedkey('<Plug>(vsnip-jump-next)', "")
      elseif cmp.visible() then
          cmp.select_prev_item()
      else
          fallback()
      end
    end, {"i", "s"}),
		["<C-j>"] = cmp.mapping(function (fallback)
      if vim.fn['vsnip#jumpable'](-1) == 1 then
          feedkey('<Plug>(vsnip-jump-prev)', '')
      elseif cmp.visible() then
          cmp.select_next_item()
      else
          fallback()
      end
    end, {"i", "s"}),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.mapping.confirm({ select = false }), -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        vsnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        cmdline = "[CMD]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "vsnip" },
    { name = "path" },
    { name = 'cmdline' },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },

    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
