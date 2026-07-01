return {
  'keaising/im-select.nvim',
  config = function()
    require('im_select').setup {
      -- IM used in normal mode (macOS: Programmer Dvorak layout).
      default_im_select = 'com.apple.keyboardlayout.Programmer Dvorak',
      default_command = 'macism',

      -- Switch to default IM on entering nvim and when leaving insert/cmdline.
      set_default_events = { 'VimEnter', 'InsertLeave', 'CmdlineLeave' },
      -- Restore the previously used IM when entering insert mode.
      set_previous_events = { 'InsertEnter' },

      keep_quiet_on_no_binary = false,
      async_switch_im = true,
    }
  end,
}
