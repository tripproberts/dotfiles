return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    "plenary"
  },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_strategy = "vertical",
      },
      pickers = {
        grep_string = {
          initial_mode = "normal",
        },
        lsp_references = {
          initial_mode = "normal",
        },
        git_branches = {
          initial_mode = "normal",
          show_remote_tracking_branches = false,
          mappings = {
            n = {
              ["dd"] = function(bufnr)
                require('telescope.actions').git_delete_branch(bufnr)
              end
            }
          }
        },
        git_status = {
          initial_mode = "normal",
        },
        git_commits = {
          initial_mode = "normal",
          mappings = {
            n = {
              ["<C-f>"] = function(bufnr)
                return require('telescope.actions').preview_scrolling_down(bufnr)
              end,
              ["<C-b>"] = function(bufnr)
                return require('telescope.actions').preview_scrolling_up(bufnr)
              end
            }
          }
        },
      }
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>o', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>h', builtin.oldfiles, {})
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
    vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
    vim.keymap.set('n', '<leader>f', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end)
  end
}
