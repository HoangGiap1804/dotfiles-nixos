return{
    -- "folke/tokyonight.nvim",
    -- config = function ()
    --     require("tokyonight").setup({
    --         style = "moon",  -- "storm", "night", "moon", "day"
    --         transparent = true, -- nếu muốn nền trong suốt
    --     })
    --     vim.cmd("colorscheme tokyonight")
    -- end 
    "craftzdog/solarized-osaka.nvim",
    config = function ()
        require("solarized-osaka").setup({
          transparent = true,
          terminal_colors = false,
        })
        vim.cmd("colorscheme solarized-osaka")
    end 
}
