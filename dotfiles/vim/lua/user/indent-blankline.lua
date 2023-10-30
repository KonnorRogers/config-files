local status, blankline = pcall(require, "ibl")

if not status then
  return
end

blankline.setup({
  scope = {
    enabled = true,
    show_start = false
  },
  indent = {
    char = "│"
  }
})

