-- Auto save
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "BufWinLeave", "InsertLeave" }, {
    callback = function()
        if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
            vim.cmd "silent! w"
        end
    end,
})
