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
          local info = vim.b.coc_diagnostic_info
          if not info then return "" end

          local now = vim.uv.now()
          if not vim.g._coc_diag_time or now - vim.g._coc_diag_time > 2000 then
            vim.g._coc_diag_time = now
            local ok, list = pcall(vim.fn.CocAction, 'diagnosticList')
            if ok and type(list) == 'table' then
              local groups = {}
              local current_file = vim.api.nvim_buf_get_name(0)
              for _, d in ipairs(list) do
                if d.file == current_file then
                  local sev = d.severity:lower()
                  groups[sev] = groups[sev] or { count = 0, first = nil }
                  groups[sev].count = groups[sev].count + 1
                  if not groups[sev].first then
                    groups[sev].first = d.lnum
                  end
                end
              end
              vim.g._coc_diag_cache = groups
            end
          end

          local cache = vim.g._coc_diag_cache
          local icons = { error = " ", warning = " ", information = " ", hint = " " }
          local hl = { error = "DiagnosticError", warning = "DiagnosticWarn", information = "DiagnosticInfo", hint = "DiagnosticHint" }
          local order = { 'error', 'warning', 'information', 'hint' }
          local parts = {}
          for _, sev in ipairs(order) do
            local count = info[sev]
            if count and count > 0 then
              local line = cache and cache[sev] and cache[sev].first
              if line then
                table.insert(parts, string.format("%%#%s#%s%d:L%d%%*", hl[sev], icons[sev], count, line))
              else
                table.insert(parts, string.format("%%#%s#%s%d%%*", hl[sev], icons[sev], count))
              end
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
