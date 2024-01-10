-- Auto save
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "BufWinLeave", "InsertLeave" }, {
    callback = function(args)
        if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
            vim.cmd "silent! w"
            -- Format on save
            require("conform").format({ bufnr = args.buf })
        end
    end,
})
