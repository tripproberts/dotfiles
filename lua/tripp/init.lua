require("tripp.set")
require("tripp.lazy_init")
require("tripp.remap")
require("tripp.autocommands")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("TrippGroup", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "<leader>fr", function()
			require("telescope.builtin").lsp_references()
		end, opts)
		vim.keymap.set("n", "<leader>b", function()
			require("telescope.builtin").lsp_definitions()
		end, opts)
	end,
})

function GetGitBranch()
	local fugitive_branch = vim.fn["FugitiveHead"]()
	if fugitive_branch ~= "" then
		return " " .. fugitive_branch
	else
		return ""
	end
end

vim.api.nvim_set_hl(0, "GitBranch", { fg = "#00FF00", bg = "NONE" })
vim.o.statusline = "%<%f  %#GitBranch#%{v:lua.GetGitBranch()}%#Normal# %h%m%r%=%-14.(%l,%c%V%) %P"
