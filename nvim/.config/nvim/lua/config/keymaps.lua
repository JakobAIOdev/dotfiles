local map = vim.keymap.set

local function opts(desc) return { desc = desc, silent = true } end

-- General
map("n", "<Esc>", "<cmd>nohlsearch<cr>", opts("Clear search highlight"))
map("n", "<leader>ww", "<cmd>write<cr>", opts("Save file"))
map("n", "<leader>wa", "<cmd>wall<cr>", opts("Save all files"))
map("n", "<leader>qq", "<cmd>quitall<cr>", opts("Quit Neovim"))
map("n", "<leader>l", "<cmd>Lazy<cr>", opts("Plugin manager"))

-- Better movement
map("n", "<C-d>", "<C-d>zz", opts("Scroll down"))
map("n", "<C-u>", "<C-u>zz", opts("Scroll up"))
map("n", "n", "nzzzv", opts("Next search result"))
map("n", "N", "Nzzzv", opts("Previous search result"))
map("n", "J", "mzJ`z", opts("Join lines"))

-- Move selections and keep them selected while indenting
map("x", "J", ":move '>+1<cr>gv=gv", opts("Move selection down"))
map("x", "K", ":move '<-2<cr>gv=gv", opts("Move selection up"))
map("x", "<", "<gv", opts("Indent left"))
map("x", ">", ">gv", opts("Indent right"))

-- Keep the copied text when pasting over a selection
map("x", "<leader>p", [["_dP]], opts("Paste without replacing register"))
map({ "n", "x" }, "<leader>D", [["_d]], opts("Delete without yanking"))

-- Windows
map("n", "<C-h>", "<C-w>h", opts("Window left"))
map("n", "<C-j>", "<C-w>j", opts("Window down"))
map("n", "<C-k>", "<C-w>k", opts("Window up"))
map("n", "<C-l>", "<C-w>l", opts("Window right"))
map("n", "<C-Up>", "<cmd>resize +2<cr>", opts("Increase window height"))
map("n", "<C-Down>", "<cmd>resize -2<cr>", opts("Decrease window height"))
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opts("Decrease window width"))
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts("Increase window width"))
map("n", "<leader>-", "<C-w>s", opts("Split below"))
map("n", "<leader>|", "<C-w>v", opts("Split right"))
map("n", "<leader>wd", "<C-w>c", opts("Close window"))
map("n", "<leader>we", "<C-w>=", opts("Equalize windows"))

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", opts("Previous buffer"))
map("n", "<S-l>", "<cmd>bnext<cr>", opts("Next buffer"))
map("n", "[b", "<cmd>bprevious<cr>", opts("Previous buffer"))
map("n", "]b", "<cmd>bnext<cr>", opts("Next buffer"))

-- Quickfix and location lists
map("n", "[q", "<cmd>cprev<cr>zz", opts("Previous quickfix item"))
map("n", "]q", "<cmd>cnext<cr>zz", opts("Next quickfix item"))
map("n", "[l", "<cmd>lprev<cr>zz", opts("Previous location item"))
map("n", "]l", "<cmd>lnext<cr>zz", opts("Next location item"))

-- Terminal navigation
map("t", "<Esc><Esc>", "<C-\\><C-n>", opts("Terminal normal mode"))
map("t", "<C-h>", "<cmd>wincmd h<cr>", opts("Window left"))
map("t", "<C-j>", "<cmd>wincmd j<cr>", opts("Window down"))
map("t", "<C-k>", "<cmd>wincmd k<cr>", opts("Window up"))
map("t", "<C-l>", "<cmd>wincmd l<cr>", opts("Window right"))
