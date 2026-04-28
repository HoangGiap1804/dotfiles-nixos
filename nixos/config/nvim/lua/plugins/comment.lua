return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      -- dùng cho block comment
      mappings = {
        basic = true,
        extra = true,
      },
    })

    -- Normal mode: <leader>/ để block comment 1 dòng
    vim.keymap.set("n", "<leader>/", function()
      require("Comment.api").toggle.blockwise.current()
    end, { desc = "Block comment line" })

    -- Visual mode: <leader>/ để block comment đoạn chọn
    vim.keymap.set("x", "<leader>/", function()
      require("Comment.api").toggle.blockwise(vim.fn.visualmode())
    end, { desc = "Block comment selection" })
  end,
}
