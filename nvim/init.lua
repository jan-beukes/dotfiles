-- Options

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.cmptoggle = true
vim.diagnostic.enable(false)

-- format
vim.opt.textwidth = 100
vim.opt.autochdir = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 5

--vim.opt.guicursor = ''
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'no'
vim.opt.termguicolors = true
vim.opt.showmode = false

vim.opt.mouse = 'a'
-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Preview substitutions live, as you type
vim.opt.inccommand = 'split'

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '· ', trail = ' ', nbsp = '␣' }

-- remove stupid autocomment
vim.api.nvim_create_autocmd('BufWinEnter', {
  command = 'set formatoptions-=cro | set formatoptions+=t',
})
-- fasm highlighting
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.asm,*.inc',
  callback = function()
    vim.opt.filetype = 'fasm'
  end,
})

require 'keymaps'
require 'plugins'
