return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",

      -- <C-k>: snippet jump forward, else select previous item in the menu
      ["<C-k>"] = { "snippet_forward", "select_prev", "fallback" },
      -- <C-j>: snippet jump backward, else select next item in the menu
      ["<C-j>"] = { "snippet_backward", "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

      -- confirm without auto-selecting (your `select = false`)
      ["<C-y>"] = { "accept", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<C-e>"] = { "hide", "fallback" },
    },
    -- Match your `select = false` intent: don't preselect the first item,
    -- so <CR>/<C-y> only confirm something you explicitly selected.
    completion = {
      list = { selection = { preselect = false } },
    },
  },
}
