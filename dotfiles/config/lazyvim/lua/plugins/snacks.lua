return {
  "snacks.nvim",
  opts = {
    scroll = { enabled = false },
    dashboard = { enabled = false }, -- no start screen (plain vim has none)
    indent = { enabled = false }, -- no indent guides
    -- Notifications still come from snacks, not noice. Uncomment to silence
    -- those top-right popups too and rely on the native cmdline / :messages:
    -- notifier = { enabled = false },
  },
}
