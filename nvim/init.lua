vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Format
vim.opt.textwidth = 100
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.autochdir = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'no'
vim.opt.showmode = false -- Tis in statusbar

vim.opt.termguicolors = true
vim.syntax = true
vim.g.c_syntax_for_h = true -- This is blasphemy

vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

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

--[[ Search Path ]]
vim.opt.path:append('/usr/include')
vim.opt.path:append('/usr/local/include')
vim.opt.path:append('/usr/lib/gcc/x86_64-unknown-linux-gnu/*/include')
vim.opt.path:append(vim.fn.system 'odin root' .. '**')

--[[ Keymaps ]]
vim.keymap.set('i', '<C-f>', '<C-x><C-f>')
vim.keymap.set('n', '<leader>o', '<cmd>edit .<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--[[ Commands/Autocommands ]]
--
-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.wistl' },
  command = 'setfiletype wistl',
})
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.um' },
  command = 'setfiletype umka',
})
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.asm' },
  command = 'setfiletype nasm',
})

require 'plugins'
