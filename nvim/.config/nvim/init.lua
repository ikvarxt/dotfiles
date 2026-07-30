-- Entry point. Only the bare essentials live here:
--   lua/config/options.lua   -- vim.opt settings
--   lua/config/keymaps.lua   -- global keymaps (plugin keymaps live with their spec)
--   lua/config/autocmds.lua  -- global autocommands
--   lua/config/lazy.lua      -- lazy.nvim bootstrap; imports every plugin spec
--   lua/custom/plugins/*.lua -- one file per plugin, auto-imported

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Read by several plugin specs to decide between Nerd Font and unicode icons.
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
