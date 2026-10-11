return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "eslint",
                    "jdtls",
                    "clangd",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "emmet_language_server",
                    "intelephense",
                    "vue_ls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            languages = { "vue" },
                        },
                    },
                },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            })

            lspconfig.eslint.setup({
                capabilities = capabilities,
            })

            lspconfig.jdtls.setup({
                capabilities = capabilities,
            })

            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                    "--query-driver=/nix/store/*-gcc-*/bin/g++,/nix/store/*-gcc-wrapper-*/bin/g++,/**/*",
                },
            })

            lspconfig.html.setup({
                capabilities = capabilities,
            })

            lspconfig.cssls.setup({
                capabilities = capabilities,
            })

            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
            })

            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
                filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "vue" },
            })

            lspconfig.intelephense.setup({
                capabilities = capabilities,
            })

            lspconfig.vue_ls.setup({
                capabilities = capabilities,
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
