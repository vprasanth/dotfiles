--[[ opts.lua ]]
local opt = vim.opt
local g = vim.g

-- [[ Context Options ]]
opt.colorcolumn = "80" -- Show column for max line length
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.scrolloff = 8 -- Min num lines of context
opt.signcolumn = "yes" -- Show the sign column
opt.cursorline = true -- Highlight current line
opt.cursorlineopt = "number" -- Highlight only the number column
opt.wrap = false -- Disable line wrapping
opt.linebreak = true -- Break lines at word boundaries
opt.breakindent = true -- Preserve indentation in wrapped lines
opt.showbreak = "↪ " -- Character to show at the start of wrapped lines

-- [[ File Options ]]
opt.encoding = "utf8" -- String encoding to use
opt.fileencoding = "utf8" -- File encoding to use
opt.fileformat = "unix" -- File format to use
opt.fileformats = "unix,dos,mac" -- File formats to try
opt.backup = false -- Don't create backup files
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Set undo directory
opt.undolevels = 1000 -- Maximum number of changes that can be undone
opt.updatecount = 0 -- Don't write swap files
opt.updatetime = 300 -- Faster completion (default: 4000ms)
opt.timeoutlen = 500 -- Time to wait for a mapped sequence to complete

-- [[ Theme and UI ]]
opt.syntax = "ON" -- Enable syntax highlighting
opt.termguicolors = true -- Enable true color support
opt.background = "dark" -- Use dark background
vim.cmd([[colorscheme kanagawa-wave]]) -- Set colorscheme
opt.pumblend = 10 -- Popup menu transparency
opt.winblend = 10 -- Window transparency
opt.showmode = false -- Don't show mode in command line
opt.showcmd = false -- Don't show command in status line
opt.cmdheight = 1 -- Height of command line
opt.laststatus = 3 -- Always show status line
opt.ruler = false -- Don't show cursor position
opt.numberwidth = 4 -- Width of number column
opt.list = false -- Don't show invisible characters

-- [[ Search Options ]]
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search contains capitals
opt.incsearch = true -- Use incremental search
opt.hlsearch = false -- Don't highlight search matches
opt.gdefault = true -- Always use global flag in search
opt.magic = true -- Use magic patterns in search

-- [[ Whitespace Options ]]
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.softtabstop = 2 -- Number of spaces tabs count for in insert mode
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Smart auto-indenting
opt.autoindent = true -- Auto-indent new lines
opt.breakindent = true -- Preserve indentation in wrapped lines

-- [[ Window Options ]]
opt.splitright = true -- Place new window to right of current one
opt.splitbelow = true -- Place new window below the current one
opt.equalalways = false -- Don't make all windows equal size

-- [[ Completion Options ]]
opt.completeopt = "menu,menuone,noselect" -- Better completion experience
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.wildmenu = true -- Enable wild menu
opt.wildignorecase = true -- Ignore case in wild menu
opt.wildignore = {
  "*.o",
  "*.obj",
  "*.dll",
  "*.jar",
  "*.pyc",
  "*.rbc",
  "*.class",
  "*.hi",
  "*.pdb",
  "*.lib",
  "*.so",
  "*.dylib",
  "*.ncb",
  "*.sdf",
  "*.suo",
  "*.pdb",
  "*.idb",
  ".DS_Store",
  ".git",
  ".hg",
  ".svn",
  "*.swp",
  "*.swo",
  "*.swn",
  "*.bak",
  "*.orig",
  "*.rej",
  "*.tmp",
  "*.temp",
}

-- [[ Plugin Options ]]
g.neoformat_try_node_exe = 1
g.gitblame_enabled = 0
opt.mouse = "" -- Disable mouse support
