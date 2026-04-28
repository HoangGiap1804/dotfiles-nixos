return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<Tab>",   "<cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    { "te",      "<cmd>tabnew<CR>",              desc = "New tab" },
  },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",              -- Chỉ hiển thị buffer, không dùng tab
        always_show_bufferline = false, -- Ẩn bufferline khi chỉ có một buffer
        close_command = "bdelete! %d", -- Xóa buffer khi đóng
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
      },
    })
  end,
}
