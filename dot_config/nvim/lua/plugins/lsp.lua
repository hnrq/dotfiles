return {
-- Mason.nvim
{
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true
},
{
    "williamboman/mason-lspconfig.nvim",
    config = true,
    dependencies = {
    "williamboman/mason.nvim"
    }
},

-- LSP Configuration
{
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
    "mason.nvim",
    "mason-lspconfig.nvim",
    }
},

-- Autocompletion
{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    },
},

-- Snippets
{
    "L3MON4D3/LuaSnip",
    dependencies = {
    "rafamadriz/friendly-snippets",
    },
    build = "make install_jsregexp",
},

-- Additional LSP features
{
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = true
},
}

