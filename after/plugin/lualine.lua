require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = {}, winbar = {} },
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = { statusline = 100, tabline = 100, winbar = 100 },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str) return ' ' .. str end, -- Adds Vim icon
      }
    },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      {
        'filename',
        path = 1, -- Show relative path
        symbols = { modified = ' ●', readonly = ' ', unnamed = '[No Name]' },
      },
      'filesize', -- Show file size
    },
    lualine_x = {
      { 'encoding' },
      {
        'fileformat',
        icons_enabled = true,
        symbols = { unix = '', dos = '', mac = '' }
      },
      { 'filetype' },
    },

    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
