require("rafe")

-- Add all you default function here
print("Welcome")

local function set_background_based_on_os()
  local handle = io.popen("~/dev/scripts/detect_appearance.sh")
  if handle == nil then
    return
  end

  local result = handle:read("*a")
  handle:close()

  if result:match("true") then
    print("IS Dark Mode")
    vim.cmd("set background=dark")
  else
    print("IS Light Mode")
    vim.cmd("set background=light")
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = set_background_based_on_os,
})
