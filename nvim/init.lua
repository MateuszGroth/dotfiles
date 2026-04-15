-- =====================
-- Leader keys
-- =====================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.vim_markdown_folding_disabled = 1

-- =====================
-- Bootstrap lazy.nvim
-- =====================
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =====================
-- Plugins
-- =====================
require('lazy').setup({

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-eunuch',

  -- QoL
  'tpope/vim-sleuth',
  { 'numToStr/Comment.nvim', opts = {} },
  { 'folke/which-key.nvim', opts = {} },

  -- Theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'catppuccin',
        icons_enabled = false,
      },
    },
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '┊' },
    },
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },

  -- Formatting
  {
    'nvimtools/none-ls.nvim',
  },

})

-- =====================
-- Options
-- =====================
vim.o.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

-- =====================
-- Keymaps
-- =====================
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<C-h>', ':bprevious<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { silent = true })

-- Telescope
local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tb.find_files)
vim.keymap.set('n', '<leader>fg', tb.live_grep)
vim.keymap.set('n', '<leader>fb', tb.buffers)
vim.keymap.set('n', '<leader>fh', tb.help_tags)

-- =====================
-- Treesitter
-- =====================
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'lua', 'vim', 'vimdoc', 'bash', 'json', 'markdown',
    'typescript', 'tsx', 'javascript', 'python', 'go', 'rust',
  },
  highlight = { enable = true },
  indent = { enable = true },
})

-- =====================
-- LSP
-- =====================
require('neodev').setup()

local lspconfig = require('lspconfig')
local mason_lsp = require('mason-lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  ts_ls = {},
  eslint = {},
  pyright = {},
}

mason_lsp.setup({
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server)
      local server_opts = {
        capabilities = capabilities,
      }

      if servers[server] then
        server_opts = vim.tbl_deep_extend('force', server_opts, servers[server])
      end

      lspconfig[server].setup(server_opts)
    end,
  },
})

-- =====================
-- null-ls (format on save)
-- =====================
local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormat', {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
