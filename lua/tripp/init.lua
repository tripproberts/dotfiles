require("tripp.set")
require("tripp.lazy_init")
require("tripp.remap")
require("tripp.autocommands")

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('TrippGroup', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<leader>fr',
      function() require('telescope.builtin').lsp_references({ noremap = true, silent = true }) end, opts)
    vim.keymap.set("n", "<leader>b", function() vim.lsp.buf.definition() end, opts)
  end
})
