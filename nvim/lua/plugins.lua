-- Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Colorscheme
  {
    'ramojus/mellifluous.nvim',
    config = function()
      require("mellifluous").setup({
        transparent_background = { enabled = true, floating_windows = false },
        highlight_overrides = {
          dark = function(hl, colors)
            hl.set('TelescopePreviewNormal', { link = "Normal" })
          end,
        },
        color_overrides = {
          dark = {
            colors = function(colors)
              return {
                comments = colors.comments:lightened(8),
              }
            end,
          }
        },
      })

      vim.cmd.colorscheme 'mellifluous'
    end,
  },

  'bakpakin/janet.vim',

  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      -- Simple statusline.
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- MR OIL
  {
    'stevearc/oil.nvim',
    opts = {
      skip_confirm_for_simple_edits = true,
      cleanup_delay_ms = 5000,
      view_options = { show_hidden = true },
      keymaps = {
        ['<C-l>'] = false,
        ['<C-r>'] = 'actions.refresh',
        ['<C-;>'] = {
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
    }
  },

  -- Fuzzy find
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = { preview = { treesitter = { disable = { 'c' } } } }
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

      vim.keymap.set('n', '<leader>sb', function() builtin.grep_string({ grep_open_files = true }) end,
      { desc = '[S]earch word in Open [B]uffers' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep({ grep_open_files = true, prompt_title = 'Live Grep in Open Files'})
      end, { desc = '[S]earch [/] in Open Files' })

    end
  }
})
