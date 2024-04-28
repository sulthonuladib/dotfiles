return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
    },
    config = function()
        local tokyonight = require("tokyonight")
        tokyonight.setup({
            style = "storm",
            -- light_style = "day",
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
                sidebars = "transparent",
                floats = "transparent",
            },
            sidebars = { "qf", "help" },
            day_brightness = 0.3,
            hide_inactive_statusline = false,
            dim_inactive = false,
            lualine_bold = false,
        })
    end,
}
