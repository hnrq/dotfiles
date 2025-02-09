return {
{
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
    check_ts = true,
    },
},
{
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
},
{
    "mg979/vim-visual-multi",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
    vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
    }
    end,
},
}

