
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
-- remove autocomment
vim.api.nvim_create_autocmd('BufWinEnter', {
  command = 'set formatoptions-=cro | set formatoptions+=t',
})
-- custom filetype
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.asm' ,'*.inc' },
  callback = function()
    vim.opt.filetype = 'nasm'
  end,
})
vim.api.nvim_create_autocmd({'BufReadPost', 'BufNewFile'}, {
  pattern = { '*.wistl' },
  command = 'setfiletype wistl',
})

-- nicer :terminal
vim.api.nvim_create_user_command("T", function(opts)
  if opts.args == "" then return end
  vim.cmd("belowright split")
  vim.cmd("terminal " .. opts.args)
end, { 
  nargs = "*",
  complete = function(arg_lead, cmd_line, cursor_pos)
      -- Use shell command completion from :term
      return vim.fn.getcompletion(arg_lead, 'shellcmd')
    end
})
