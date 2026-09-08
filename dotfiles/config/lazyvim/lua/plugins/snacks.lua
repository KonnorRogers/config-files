return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = false },
    dashboard = { enabled = false }, -- no start screen (plain vim has none)
    indent = { enabled = false }, -- no indent guides
    explorer = { enabled = false },
    picker = {
      layout = { preset = "telescope" },
    },
    words = { 
      enabled = false 
    } 
    -- Notifications still come from snacks, not noice. Uncomment to silence
    -- those top-right popups too and rely on the native cmdline / :messages:
    -- notifier = { enabled = false },
  },
}
