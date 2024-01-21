return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "ruff" },
        javascript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        mdx = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier", "fixjson" } },
        css = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        sh = { "shfmt" },
        bash = { "shfmt" },
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
