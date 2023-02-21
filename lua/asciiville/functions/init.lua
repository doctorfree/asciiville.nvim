local settings = require "asciiville.util.config".settings

local M = {}

---checks if the user uses lualine and then sets the lualine theme
local set_lualine = function()
    local has_lualine, lualine = pcall(require, "lualine")
    if has_lualine then
        lualine.setup {
            options = {
                theme = "auto"
            }
        }
    end
end

---switch to a given style
---@param style string name of the style to switch to
M.change_style = function(style)
    set_lualine()
    vim.g.asciiville_style = style
    print("Asciiville style: ", style)
    vim.cmd "colorscheme asciiville"
end

---toggle between styles
M.toggle_style = function()
    if vim.g.asciiville_style_iterator == nil then
        vim.g.asciiville_style_iterator = 0
    end
    local styles = {
        "darker",
        "lighter",
        "palenight",
        "oceanic",
        "deep ocean"
    }
    vim.g.asciiville_style_iterator = (vim.g.asciiville_style_iterator % (#styles)) + 1
    M.change_style(styles[vim.g.asciiville_style_iterator])
end

---toggle the end-of-buffer lines (~)
M.toggle_eob = function()
    local colors = require("asciiville.colors").editor

    settings.disable.eob_lines = not settings.disable.eob_lines

    if settings.disable.eob_lines then
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.bg })
    else
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.disabled })
    end
end

---use telescope to change the style
M.find_style = function()
    require("asciiville.functions.telescope_styles").find()
end

return M
