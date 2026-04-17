--[[ Options ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.textwidth = 100
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true

vim.opt.autochdir = true
vim.opt.scrolloff = 3
vim.opt.number = true
vim.opt.relativenumber = true

vim.syntax = true
vim.opt.signcolumn = 'no'
vim.opt.termguicolors = true
vim.g.c_syntax_for_h = true -- This is blasphemy

vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '· ', trail = ' ', nbsp = '~' }

--[[ Search Path ]]
vim.opt.path:append('/usr/include')
vim.opt.path:append('/usr/local/include')
vim.opt.path:append('/usr/lib/gcc/x86_64-unknown-linux-gnu/*/include')
vim.opt.path:append(vim.fn.system 'odin root' .. '**')

--[[ Keymaps ]]
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', '<C-f>', '<C-x><C-f>') -- File completion
vim.keymap.set('n', '<leader>o', ':edit .<CR>',{ desc = 'Open directory' })
vim.keymap.set('n', '<Leader>yd', ':let @+ = expand(\'%:p:h\')<CR>',
  { silent = true, desc = 'Yank directory path' })
vim.keymap.set('n', '<Leader>yf', ':let @+ = expand(\'%:p\')<CR>',
  { silent = true, desc = 'Yank file path' })

--[[ Commands/Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- remove auto comment inserts
vim.api.nvim_create_autocmd('BufWinEnter', {
  command = 'set formatoptions-=ro | set formatoptions+=t',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'asm' },
  command = 'setfiletype nasm',
})

-- Create new split for terminal commands
vim.api.nvim_create_user_command('T', function(opts)
  vim.cmd('horizontal terminal ' .. opts.args)
end, {
    nargs = '*',
    complete = 'shellcmd'
})

require 'plugins'
