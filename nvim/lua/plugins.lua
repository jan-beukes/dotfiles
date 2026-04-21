-- Theming
vim.pack.add({'https://github.com/ramojus/mellifluous.nvim'})
require('mellifluous').setup({
  transparent_background = { enabled = true , floating_windows = false },
  highlight_overrides = {
      dark = function(hl, colors)
        hl.set('TelescopePreviewNormal', { link = 'Normal' })
      end,
  },
})
vim.cmd.colorscheme 'mellifluous'

-- goober line
local statusline = { ' %t', '%r', '%m', '%=', '%{&filetype}', ' %2p%%', ' %3l:%-2c ' }
vim.o.statusline = table.concat(statusline, '')

--[[ Plugins ]]
vim.pack.add({
  'https://github.com/bakpakin/janet.vim',
  'https://github.com/tpope/vim-sleuth',

  'https://github.com/stevearc/oil.nvim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
})
vim.api.nvim_create_user_command('PackUpdate', function(_) vim.pack.update() end , {})
vim.api.nvim_create_user_command('PackDelete', function(a) vim.pack.del(a.fargs) end, { complete = 'packadd', nargs = '*' })

require('nvim-autopairs').setup {}

-- Oil
local show_detail = false
require('oil').setup({
  skip_confirm_for_simple_edits = true,
  cleanup_delay_ms = 5000,
  view_options = { show_hidden = true },
  keymaps = {
    ['<C-l>'] = false,
    ['<C-r>'] = 'actions.refresh',
    ['<C-i>'] = {
      desc = 'Toggle file information',
      callback = function()
        show_detail = not show_detail
        if show_detail then
          require('oil').set_columns({ 'icon', 'permissions', 'size', 'mtime' })
        else
          require('oil').set_columns({'icon'})
        end
      end
    }
  }
})

-- Telescope
require('telescope').setup({
  defaults = {
    preview = { 
      treesitter = { disable = { 'c' } }
    }
  },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>sb', function()
  builtin.grep_string({ grep_open_files = true })
end, { desc = '[S]earch word in Open [B]uffers' })
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  })
end, { desc = '[S]earch [/] in Open Files' })
