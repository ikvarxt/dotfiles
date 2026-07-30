-- Highlight, edit, and navigate code
--  See `:help nvim-treesitter-intro`
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  init = function()
    -- Telescope's previewer still expects a couple of legacy nvim-treesitter
    -- helpers that the `main` branch no longer ships. Register the shim during
    -- startup, well before any picker opens.
    if package.loaded['nvim-treesitter.configs'] == nil then
      package.preload['nvim-treesitter.configs'] = function()
        return {
          get_module = function(module)
            if module == 'highlight' then
              return { additional_vim_regex_highlighting = false }
            end
            return {}
          end,
          is_enabled = function(module, lang)
            return module == 'highlight' and lang ~= nil and pcall(vim.treesitter.language.add, lang)
          end,
        }
      end
    end
  end,
  config = function()
    local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
    require('nvim-treesitter').install(parsers)

    local ok, ts_parsers = pcall(require, 'nvim-treesitter.parsers')
    if ok then
      ts_parsers.ft_to_lang = ts_parsers.ft_to_lang or vim.treesitter.language.get_lang
      ts_parsers.get_parser = ts_parsers.get_parser or vim.treesitter.get_parser
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)

        if not language or not vim.treesitter.language.add(language) then
          return
        end

        vim.treesitter.start(buf, language)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
