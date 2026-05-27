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
    lualine_b = {
      'branch', 'diff',
      {
        function()
          local ok, diag_list = pcall(vim.fn.CocAction, 'diagnosticList')
          if not ok or type(diag_list) ~= 'table' or #diag_list == 0 then return "" end
          local groups = {}
          for _, d in ipairs(diag_list) do
            groups[d.severity] = groups[d.severity] or { count = 0, first = nil }
            groups[d.severity].count = groups[d.severity].count + 1
            if not groups[d.severity].first then
              groups[d.severity].first = d.lnum
            end
          end
          local parts = {}
          local icons = { Error = " ", Warning = " ", Information = " ", Hint = " " }
          local hl = {
            Error = "DiagnosticError",
            Warning = "DiagnosticWarn",
            Information = "DiagnosticInfo",
            Hint =
            "DiagnosticHint"
          }
          for _, sev in ipairs({ 'Error', 'Warning', 'Information', 'Hint' }) do
            if groups[sev] then
              table.insert(parts,
                string.format("%%#%s#%s%d:L%d%%*", hl[sev], icons[sev], groups[sev].count, groups[sev].first))
            end
          end
          return table.concat(parts, " ")
        end,
      },
    },
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
