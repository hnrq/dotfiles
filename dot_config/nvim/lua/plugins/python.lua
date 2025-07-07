return {
  -- Ruff linting and formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      
      conform.setup({
        formatters_by_ft = {
          python = { "ruff_format", "ruff_organize_imports" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      })
      
      -- Custom formatters for Ruff
      conform.formatters.ruff_format = {
        command = "ruff",
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
        stdin = true,
      }
      
      conform.formatters.ruff_organize_imports = {
        command = "ruff",
        args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
        stdin = true,
      }
      
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },

  -- Linting with nvim-lint for Ruff
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      
      lint.linters_by_ft = {
        python = { "ruff" },
      }
      
      -- Configure Ruff linter
      lint.linters.ruff = {
        cmd = "ruff",
        stdin = true,
        args = { "check", "--output-format", "json", "--stdin-filename", function() return vim.api.nvim_buf_get_name(0) end, "-" },
        stream = "stdout",
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or not decoded then
            return diagnostics
          end
          
          for _, item in ipairs(decoded) do
            if item.location then
              table.insert(diagnostics, {
                lnum = item.location.row - 1,
                col = item.location.column - 1,
                end_lnum = item.end_location and item.end_location.row - 1 or item.location.row - 1,
                end_col = item.end_location and item.end_location.column - 1 or item.location.column - 1,
                severity = vim.diagnostic.severity.WARN,
                message = item.message,
                source = "ruff",
                code = item.code,
              })
            end
          end
          
          return diagnostics
        end,
      }
      
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
      
      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },

  -- Python-specific keymaps and settings
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },
}
