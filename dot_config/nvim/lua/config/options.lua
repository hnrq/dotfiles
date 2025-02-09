-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation settings
vim.opt.expandtab = true      -- Convert tabs to spaces
vim.opt.shiftwidth = 2        -- Number of spaces for indentation
vim.opt.tabstop = 2           -- Number of spaces for a tab
vim.opt.autoindent = true     -- Copy indent from current line when starting a new line
vim.opt.smartindent = true    -- Smart auto-indenting for programming

-- Search settings
vim.opt.ignorecase = true     -- Ignore case in search patterns
vim.opt.smartcase = true      -- Override ignorecase if search pattern has uppercase
vim.opt.hlsearch = true       -- Highlight all search matches
vim.opt.incsearch = true      -- Show search matches incrementally

-- UI settings
vim.opt.termguicolors = true  -- Enable 24-bit RGB color in the TUI
vim.opt.signcolumn = "yes"    -- Always show the signcolumn
vim.opt.cursorline = true     -- Highlight the current line
vim.opt.scrolloff = 8         -- Minimum number of lines to keep above/below cursor
vim.opt.wrap = false          -- Don't wrap lines by default
vim.opt.showmode = false      -- Don't show mode (lualine will show it instead)

-- File handling
vim.opt.swapfile = false      -- Don't create swap files
vim.opt.backup = false        -- Don't create backup files
vim.opt.undofile = true       -- Enable persistent undo
vim.opt.fileencoding = "utf-8"-- Default file encoding

-- Split behavior
vim.opt.splitbelow = true     -- Open horizontal splits below current window
vim.opt.splitright = true     -- Open vertical splits to the right

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"  -- Better completion experience
vim.opt.pumheight = 10        -- Maximum number of items to show in popup menu

-- Performance
vim.opt.updatetime = 250      -- Faster update time (default 4000ms)
vim.opt.timeoutlen = 300      -- Time to wait for mapped sequence to complete

-- Mouse support
vim.opt.mouse = "a"           -- Enable mouse in all modes

-- System clipboard
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard

-- Wild menu
vim.opt.wildmode = "longest:full,full"  -- Command-line completion mode
vim.opt.wildoptions = "pum"   -- Use popup menu for wildmenu

-- Character display
vim.opt.list = true
vim.opt.listchars = {
tab = "→ ",
trail = "·",
extends = "⟩",
precedes = "⟨",
nbsp = "␣",
}

