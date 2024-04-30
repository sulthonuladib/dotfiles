return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,

        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = {    -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false, -- disables setting the background color.

                show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
                term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)

                dim_inactive = {
                    enabled = false, -- dims the background color of inactive window
                    shade = "dark",

                    percentage = 0.15, -- percentage of the shade to apply to the inactive window

                },
                no_italic = false,           -- Force no italic

                no_bold = false,             -- Force no bold
                no_underline = false,        -- Force no underline
                styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" }, -- Change the style of comments
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},

                    properties = {},
                    types = {},
                    operators = {},
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles

                },
                color_overrides = {},
                custom_highlights = {},
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })


            -- setup must be called before loading
            vim.cmd.colorscheme "catppuccin"
        end
    }
}

--    return {
--        "folke/tokyonight.nvim",
--        lazy = false,
--        priority = 1000,
--        opts = {
--        },
--        config = function()
--            local tokyonight = require("tokyonight")
--            tokyonight.setup({
--                style = "storm",
--                -- light_style = "day",
--                transparent = true,
--                terminal_colors = true,
--                styles = {
--                    comments = { italic = true },
--                    keywords = { italic = true },
--                    functions = {},
--                    variables = {},
--                    sidebars = "transparent",
--                    floats = "transparent",
--                },
--                sidebars = { "qf", "help" },
--                day_brightness = 0.3,
--                hide_inactive_statusline = false,
--                dim_inactive = false,
--                lualine_bold = false,
--            })
--        end,
--    }
