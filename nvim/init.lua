-- Options

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.cmptoggle = true
vim.diagnostic.enable(false)

-- format
vim.opt.textwidth = 100
vim.opt.autochdir = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.signcolumn = 'no'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '· ', trail = ' ', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- remove stupid autocomment
vim.api.nvim_create_autocmd('BufWinEnter', {
  command = 'set formatoptions-=cro | set formatoptions+=t',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.asm,*.inc',
  callback = function()
    vim.opt.filetype = 'fasm'
  end,
})

-- Includes
require 'keymaps'
require 'plugins'
