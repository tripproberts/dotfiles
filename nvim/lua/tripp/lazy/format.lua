return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettier" } },
				javascriptreact = { { "prettier" } },
				typescript = { { "prettier" } },
				typescriptreact = { { "prettier" } },
				markdown = { { "prettier" } },
				mdx = { { "prettier" } },
				json = { { "prettier", "fixjson" } },
				css = { { "prettier" } },
				html = { { "prettier" } },
				yaml = { { "prettier" } },
				sh = { "shfmt" },
				bash = { "shfmt" },
				go = { "gofmt" },
				xml = { "xmllint" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
			notify_on_error = false,
		})
	end,
}
