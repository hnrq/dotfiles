-- Core plugins and dependencies
return {
{
    "nvim-lua/plenary.nvim",
    lazy = true,
},
{
    "MunifTanjim/nui.nvim",
    lazy = true,
},
{
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
},
{
    "kkharji/sqlite.lua",
    enabled = function()
    return not jit.os:find("Windows")
    end,
},
}

