return {
{
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
    'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-project.nvim',
    },
    keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },
    { '<leader>fp', '<cmd>Telescope projects<cr>', desc = 'Projects' },
    { '<leader>fe', '<cmd>Telescope file_browser<cr>', desc = 'File Browser' },
    },
    opts = {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        file_ignore_patterns = { "node_modules", ".git/" },
        layout_config = {
        horizontal = {
            preview_width = 0.55,
            results_width = 0.8,
        },
        vertical = {
            mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
        },
    },
    extensions = {
        fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
        },
    },
    },
    config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("projects")
    end,
}
}

