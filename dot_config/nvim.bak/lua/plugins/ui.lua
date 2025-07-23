return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme catppuccin-macchiato")
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    options = {
      theme = "auto",
      component_separators = "|",
      section_separators = "",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      win = {
        border = "single"
      }
    },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
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
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        position = "left",
        width = 30,
      },
    }
  },
}
