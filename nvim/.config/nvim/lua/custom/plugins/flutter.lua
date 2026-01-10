return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    require('flutter-tools').setup {
      widget_guides = {
        enabled = true,
      },
      lsp = {
        settings = {
          analysisExcludedFolders = {
            vim.fn.expand '$HOME/.pub-cache',
          },
        },
      },
    }
    require('telescope').load_extension 'flutter'
  end,
}
