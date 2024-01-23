return {
	{
		"airblade/vim-gitgutter",
		config = function()
			vim.keymap.set("n", "<leader>hn", vim.cmd.GitGutterNextHunk)
			vim.keymap.set("n", "<leader>hp", vim.cmd.GitGutterPrevHunk)
			vim.keymap.set("n", "<leader>hd", vim.cmd.GitGutterPreviewHunk)
			vim.keymap.set("n", "<leader>hs", vim.cmd.GitGutterStageHunk)
			vim.keymap.set("n", "<leader>hu", vim.cmd.GitGutterUndoHunk)
		end,
	},
	{
		"tpope/vim-fugitive",
	},
}
