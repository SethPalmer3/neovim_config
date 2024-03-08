---@diagnostic disable: unused-local
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- [[ Basic Keymaps ]]

require('keymaps')

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
-- require('lazy').setup('custom.one_liners')
if vim.g.vscode then
  require('lazy').setup({
    { 'numToStr/Comment.nvim',     opts = {} },

    -- { 'junegunn/vim-peekaboo', },
    { 'asvetliakov/vim-easymotion' },
  }, {});
else
  require('lazy').setup({
    { 'loctvl842/monokai-pro.nvim' },
    { import = 'custom' },
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equalent to setup({}) function
    },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup()
      end
    },
    {
      -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = '|',
          section_separators = '',
        },
      },
    },

    {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help ibl`
      main = 'ibl',
      opts = {},
    },

    require 'kickstart.plugins.autoformat',
    require 'kickstart.plugins.debug',

  }, {}
  )

  -- [[ Setting options ]]
  -- See `:help vim.o`
  -- NOTE: You can change these options as you wish!

  require('settings')


  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })

  -- [[ Configure Telescope ]]
  -- See `:help telescope` and `:help telescope.setup()`

  require('telescope_settings')

  -- [[ Configure Treesitter ]]
  -- See `:help nvim-treesitter`
  -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'

  require('treesitter_settings')

  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.

  require('lsp_settings')
  vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
      on_attach = function(client, bufnr)
        -- you can also put keymaps in here
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
        },
      },
    },
    -- DAP configuration
    dap = {
    },
  }


  -- [[ Configure nvim-cmp ]]
  -- See `:help cmp`

  require('cmp_settings')

  -- [[ Custom commands ]]

  vim.cmd [[command! Vterm execute 'vsplit | term']]
  vim.cmd [[command! Sterm execute 'split | term']]
  vim.cmd [[colorscheme catppuccin-frappe]]
end
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
