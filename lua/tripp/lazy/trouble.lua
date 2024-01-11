return {
    "folke/trouble.nvim",
    opts = {
        icons = false,
    },
    config = function()
        local trouble = require("trouble")
        vim.keymap.set("n", "<leader>tt", function() trouble.toggle() end)
    end
}
