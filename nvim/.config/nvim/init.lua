vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Ignore old packer "start" packages; lazy.nvim owns this config's runtime.
vim.opt.packpath:remove(vim.fn.stdpath("data") .. "/site")

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
