local colorscheme = os.getenv("COLORSCHEME") or "xcodelighthc"
-- local colorscheme = "xcodedarkhc"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
