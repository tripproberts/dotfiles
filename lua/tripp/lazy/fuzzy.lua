return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    "plenary"
  },
  config = function()
    require('telescope').setup({
      pickers = {
        grep_string = {
          initial_mode = "normal",
        }
      }
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>o', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>h', builtin.oldfiles, {})
    vim.keymap.set('n', '<leader>f', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end)
  end
}
