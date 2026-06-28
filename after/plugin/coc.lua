-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation (using Snacks Picker)
local function coc_jump_snacks(action_name, title, extra_args)
  local cb = function(err, res)
    if err ~= vim.NIL and err ~= nil then
      vim.notify("Error getting " .. title, vim.log.levels.ERROR)
      return
    end
    if type(res) ~= 'table' or vim.tbl_isempty(res) then
      vim.notify("No " .. title .. " found", vim.log.levels.WARN)
      return
    end

    if #res == 1 then
      local l = res[1]
      local uri = l.targetUri or l.uri
      local range = l.targetRange or l.range
      local filename = vim.uri_to_fname(uri)
      vim.cmd("edit " .. vim.fn.fnameescape(filename))
      vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
      vim.cmd("normal! zz")
      return
    end

    local items = {}
    for _, l in ipairs(res) do
      local uri = l.targetUri or l.uri
      local range = l.targetRange or l.range
      local filename = vim.uri_to_fname(uri)
      
      local bufnr = vim.uri_to_bufnr(uri)
      local is_loaded = vim.api.nvim_buf_is_loaded(bufnr)
      local line_text = ''
      if is_loaded then
        local lines = vim.api.nvim_buf_get_lines(bufnr, range.start.line, range.start.line + 1, false)
        line_text = lines[1] or ''
      else
        if vim.fn.filereadable(filename) == 1 then
          local content = vim.fn.readfile(filename, '', range.start.line + 1)
          line_text = content[range.start.line + 1] or ''
        end
      end

      table.insert(items, {
        file = filename,
        pos = { range.start.line + 1, range.start.character + 1 },
        text = vim.fn.fnamemodify(filename, ":t") .. " " .. vim.trim(line_text),
        line = vim.trim(line_text),
      })
    end

    require("snacks").picker.pick({
      title = title,
      items = items,
      format = "file",
    })
  end

  if extra_args ~= nil then
    vim.fn.CocActionAsync(action_name, extra_args, cb)
  else
    vim.fn.CocActionAsync(action_name, cb)
  end
end

keyset("n", "gd", function() coc_jump_snacks('definitions', 'CoC Definitions') end, { silent = true, desc = "Goto Definition" })
keyset("n", "gy", function() coc_jump_snacks('typeDefinitions', 'CoC Type Definitions') end, { silent = true, desc = "Goto Type Definition" })
keyset("n", "gi", function() coc_jump_snacks('implementations', 'CoC Implementations') end, { silent = true, desc = "Goto Implementation" })
keyset("n", "gr", function() coc_jump_snacks('references', 'CoC References', false) end, { silent = true, desc = "Goto References" })


-- Use K to show documentation in preview window
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
  group = "CocGroup",
  command = "silent call CocActionAsync('highlight')",
  desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
  group = "CocGroup",
  pattern = "typescript,json",
  command = "setl formatexpr=CocAction('formatSelected')",
  desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
  group = "CocGroup",
  pattern = "CocJumpPlaceholder",
  command = "call CocActionAsync('showSignatureHelp')",
  desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = { silent = true, nowait = true }
keyset("x", "<leader>s", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>s", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>wc", "<Plug>(coc-codeaction-cursor)", { noremap = true, silent = true })
-- keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", { noremap = true, silent = true })
-- keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- -- Remap keys for apply source code actions for current file.
-- keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true, expr = true }
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
  'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
  'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
-- Show all diagnostics
keyset("n", "<leader>d", function()
  vim.fn.CocActionAsync('diagnosticList', function(err, res)
    if err ~= vim.NIL and err ~= nil then
      vim.notify("Error getting CoC diagnostics", vim.log.levels.ERROR)
      return
    end
    if type(res) ~= 'table' or vim.tbl_isempty(res) then
      vim.notify("No CoC diagnostics", vim.log.levels.WARN)
      return
    end

    local items = {}
    for _, d in ipairs(res) do
      local text = vim.trim(d.message:gsub('[\n]', ''))
      local severity = d.severity or "Unknown"
      table.insert(items, {
        file = d.file,
        pos = { d.lnum, d.col },
        text = vim.fn.fnamemodify(d.file, ":t") .. " " .. text,
        msg = text,
        severity = severity,
        source = d.source,
      })
    end

    require("snacks").picker.pick({
      title = "CoC Diagnostics",
      items = items,
      format = function(item, picker)
        local sev = item.severity
        if sev == "Information" then sev = "Info" end
        if sev == "Warning" then sev = "Warn" end
        local hl = "Diagnostic" .. sev
        return {
          { sev:sub(1,1), hl },
          { " " },
          { item.msg, "Normal" },
          { " " .. (item.source or ""), "Comment" },
        }
      end,
    })
  end)
end, { silent = true, nowait = true, desc = "CoC Diagnostics" })
keyset("n", "<space>a", "<leader>d", { remap = true, silent = true, desc = "CoC Diagnostics" })
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", function()
  vim.fn.CocActionAsync('commands', function(err, res)
    if err ~= vim.NIL and err ~= nil then
      vim.notify("Error getting CoC commands", vim.log.levels.ERROR)
      return
    end
    if type(res) ~= 'table' or vim.tbl_isempty(res) then
      vim.notify("No CoC commands available", vim.log.levels.WARN)
      return
    end

    local items = {}
    for _, cmd in ipairs(res) do
      table.insert(items, {
        text = cmd.id .. " " .. (cmd.title or ""),
        cmd_id = cmd.id,
        title = cmd.title or "",
      })
    end

    require("snacks").picker.pick({
      title = "CoC Commands",
      items = items,
      format = function(item, picker)
        return {
          { item.cmd_id, "Function" },
          { " " },
          { item.title, "Comment" }
        }
      end,
      confirm = function(picker, item)
        picker:close()
        if item and item.cmd_id then
          vim.fn.CocActionAsync('runCommand', item.cmd_id)
        end
      end,
    })
  end)
end, { silent = true, nowait = true, desc = "CoC Commands" })
-- Find symbol of current document
keyset("n", "<space>o", function()
  vim.fn.CocActionAsync('documentSymbols', vim.api.nvim_get_current_buf(), function(err, res)
    if err ~= vim.NIL and err ~= nil then
      vim.notify("Error getting CoC symbols", vim.log.levels.ERROR)
      return
    end
    if type(res) ~= 'table' or vim.tbl_isempty(res) then
      vim.notify("No CoC symbols found", vim.log.levels.WARN)
      return
    end

    local items = {}
    local filename = vim.api.nvim_buf_get_name(0)
    for _, s in ipairs(res) do
      table.insert(items, {
        file = filename,
        pos = { s.lnum, s.col },
        text = s.text,
        kind = s.kind,
        level = s.level or 0,
      })
    end

    require("snacks").picker.pick({
      title = "CoC Document Symbols",
      items = items,
      format = function(item, picker)
        local indent = string.rep("  ", item.level or 0)
        return {
          { indent .. "[" .. (item.kind or "Unknown") .. "] ", "Type" },
          { item.text, "Normal" },
        }
      end,
    })
  end)
end, { silent = true, nowait = true, desc = "CoC Outline" })
-- Search workspace symbols
keyset("n", "<space>s", function()
  vim.ui.input({ prompt = 'Workspace Symbol: ' }, function(query)
    if not query or query == '' then return end
    vim.fn.CocActionAsync('getWorkspaceSymbols', query, function(err, res)
      if err ~= vim.NIL and err ~= nil then
        vim.notify("Error getting CoC workspace symbols", vim.log.levels.ERROR)
        return
      end
      if type(res) ~= 'table' or vim.tbl_isempty(res) then
        vim.notify("No CoC workspace symbols found", vim.log.levels.WARN)
        return
      end

      local items = {}
      for _, s in ipairs(res) do
        local filename = vim.uri_to_fname(s.location.uri)
        table.insert(items, {
          file = filename,
          pos = { s.location.range.start.line + 1, s.location.range.start.character + 1 },
          text = vim.fn.fnamemodify(filename, ":t") .. " " .. s.name,
          name = s.name,
          kind = vim.lsp.protocol.SymbolKind[s.kind] or s.kind or 'Unknown',
        })
      end

      require("snacks").picker.pick({
        title = "CoC Workspace Symbols",
        items = items,
        format = function(item, picker)
          return {
            { "[" .. (item.kind or "Unknown") .. "] ", "Type" },
            { item.name, "Normal" },
          }
        end,
      })
    end)
  end)
end, { silent = true, nowait = true, desc = "CoC Workspace Symbols" })
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

--  Custom Coc Markings hahahaha
-- Define the key mapping for Shift + Space to trigger autocomplete
keyset("i", "<S-SPACE>", "coc#refresh()", { silent = true, expr = true })


-- require('nvim_lsp').rust_analyzer.setup({
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--   end
-- })

-- Additional configurations for CoC settings (coc-settings.json)
vim.cmd('autocmd FileType rust let b:coc_global_extensions = ["rust-analyzer"]')
