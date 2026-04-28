return{
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        --theme = "gruvbox"
        --theme = "moonbow"
        --theme = "dracula"
        -- theme = "solarized-osaka",
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      }
    })
  end
}
