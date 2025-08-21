return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    columns = {
      'permissions',
      'size',
      'mtime',
      'icon',
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['yp'] = {
        desc = 'Copy relative filepath to system clipboard',
        callback = function()
          local oil = require 'oil'
          local dir = oil.get_current_dir()
          local entry = oil.get_cursor_entry()
          if not dir or not entry then
            return
          end
          local s_cwd = vim.fn.getcwd():gsub('([%-%.%+%*%?%^%$%(%)%[%]%%])', '%%%1')
          local relative_dir = dir:gsub(s_cwd .. '/', '')
          vim.fn.setreg(vim.v.register, relative_dir .. entry.name)
        end,
      },
    },
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
