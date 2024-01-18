return {
  {
    'airblade/vim-gitgutter',
    config = function()
      vim.keymap.set("n", "<leader>hn", vim.cmd.GitGutterNextHunk);
      vim.keymap.set("n", "<leader>hp", vim.cmd.GitGutterPrevHunk);
      vim.keymap.set("n", "<leader>hd", vim.cmd.GitGutterPreviewHunk);
    end
  },
  {
    'tpope/vim-fugitive',
  }
}
