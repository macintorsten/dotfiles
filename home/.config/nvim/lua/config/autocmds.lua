local group = vim.api.nvim_create_augroup("dotfiles", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = { "*.txt", "*.js", "*.py", "*.wiki", "*.sh", "*.coffee", "*.lua" },
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd([[silent! %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function()
        local last = vim.fn.line([['"]])
        if last > 1 and last <= vim.fn.line("$") then
            vim.cmd([[normal! g'"]])
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end

        pcall(vim.treesitter.start, args.buf)
    end,
})
