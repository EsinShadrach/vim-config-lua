require('snacks').setup({
  bigfile = { enabled = true },
  indent = {
    enabled = true,
    char = "▏",
    only_scope = false,
    scope = {
      enabled = true,
    },
  },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  toggle = { enabled = true },
  words = { enabled = true },
  explorer = {
    replace_netrw = true,
  },
  picker = {
    ui_select = true,
    sources = {
      explorer = {
        hidden = true,
        auto_close = true,
      },
      grep = {
        hidden = true,
      },
    },
    formatters = {
      file = {
        truncate = 69,
      },
      selected = {
        show_always = true,
        unselected = false,
      },
    },
    win = {
      preview = {
        wo = {
          number = vim.o.number,
          relativenumber = vim.o.relativenumber,
          signcolumn = vim.o.signcolumn,
          wrap = true,
        },
      },
    },
  },
})

vim.keymap.set({ 'n', 'x' }, '<leader><leader>', function()
  Snacks.picker.smart { hidden = true }
end, { desc = 'Smart Find Files' })

vim.keymap.set('n', '<leader>n', function()
  Snacks.explorer.reveal()
end, { desc = 'Snacks Explorer' })

vim.keymap.set('n', '<leader>fb', function()
  Snacks.picker.buffers()
end, { desc = 'Buffers' })

vim.keymap.set('n', '<leader>fc', function()
  Snacks.picker.files { cwd = vim.fn.stdpath('config') .. '/..', hidden = true }
end, { desc = 'Find Config File' })

vim.keymap.set('n', '<leader>ff', function()
  Snacks.picker.files()
end, { desc = 'Find Files' })

vim.keymap.set('n', '<leader>fg', function()
  Snacks.picker.git_files()
end, { desc = 'Find Git Files' })

vim.keymap.set('n', '<leader>fp', function()
  Snacks.picker.projects()
end, { desc = 'Projects' })

vim.keymap.set('n', '<leader>fr', function()
  Snacks.picker.recent()
end, { desc = 'Recent' })

vim.keymap.set('n', '<leader>fw', function()
  Snacks.picker.grep()
end, { desc = 'Grep Word' })

vim.keymap.set('n', '<leader>sb', function()
  Snacks.picker.lines()
end, { desc = 'Buffer Lines' })

vim.keymap.set({ 'n', 'x' }, '<leader>sw', function()
  Snacks.picker.grep_word()
end, { desc = 'Grep Word' })

vim.keymap.set('n', '<leader>sg', function()
  Snacks.picker.grep()
end, { desc = 'Grep' })

vim.keymap.set('n', '<leader>s/', function()
  Snacks.picker.search_history()
end, { desc = 'Search History' })

vim.keymap.set('n', '<leader>s"', function()
  Snacks.picker.registers()
end, { desc = 'Registers' })

vim.keymap.set('n', '<leader>sa', function()
  Snacks.picker.autocmds()
end, { desc = 'Autocmds' })

vim.keymap.set('n', '<leader>s:', function()
  Snacks.picker.command_history()
end, { desc = 'Command History' })

vim.keymap.set('n', '<leader>sc', function()
  Snacks.picker.commands()
end, { desc = 'Commands' })

vim.keymap.set('n', '<leader>sd', function()
  Snacks.picker.diagnostics()
end, { desc = 'Diagnostics' })

vim.keymap.set('n', '<leader>sh', function()
  Snacks.picker.help()
end, { desc = 'Help Pages' })

vim.keymap.set('n', '<leader>sH', function()
  Snacks.picker.highlights()
end, { desc = 'Highlights' })

vim.keymap.set('n', '<leader>sj', function()
  Snacks.picker.jumps()
end, { desc = 'Jumps' })

vim.keymap.set('n', '<leader>sk', function()
  Snacks.picker.keymaps()
end, { desc = 'Keymaps' })

vim.keymap.set('n', '<leader>sl', function()
  Snacks.picker.loclist()
end, { desc = 'Location List' })

vim.keymap.set('n', '<leader>sm', function()
  Snacks.picker.marks({
    filter = {
      transform = function(picker, filter)
        filter.opts.filter = function(item)
          return item.text:match('%a')
        end
        return true
      end,
    },
  })
end, { desc = 'Marks' })

vim.keymap.set('n', '<leader>sM', function()
  Snacks.picker.man()
end, { desc = 'Man Pages' })

vim.keymap.set('n', '<leader>sr', function()
  Snacks.picker.resume()
end, { desc = 'Resume' })

vim.keymap.set('n', '<leader>sq', function()
  Snacks.picker.qflist()
end, { desc = 'Quickfix List' })

vim.keymap.set('n', '<leader>sC', function()
  Snacks.picker.colorschemes()
end, { desc = 'Colorschemes' })

vim.keymap.set('n', '<leader>sp', function()
  Snacks.picker.projects()
end, { desc = 'Projects' })

vim.keymap.set('n', '<leader>sB', function()
  Snacks.picker.buffers()
end, { desc = 'Buffers' })
