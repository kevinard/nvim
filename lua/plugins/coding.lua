return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        goimports = {
          prepend_args = { "-local", "github.com/Scalingo" },
        },
      },
    },
  },
  { "ledger/vim-ledger", ft = "ledger" },
}
