local colorscheme = os.getenv("COLORSCHEME") or "xcodelighthc"

return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "arzg/vim-colors-xcode" },
  { "rebelot/kanagawa.nvim" },
  { "spaceduck-theme/nvim" },
  { "catppuccin/nvim", name = "catppuccin" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
