-- Create autocommand groups
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General settings group
local general_settings = augroup("GeneralSettings", { clear = true })

-- Highlight text on yank
autocmd("TextYankPost", {
group = general_settings,
callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
end,
desc = "Highlight text on yank",
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
group = general_settings,
pattern = "*",
command = [[%s/\s\+$//e]],
desc = "Remove trailing whitespace on save",
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
group = general_settings,
callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
    pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
end,
desc = "Return to last edit position when opening files",
})

-- Format on save group
local format_sync_group = augroup("FormatOnSave", { clear = true })

-- Format files on save (if a formatter is available)
autocmd("BufWritePre", {
group = format_sync_group,
callback = function()
    -- Check if there's an LSP that supports formatting
    local has_lsp = #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
    if has_lsp then
    vim.lsp.buf.format({ timeout_ms = 1000 })
    end
end,
desc = "Format files on save if a formatter is available",
})

-- Auto-resize windows on vim resize
autocmd("VimResized", {
group = general_settings,
callback = function()
    vim.cmd("tabdo wincmd =")
end,
desc = "Auto-resize windows when terminal is resized",
})

