local opt = vim.opt

opt.number = true
opt.scrolloff = 7
opt.autoread = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.linebreak = true
opt.textwidth = 500
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.backspace = { "indent", "eol", "start" }
opt.whichwrap:append("<,>,h,l")
opt.ruler = true
opt.foldcolumn = "1"
opt.wrap = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildignore:append({
    "*.o",
    "*~",
    "*.pyc",
    "*/.git/*",
    "*/.hg/*",
    "*/.svn/*",
    "*/.DS_Store",
})
