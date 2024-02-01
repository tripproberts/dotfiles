-- copied from https://github.com/nvim-telescope/telescope.nvim/blob/9cf58f438f95f04cf1709b734bbcb9243c262d70/lua/telescope/actions/init.lua
--- Ask user to confirm an action
---@param prompt string: The prompt for confirmation
---@return boolean: Whether user confirmed the prompt
local function ask_to_confirm(prompt)
	local yes_values = { "y", "yes" }
	local default_value = ""
	local confirmation = vim.fn.input(prompt, default_value)
	confirmation = string.lower(confirmation)
	if string.len(confirmation) == 0 then
		return false
	end
	for _, v in pairs(yes_values) do
		if v == confirmation then
			return true
		end
	end
	return false
end

-- copy of telescope.actions.git_delete_branch except it doesn't prefill 'y' in the confirmation
-- https://github.com/nvim-telescope/telescope.nvim/blob/9cf58f438f95f04cf1709b734bbcb9243c262d70/lua/telescope/actions/init.lua
local function delete_branch(bufnr)
	local action_state = require("telescope.actions.state")
	local utils = require("telescope.utils")
	local confirmation = ask_to_confirm("Do you really want to delete the selected branches? [Y/n] ")
	if not confirmation then
		utils.notify("actions.git_delete_branch", {
			msg = "action canceled",
			level = "INFO",
		})
		return
	end

	local picker = action_state.get_current_picker(bufnr)
	local action_name = "actions.git_delete_branch"
	picker:delete_selection(function(selection)
		local branch = selection.value
		print("Deleting branch " .. branch)
		local _, ret, stderr = utils.get_os_command_output({ "git", "branch", "-D", branch }, picker.cwd)
		if ret == 0 then
			utils.notify(action_name, {
				msg = string.format("Deleted branch: %s", branch),
				level = "INFO",
			})
		else
			utils.notify(action_name, {
				msg = string.format(
					"Error when deleting branch: %s. Git returned: '%s'",
					branch,
					table.concat(stderr, " ")
				),
				level = "ERROR",
			})
		end
		return ret == 0
	end)
end

-- modification of telescope.actions.git_create_branch which doesn't close the preview dialog or require confirmation
-- https://github.com/nvim-telescope/telescope.nvim/blob/9cf58f438f95f04cf1709b734bbcb9243c262d70/lua/telescope/actions/init.lua
local function create_branch(bufnr)
	local action_state = require("telescope.actions.state")
	local utils = require("telescope.utils")
	local cwd = action_state.get_current_picker(bufnr).cwd
	local new_branch = action_state.get_current_line()

	if new_branch == "" then
		utils.notify("actions.git_create_branch", {
			msg = "Missing the new branch name",
			level = "ERROR",
		})
	else
		require("telescope.actions").close(bufnr)
		local _, ret, stderr = utils.get_os_command_output({ "git", "checkout", "-b", new_branch }, cwd)
		if ret == 0 then
			utils.notify("actions.git_create_branch", {
				msg = string.format("Switched to a new branch: %s", new_branch),
				level = "INFO",
			})
			require("telescope.builtin").git_branches()
		else
			utils.notify("actions.git_create_branch", {
				msg = string.format(
					"Error when creating new branch: '%s' Git returned '%s'",
					new_branch,
					table.concat(stderr, " ")
				),
				level = "INFO",
			})
		end
	end
end

-- modification of telescope.actions.git_checkout which reloads the preview menu after checking out a branch
-- https://github.com/nvim-telescope/telescope.nvim/blob/9cf58f438f95f04cf1709b734bbcb9243c262d70/lua/telescope/actions/init.lua
local function checkout_branch(bufnr)
	local action_state = require("telescope.actions.state")
	local utils = require("telescope.utils")
	local cwd = action_state.get_current_picker(bufnr).cwd
	local selection = action_state.get_selected_entry()
	if selection == nil then
		utils.__warn_no_selection("actions.git_checkout")
		return
	end
	require("telescope.actions").close(bufnr)
	local _, ret, stderr = utils.get_os_command_output({ "git", "checkout", selection.value }, cwd)
	if ret == 0 then
		utils.notify("actions.git_checkout", {
			msg = string.format("Checked out: %s", selection.value),
			level = "INFO",
		})
		vim.cmd("checktime")
		require("telescope.builtin").git_branches()
	else
		utils.notify("actions.git_checkout", {
			msg = string.format(
				"Error when checking out: %s. Git returned: '%s'",
				selection.value,
				table.concat(stderr, " ")
			),
			level = "ERROR",
		})
	end
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"plenary",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_strategy = "vertical",
				mappings = {
					n = {
						["<C-f>"] = function(bufnr)
							return require("telescope.actions").preview_scrolling_down(bufnr)
						end,
						["<C-b>"] = function(bufnr)
							return require("telescope.actions").preview_scrolling_up(bufnr)
						end,
					},
				},
			},
			pickers = {
				grep_string = {
					initial_mode = "normal",
				},
				lsp_references = {
					initial_mode = "normal",
				},
				lsp_definitions = {
					initial_mode = "normal",
				},
				git_branches = {
					initial_mode = "normal",
					show_remote_tracking_branches = false,
					mappings = {
						i = {
							["<CR>"] = function(bufnr)
								create_branch(bufnr)
							end,
						},
						n = {
							["dd"] = function(bufnr)
								delete_branch(bufnr)
							end,
							["<CR>"] = function(bufnr)
								checkout_branch(bufnr)
							end,
						},
					},
				},
				git_status = {
					initial_mode = "normal",
				},
				git_commits = {
					initial_mode = "normal",
				},
			},
		})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>o", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
		vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
		vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
		vim.keymap.set("n", "<leader>f", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
}
