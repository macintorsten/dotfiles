if not vim.uv and vim.loop then
    vim.uv = vim.loop
end

vim.fs = vim.fs or {}

if not vim.fs.joinpath then
    function vim.fs.joinpath(...)
        local parts = vim.tbl_flatten({ ... })
        return table.concat(parts, "/"):gsub("//+", "/")
    end
end
