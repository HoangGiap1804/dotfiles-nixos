local keymap = vim.keymap

keymap.set("n", "x", '"_x')
keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set("n", "ss", ":split<return><c-w>w", { silent = true })
keymap.set("n", "sv", ":vsplit<return><c-w>w", { silent = true })

-- move window
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

keymap.set("n", "<leader>e", vim.diagnostic.open_float)
keymap.set("n", "<leader>ne", vim.diagnostic.goto_next)
keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev)
