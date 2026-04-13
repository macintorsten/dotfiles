local function project_files()
    local ok = vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
    if vim.v.shell_error == 0 and ok:match("true") then
        require("fzf-lua").git_files()
        return
    end

    require("fzf-lua").files()
end

local has_native_lsp_enable = vim.lsp and vim.lsp.config and vim.lsp.enable

return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>g", group = "git" },
                { "<leader>c", group = "code" },
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<C-p>", project_files, desc = "Git files" },
            { "<C-f>", function() require("fzf-lua").files() end, desc = "Files" },
            { "<C-b>", function() require("fzf-lua").buffers() end, desc = "Buffers" },
            { "<leader>rg", function() require("fzf-lua").live_grep() end, desc = "Ripgrep" },
        },
        opts = {
            winopts = {
                height = 0.85,
                width = 0.80,
                preview = {
                    default = "bat",
                },
            },
        },
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Ggrep", "Gvdiffsplit" },
        keys = {
            { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
            { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff" },
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("config.lsp").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = { "bashls", "jsonls", "lua_ls", "yamlls" },
            automatic_installation = true,
            automatic_enable = has_native_lsp_enable and true or false,
        },
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        cmd = { "TSInstall", "TSInstallInfo", "TSUpdate", "TSUninstall" },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "bash", "java", "json", "lua", "markdown", "vim", "vimdoc", "yaml" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
