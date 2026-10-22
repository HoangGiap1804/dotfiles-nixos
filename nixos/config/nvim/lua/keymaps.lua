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

-- Quickfix list navigation
keymap.set("n", "<leader>co", function()
	local qf_win = vim.fn.getqflist({ winid = 0 }).winid
	if qf_win ~= 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { desc = "Toggle Quickfix" })
keymap.set("n", "[q", ":cprev<CR>", { silent = true, desc = "Previous Quickfix Error" })
keymap.set("n", "]q", ":cnext<CR>", { silent = true, desc = "Next Quickfix Error" })

-- C / C++ & Make Build & Run
keymap.set("n", "<leader>cb", function()
	vim.cmd("wa") -- Save all buffers
	if vim.fn.filereadable("Makefile") == 1 or vim.fn.filereadable("makefile") == 1 then
		vim.notify("Building with Makefile...", vim.log.levels.INFO)
		vim.cmd("make")
		vim.cmd("cwindow")
	elseif vim.fn.isdirectory("build") == 1 and vim.fn.filereadable("CMakeLists.txt") == 1 then
		vim.notify("Building with CMake...", vim.log.levels.INFO)
		vim.cmd("set makeprg=cmake\\ --build\\ build")
		vim.cmd("make")
		vim.cmd("cwindow")
	else
		local ft = vim.bo.filetype
		local file = vim.fn.expand("%")
		local out = vim.fn.expand("%:r")
		if ft == "cpp" then
			vim.notify("Compiling C++ file: " .. file, vim.log.levels.INFO)
			vim.cmd(string.format("set makeprg=g++\\ -std=c++17\\ -Wall\\ -Wextra\\ -g\\ %s\\ -o\\ %s", file, out))
			vim.cmd("make")
			vim.cmd("cwindow")
		elseif ft == "c" then
			vim.notify("Compiling C file: " .. file, vim.log.levels.INFO)
			vim.cmd(string.format("set makeprg=gcc\\ -Wall\\ -Wextra\\ -g\\ %s\\ -o\\ %s", file, out))
			vim.cmd("make")
			vim.cmd("cwindow")
		else
			vim.notify("No Makefile/CMake or C/C++ file to build", vim.log.levels.WARN)
		end
	end
end, { desc = "Build (Make / CMake / C/C++)" })

keymap.set("n", "<leader>cr", function()
	local out = vim.fn.expand("%:r")
	if vim.fn.filereadable(out) == 1 and vim.fn.executable(out) == 1 then
		vim.cmd(string.format("split | terminal ./%s", out))
	elseif vim.fn.filereadable("build/main") == 1 and vim.fn.executable("build/main") == 1 then
		vim.cmd("split | terminal ./build/main")
	elseif vim.fn.filereadable("main") == 1 and vim.fn.executable("main") == 1 then
		vim.cmd("split | terminal ./main")
	else
		vim.notify("Binary executable not found! Run <leader>cb to build first.", vim.log.levels.WARN)
	end
end, { desc = "Run compiled C/C++ executable" })

