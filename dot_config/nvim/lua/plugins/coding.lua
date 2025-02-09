return {
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    },
    config = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
        "bash", "c", "cpp", "css", "html", "javascript", "json", "lua",
        "python", "rust", "typescript", "vim", "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            },
        },
        },
    })
    end,
},
{
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
    char = "│",
    filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
    show_trailing_blankline_indent = false,
    show_current_context = true,
    },
},
{
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
},
{
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
    position = "bottom",
    icons = true,
    mode = "workspace_diagnostics",
    severity = nil,
    fold_open = "",
    fold_closed = "",
    group = true,
    padding = true,
    cycle_results = true,
    action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = "<cr>",
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = {"zM", "zm"},
        open_folds = {"zR", "zr"},
        toggle_fold = {"zA", "za"},
        previous = "k",
        next = "j"
    },
    },
},
}

