-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "java",
-- 	callback = function()
-- 		local jdtls = require("jdtls")

-- 		local root_markers = { "mvnw", "gradlew", "pom.xml", ".git" }
-- 		local root_dir = require("jdtls.setup").find_root(root_markers)
-- 		if not root_dir then
-- 			return
-- 		end

-- 		local home = os.getenv("HOME")
-- 		local workspace = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- 		local config = {
-- 			cmd = {
-- 				"jdtls",
-- 				"--jvm-arg=-javaagent:/path/to/lombok.jar",
-- 				"-data",
-- 				workspace,
-- 			},
-- 			root_dir = root_dir,
-- 			settings = {
-- 				java = {
-- 					configuration = {
-- 						runtimes = {
-- 							{
-- 								name = "JavaSE-17",
-- 								path = "/etc/profiles/per-user/nqim/bin/java",
-- 							},
-- 						},
-- 					},
-- 				},
-- 			},
-- 		}

-- 		jdtls.start_or_attach(config)
-- 	end,
-- })

-- Makefile: Bắt buộc dùng Real TAB, không được expandtab (tránh lỗi 'missing separator')
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 8
		vim.opt_local.shiftwidth = 8
		vim.opt_local.softtabstop = 0
	end,
})

-- C / C++: Tab 4 spaces, commentstring cho comment.nvim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "h", "hpp" },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.commentstring = "// %s"
	end,
})

