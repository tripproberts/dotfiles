vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- Store undo tree longterm
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "90"

vim.g.mapleader = " "

vim.opt.hlsearch = true

-- Load changed files on disk
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	pattern = { "*" },
	callback = function()
		-- Check if the current mode is not command-line mode
		if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
			vim.cmd("checktime")
		end
	end,
})
