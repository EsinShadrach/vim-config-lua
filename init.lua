require("rafe")

-- Add all your default functions here
print("Welcome")

local function set_background_based_on_os()
  local handle = io.popen("~/dev/scripts/detect_appearance.sh")

  if handle == nil then
    print("Handle is NULL")
    return
  end

  local result = handle:read("*a")
  handle:close()

  if result:match("true") then
    print("Dark Mode detected")
    vim.cmd("set background=dark")
  else
    print("Light Mode detected")
    vim.cmd("set background=light")
  end
end

-- Ensure this runs after all configurations, especially indent-blankline
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.defer_fn(function()
      set_background_based_on_os()
    end, 0) -- Delay execution by 1ms to ensure all configs are loaded
  end,
})
