-- Keymaps configuration file
-- Define common options
local opts = { noremap = true, silent = true }

-- Helper function for better organization
local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

------------------------------
-- General Navigation
------------------------------
-- Better window navigation
map('n', '<C-h>', '<C-w>h', 'Navigate to left window')
map('n', '<C-j>', '<C-w>j', 'Navigate to lower window')
map('n', '<C-k>', '<C-w>k', 'Navigate to upper window')
map('n', '<C-l>', '<C-w>l', 'Navigate to right window')

-- Better indenting
map('v', '<', '<gv', 'Indent left')
map('v', '>', '>gv', 'Indent right')

-- Move text up and down
map('v', '<A-j>', ":m '>+1<CR>gv=gv", 'Move text down')
map('v', '<A-k>', ":m '<-2<CR>gv=gv", 'Move text up')

------------------------------
-- Window Management
------------------------------
map('n', '<leader>sv', '<C-w>v', 'Split window vertically')
map('n', '<leader>sh', '<C-w>s', 'Split window horizontally')
map('n', '<leader>se', '<C-w>=', 'Make splits equal size')
map('n', '<leader>sx', ':close<CR>', 'Close current split')

------------------------------
-- Buffer Management
------------------------------
map('n', '<S-l>', ':bnext<CR>', 'Next buffer')
map('n', '<S-h>', ':bprevious<CR>', 'Previous buffer')
map('n', '<leader>c', ':bd<CR>', 'Close buffer')

------------------------------
-- LSP Keymaps
------------------------------
-- These will be enabled when LSP attaches to a buffer
local function setup_lsp_keymaps(bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'K', vim.lsp.buf.hover, 'Show hover information')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('n', '<C-k>', vim.lsp.buf.signature_help, 'Show signature help')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
    map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code actions')
    map('n', 'gr', vim.lsp.buf.references, 'Show references')
    map('n', '<leader>f', vim.lsp.buf.format, 'Format buffer')
end

------------------------------
-- Telescope Keymaps
------------------------------
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, 'Find files')
map('n', '<leader>fg', builtin.live_grep, 'Live grep')
map('n', '<leader>fb', builtin.buffers, 'Find buffers')
map('n', '<leader>fh', builtin.help_tags, 'Find help tags')
map('n', '<leader>fr', builtin.oldfiles, 'Find recent files')
map('n', '<leader>fs', builtin.grep_string, 'Find string under cursor')

------------------------------
-- File Explorer (Neo-tree)
------------------------------
map('n', '<leader>e', ':Neotree toggle<CR>', 'Toggle file explorer')
map('n', '<leader>o', ':Neotree focus<CR>', 'Focus file explorer')

-- Return the LSP keymaps setup function so it can be used in LSP on_attach
return {
    setup_lsp_keymaps = setup_lsp_keymaps
}

