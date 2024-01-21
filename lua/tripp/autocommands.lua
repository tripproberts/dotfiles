-- Auto save
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "BufWinLeave" }, {
	callback = function(args)
		if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
			vim.cmd("silent! w")
			-- Format entire lua file because they don't format correctly otherwise
			if vim.bo.filetype == "lua" then
				require("conform").format({ bufnr = args.buf })
			else
				-- Otherwise format git diff
				local lines = vim.fn.system("git diff --unified=0"):gmatch("[^\n\r]+")
				local ranges = {}
				for line in lines do
					if line:find("^@@") then
						local line_nums = line:match("%+.- ")
						if line_nums:find(",") then
							local _, _, first, second = line_nums:find("(%d+),(%d+)")
							table.insert(ranges, {
								start = { tonumber(first), 0 },
								["end"] = { tonumber(first) + tonumber(second), 0 },
							})
						else
							local first = tonumber(line_nums:match("%d+"))
							table.insert(ranges, {
								start = { first, 0 },
								["end"] = { first + 1, 0 },
							})
						end
					end
				end
				local format = require("conform").format
				for _, range in pairs(ranges) do
					format({
						range = range,
					})
				end
			end
		end
	end,
})
