-- https://nvchad.com/config/Mappings
local M = {}

M.disabled = {
    n = {
        ["<C-t>"] = "",
    }
}

M.core = {
    n = {
        -- Ctrl+p opens telescope
        ["<C-S-p>"] = {"<cmd> Telescope <CR>", "Open Telescope"},
        ["<C-p>"] = {"<cmd> Telescope find_files <CR>", "Open File Finder"},

        -- Ctrl+t toggles file tree
        ["<C-t>"] = {"<cmd> NvimTreeToggle <CR>", "Toggle File Tree"}
    }
}

return M
