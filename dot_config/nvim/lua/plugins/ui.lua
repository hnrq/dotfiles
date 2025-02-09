return {
{
    "dasupradyumna/midnight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
    vim.cmd.colorscheme("midnight")
    end,
},
{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
    require("lualine").setup({
        options = {
        theme = "auto",
        component_separators = "|",
        section_separators = "",
        },
    })
    end,
},
{
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup({
        window = {
        border = "single",
        },
    })
    end,
},
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    },
    config = function()
    require("neo-tree").setup({
        filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
        },
        window = {
        position = "left",
        width = 30,
        },
    })
    end,
},
}

