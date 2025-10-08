vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Format
vim.opt.textwidth = 80
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.autochdir = true
vim.opt.scrolloff = 5

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'no'
vim.opt.showmode = false

vim.opt.termguicolors = true
vim.syntax = true
vim.g.c_syntax_for_h = true -- This is blasphemy

vim.opt.mouse = 'a'
-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Preview replacements live
vim.opt.inccommand = 'split'

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '· ', trail = ' ', nbsp = '␣' }

-- Add search directories to path
vim.opt.path:append('/usr/local/include')
vim.opt.path:append('/usr/lib/gcc/x86_64-pc-linux-gnu/*/include')
vim.opt.path:append(vim.fn.system 'odin root')

--[[ Keymaps ]]
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--[[ Commands/Autocommands ]]

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- remove auto comment inserts
vim.api.nvim_create_autocmd('BufWinEnter', {
  command = 'set formatoptions-=ro | set formatoptions+=t',
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.wistl' },
  command = 'setfiletype wistl',
})

require 'plugins'
