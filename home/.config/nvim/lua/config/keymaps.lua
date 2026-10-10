local map = vim.keymap.set

local function open_quickfix()
    vim.cmd("cwindow")
    if vim.tbl_isempty(vim.fn.getqflist()) then
        vim.notify("No matches found", vim.log.levels.INFO)
    end
end

local function get_visual_selection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

    if vim.tbl_isempty(lines) then
        return ""
    end

    lines[1] = string.sub(lines[1], start_pos[3], -1)
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])

    return table.concat(lines, " ")
end

local function git_grep(pattern)
    if pattern == nil or pattern == "" then
        vim.notify("GitGrep: empty pattern", vim.log.levels.WARN)
        return
    end

    vim.cmd("silent Ggrep! " .. vim.fn.shellescape(pattern))
    open_quickfix()
end

local function choose_colorscheme()
    require("fzf-lua").colorschemes({ live_preview = true })
end

vim.api.nvim_create_user_command("Colors", choose_colorscheme, {
    desc = "Preview installed colorschemes",
})

map("n", "<leader>w", "<cmd>write!<cr>", { desc = "Write file", silent = true })
map("n", "<leader><cr>", "<cmd>nohlsearch<cr>", { desc = "Clear search", silent = true })
map("n", "<c-j>", "<c-w>j", { desc = "Window down" })
map("n", "<c-k>", "<c-w>k", { desc = "Window up" })
map("n", "<c-h>", "<c-w>h", { desc = "Window left" })
map("n", "<c-l>", "<c-w>l", { desc = "Window right" })
map("n", "<leader>fc", choose_colorscheme, { desc = "Colorschemes" })
map("n", "<leader>gg", function()
    git_grep(vim.fn.expand("<cword>"))
end, { desc = "Git grep word" })
map("x", "<leader>gg", function()
    git_grep(get_visual_selection())
end, { desc = "Git grep selection" })
