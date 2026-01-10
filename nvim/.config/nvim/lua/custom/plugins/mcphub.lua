return {
  'ravitemer/mcphub.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
  config = function()
    require('mcphub').setup {
      -- Absolute path to MCP Servers config file (will create if not exists)
      config = vim.fn.expand '~/Library/Application\\ Support/Code/User/mcp.json',
      auto_approve = true,
      extensions = {
        avante = {
          -- make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
      },
    }
  end,
}
