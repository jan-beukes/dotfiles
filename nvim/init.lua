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

vim.opt.mouse = 'a'
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '· ', trail = ' ', nbsp = '␣' }
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- remove autocomment
-- vim.api.nvim_create_autocmd('BufWinEnter', {
--   command = 'set formatoptions-=cro | set formatoptions+=t',
-- })

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.asm,*.inc',
  callback = function()
    vim.opt.filetype = 'fasm'
  end,
})

require 'keymaps'
require 'plugins'
