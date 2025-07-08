-- Configuração para nvim-ufo usando lazy.nvim
-- Este ficheiro define a configuração do plugin nvim-ufo para ser usada com o gestor de plugins lazy.nvim.

return {
  'kevinhwang99/nvim-ufo',
  dependencies = {
    'neovim/nvim-treesitter',     -- nvim-ufo pode usar treesitter para dobramento aprimorado
    'kevinhwang99/promise-async', -- Dependência do nvim-ufo para funções assíncronas
  },
  -- Configuração do plugin nvim-ufo
  config = function()
    -- Funções auxiliares para obter o nível de dobramento
    local getFoldLevel = function(lnum)
      local foldlevel = vim.fn.foldlevel(lnum)
      -- Apenas retorna o foldlevel se for maior que o foldlevel global atual
      -- Isto evita que dobras sejam reportadas onde o Neovim não as reconheceria
      if foldlevel > vim.o.foldlevel then
        return foldlevel
      end
      return 0
    end

    -- Configuração principal do nvim-ufo
    require('ufo').setup({
      -- Manipulador de texto virtual para dobras
      -- Adiciona um sufixo '...' e o número de linhas dobradas
      fold_virt_text_handler = function()
        return function(virt_text, lnum, end_lnum, width, truncate)
          local new_virt_text = {}
          local suffix = '...'               -- Sufixo para indicar conteúdo dobrado
          local fold_count = end_lnum - lnum -- Número de linhas dobradas

          -- Insere o texto virtual formatado
          table.insert(new_virt_text, {
            string.format(" %s %d lines %s", suffix, fold_count, suffix),
            "MoreMsg" -- Grupo de destaque para o texto virtual
          })

          return new_virt_text
        end
      end,
      -- Seletor do provedor de dobramento
      -- Prioriza 'treesitter' se estiver disponível, caso contrário usa 'indent'
      provider_selector = function(bufnr, filetype, buftype)
        if require('ufo').is_treesitter_available() then
          return { 'treesitter', 'indent' }
        else
          return { 'indent' }
        end
      end,
      -- Manipulador de nível de dobramento para o provedor 'indent'
      indent_fold_level_handler = function(bufnr)
        return getFoldLevel
      end,
      -- Manipulador de nível de dobramento para o provedor 'treesitter'
      treesitter_fold_level_handler = function(bufnr)
        return getFoldLevel
      end,
      -- Outras opções úteis para o nvim-ufo
      open_fold_hl_groups = { 'Folded', 'FoldColumn' },  -- Grupos de destaque para dobras abertas
      close_fold_hl_groups = { 'Folded', 'FoldColumn' }, -- Grupos de destaque para dobras fechadas
      enable_get_fold_virt_text = true,                  -- Habilita o texto virtual para dobras
      preview_fold_virt_text = true,                     -- Mostra o texto virtual na pré-visualização
    })

    -- Mapeamentos de teclas (keybindings) para dobramento com nvim-ufo
    -- Estes mapeamentos são exemplos e podem ser personalizados.
    -- Certifique-se de que não há conflitos com outros mapeamentos no seu Neovim.

    -- Descomente as linhas abaixo para ativar os mapeamentos de teclas
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "UFO: Abrir todas as dobras" })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "UFO: Fechar todas as dobras" })
    vim.keymap.set('n', 'zr', function() require('ufo').openFoldsWith(1) end, { desc = "UFO: Abrir dobras (nível 1)" })
    vim.keymap.set('n', 'zm', function() require('ufo').closeFoldsWith(1) end, { desc = "UFO: Fechar dobras (nível 1)" })
    vim.keymap.set('n', 'za', require('ufo').toggleFold, { desc = "UFO: Alternar dobra atual" })
    vim.keymap.set('n', 'zd', require('ufo').deleteFold, { desc = "UFO: Apagar dobra" })
    vim.keymap.set('n', 'zi', require('ufo').insertFold, { desc = "UFO: Inserir dobra" })
  end,
}
