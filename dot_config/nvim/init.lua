-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Editor settings
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.tabstop = 2            -- Number of spaces tabs count for
vim.opt.shiftwidth = 2         -- Size of an indent
vim.opt.smartindent = true     -- Insert indents automatically
vim.opt.termguicolors = true   -- True color support
vim.opt.wrap = false           -- Disable line wrap
vim.opt.ignorecase = true      -- Ignore case in search patterns
vim.opt.smartcase = true       -- Override ignorecase if search contains uppercase
vim.opt.updatetime = 250       -- Decrease update time
vim.opt.signcolumn = "yes"     -- Always show sign column

-- Plugin specifications
require("lazy").setup({
-- Theme
{
  'dasupradyumna/midnight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
	  vim.cmd([[colorscheme midnight]])
  end
},

-- File explorer
{
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    },
    config = function()
    vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>')
    end
},

-- Fuzzy finder
{
    'nvim-telescope/telescope.nvim',
    dependencies = {
    'nvim-lua/plenary.nvim'
    },
    config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>fb', builtin.buffers)
    end
},

-- Git integration
{
    "tpope/vim-fugitive",
    cmd = "Git",
},
{
    "lewis6991/gitsigns.nvim",
    config = true
},

-- Auto pairs
{
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
},

-- Multiple cursors alternative
{
    "mg979/vim-visual-multi",
    branch = "master",
},

-- Treesitter for better syntax highlighting
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "vim", "javascript", "typescript", "json" },
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
},

-- Comment.nvim for easy commenting
{
    "numToStr/Comment.nvim",
    config = true,
},

-- Which-key for keybinding help
{
    "folke/which-key.nvim",
    config = true,
},

-- Better status line
{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
},

-- LSP Support
{
    "neovim/nvim-lspconfig",
    dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    }
},

-- Autocompletion
{
    "hrsh7th/nvim-cmp",
    dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    },
},
})

-- LSP Configuration
require("mason").setup({
	ui = {
		icons = {
			package_installed = "",
			package_pending = "",
			package_uninstalled = "",
		},
	}
})
require("mason-lspconfig").setup({
ensure_installed = {
    "typescript-language-server",
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "clangd",          -- For C/C++
    "eslint",
    "lua_ls",
    "rust_analyzer",    -- For Rust
    "gopls",           -- For Go
},
automatic_installation = true,
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Completion setup
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
snippet = {
    expand = function(args)
    luasnip.lsp_expand(args.body)
    end,
},
mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
    end, { 'i', 's' }),
}),
sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
}, {
    { name = 'buffer' },
}),
})

-- Global LSP keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

-- Buffer navigation
vim.keymap.set('n', '<S-h>', ':bprevious<CR>')
vim.keymap.set('n', '<S-l>', ':bnext<CR>')
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>')

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end,
})
