--
--
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' ' -- Map leader to space
vim.g.maplocalleader = ' '

-- Common settings
vim.opt.showmode = true -- Show current mode
vim.opt.scrolloff = 5 -- Keep 5 lines visible around cursor
vim.opt.incsearch = true -- Incremental search
vim.opt.number = true -- Show line numbers
vim.opt.clipboard = 'unnamed,unnamedplus' -- Use system clipboard
vim.opt.wrap = true -- Wrap lines
vim.opt.textwidth = 140 -- Max line width
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Smart case for search
vim.opt.matchpairs:append { '<:>' } -- Add <> to matchpairs

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank { timeout = 200 }
  end,
})

-- batter to migrate to `if vim.g.vscode`
local vscode = require 'vscode'

local function keymap_vscode(mode, keys, command, args)
  vim.keymap.set(mode, keys, function()
    vscode.action(command, args)
  end, { silent = true, desc = 'VSCode: ' .. command })
end

-- -----------------------------------------------------------------------------
-- 4. PLUGINS (The modern Neovim equivalents of your IdeaVIM plugins)
-- -----------------------------------------------------------------------------
-- require("lazy").setup({
--   -- Surround -> nvim-surround (for ys, ds, cs)
--   {
--     "kylechui/nvim-surround",
--     version = "*",
--     event = "VeryLazy",
--     config = function() require("nvim-surround").setup() end,
--   },
--
--   -- Commentary -> Comment.nvim (for gc, gcc)
--   { "numToStr/Comment.nvim", opts = {} },
--
--   -- EasyMotion -> hop.nvim (faster and better!)
--   {
--     "phaazon/hop.nvim",
--     branch = "v2",
--     config = function() require("hop").setup() end,
--   },
--
--   -- NERDTree -> nvim-tree.lua (modern file explorer)
--   {
--     "nvim-tree/nvim-tree.lua",
--     dependencies = "nvim-tree/nvim-web-devicons",
--     config = function()
--       require("nvim-tree").setup({
--         view = { width = 40 },
--         renderer = { icons = { show = { file = true, folder = true, git = true } } },
--       })
--     end,
--   },
--
--   -- argtextobj & textobj-entire -> nvim-treesitter-textobjects
--   -- This is a far more powerful way to get text objects.
--   {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     config = function()
--       require("nvim-treesitter.configs").setup({
--         -- Ensure languages you use are installed
--         ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust", "go", "json" },
--         highlight = { enable = true },
--         indent = { enable = true },
--         textobjects = {
--           select = {
--             enable = true,
--             lookahead = true,
--             keymaps = {
--               -- Your `argtextobj` replacement
--               ["aa"] = "@parameter.outer",
--               ["ia"] = "@parameter.inner",
--               -- Your `textobj-entire` replacement
--               ["ae"] = "@entire.outer",
--               ["ie"] = "@entire.inner",
--               -- Other useful ones
--               ["af"] = "@function.outer",
--               ["if"] = "@function.inner",
--               ["ac"] = "@class.outer",
--               ["ic"] = "@class.inner",
--             },
--           },
--         },
--       })
--     end,
--   },
--
--   -- ReplaceWithRegister -> tpope/vim-ReplaceWithRegister
--   { "tpope/vim-repeat" }, -- a dependency
--   { "tpope/vim-ReplaceWithRegister" },
--
--   -- We don't need a plugin for Multiple Cursors. VS Code handles this.
--   -- We'll map a key to the VS Code command for it.
-- })

-- -----------------------------------------------------------------------------
-- 5. MAPPINGS (Translated from your .ideavimrc)
-- -----------------------------------------------------------------------------

-- Helper for Normal mode mappings
local function nmap(keys, command, args)
  keymap_vscode('n', keys, command, args)
end
-- Helper for Visual mode mappings
local function vmap(keys, command, args)
  keymap_vscode('v', keys, command, args)
end

--nmap("S-<Esc>", "workbench.action.focusActiveEditorGroup")

-- Code Actions
nmap('gd', 'editor.action.revealDefinition') -- GotoDeclaration
nmap('gr', 'editor.action.findReferences') -- GotoReference
nmap('gI', 'editor.action.goToImplementation') -- GotoImplementation
nmap('gD', 'editor.action.goToTypeDefinition') -- GotoTypeDeclaration
-- gS (GotoSuperMethod) does not have a standard VS Code equivalent. It depends on the language extension.

nmap('<leader>f', 'editor.action.formatDocument') -- ReformatCode
nmap('<leader>rn', 'editor.action.rename') -- RenameElement
nmap('<leader>q', 'editor.action.marker.nextInFiles') -- GotoNextError
nmap('<leader>cg', 'editor.action.quickFix') -- Generate (QuickFix often shows this)
nmap('<leader>oi', 'editor.action.organizeImports') -- OptimizeImports
-- <leader>gt (GotoTest) is extension-specific. Example for Go: 'go.test.goto'
nmap('<leader>cr', 'editor.action.refactor') -- Refactorings.QuickListPopupAction

nmap('<leader>ta', 'editor.action.quickFix') -- ShowIntentionActions
nmap('<leader>ds', 'workbench.action.gotoSymbol') -- FileStructurePopup
nmap('<leader>s.', 'workbench.action.openRecent') -- RecentFiles
nmap('<leader>sf', 'workbench.action.quickOpen') -- GotoFile
nmap('<leader>sg', 'search.action.openNewEditor') -- global search
nmap('<leader>td', 'editor.action.peekTypeDefinition') -- QuickTypeDefinition
nmap('<leader>ti', 'editor.action.showHover') -- ExpressionTypeInfo
nmap('<leader>th', 'editor.action.showHover') -- ShowHoverInfo
nmap('<leader>tu', 'editor.action.peekReferences') -- ShowUsages
-- vim.keymap.set("n", "<leader>t.", "za", { desc = "Fold/Toggle" }) -- CollapseRegion
nmap('<leader>t.', 'editor.fold')

-- IDE & Plugin Mappings
-- Easymotion -> Hop
vim.keymap.set('n', '<leader>e', '<cmd>HopChar1<cr>', { silent = true, desc = 'Hop Char' })

nmap('-', 'workbench.files.action.showActiveFileInExplorer') -- SelectInProjectView
vim.keymap.set('n', '<leader>-', '<cmd>NvimTreeToggle<cr>', { silent = true, desc = 'Toggle NvimTree' })

nmap('<leader>an', 'workbench.action.debug.run') -- Run
nmap('<leader>ac', 'workbench.action.debug.stop') -- Stop
nmap('<leader>z', 'workbench.action.toggleZenMode') -- HideAllWindows (Zen Mode is the closest)
nmap('<leader>db', 'editor.action.toggleBreakpoint') -- ToggleLineBreakpoint
-- <leader>da (AndroidConnect) is very specific. You'd need an Android extension and its command ID.
nmap('<leader>cff', 'actions.find') -- Find
nmap('<leader>cfr', 'editor.action.startFindReplaceAction') -- Replace
nmap('<leader>re', 'workbench.action.files.rename') -- RenameFile
nmap('<leader>tw', 'workbench.action.openView')

-- VCS Mappings (assuming you use Git)
nmap('<leader>gg', 'workbench.view.scm') -- Vcs.QuickListPopupAction (Open Source Control)
nmap('<leader>gc', 'git.commit') -- CheckinProject
nmap('<leader>gu', 'git.pull') -- Vcs.UpdateProject
nmap('<leader>gp', 'git.push') -- Vcs.Push
nmap('<leader>gh', 'git.viewFileHistory') -- Vcs.ShowTabbedFileHistory
nmap('<leader>gbc', 'git.checkout') -- GitCheckoutFromInputAction
nmap('<leader>gbn', 'git.branch') -- GitNewBranchAction
vmap('<leader>gd', 'git.revertSelectedRanges') -- Vcs.RollbackChangedLines

-- Config File Mappings
vim.keymap.set('n', '<leader>ve', '<cmd>edit ~/.config/nvim/init.lua<cr>', { desc = 'Edit Neovim Config' })
-- To "reload" the config in VS Code, you run a command from the command palette.
nmap('<leader>vs', 'workbench.action.developer.reloadWindow') -- Reload VS Code Window to apply all changes
