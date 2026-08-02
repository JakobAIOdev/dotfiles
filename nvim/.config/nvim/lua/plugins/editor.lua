return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function()
          require("nvim-treesitter-textobjects").setup({
            select = {
              lookahead = true,
              selection_modes = {
                ["@parameter.outer"] = "v",
                ["@function.outer"] = "V",
                ["@class.outer"] = "V",
              },
            },
            move = { set_jumps = true },
          })

          local select = require("nvim-treesitter-textobjects.select")
          local move = require("nvim-treesitter-textobjects.move")
          local swap = require("nvim-treesitter-textobjects.swap")
          local map = vim.keymap.set

          map({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end, {
            desc = "Around function",
          })
          map({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end, {
            desc = "Inside function",
          })
          map({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end, {
            desc = "Around class",
          })
          map({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end, {
            desc = "Inside class",
          })
          map({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer", "textobjects") end, {
            desc = "Around parameter",
          })
          map({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner", "textobjects") end, {
            desc = "Inside parameter",
          })

          map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, {
            desc = "Next function start",
          })
          map({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, {
            desc = "Next function end",
          })
          map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, {
            desc = "Previous function start",
          })
          map({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, {
            desc = "Previous function end",
          })
          map({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end, {
            desc = "Next class start",
          })
          map({ "n", "x", "o" }, "]C", function() move.goto_next_end("@class.outer", "textobjects") end, {
            desc = "Next class end",
          })
          map({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, {
            desc = "Previous class start",
          })
          map({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end, {
            desc = "Previous class end",
          })

          map("n", "<leader>cn", function() swap.swap_next("@parameter.inner") end, {
            desc = "Swap with next parameter",
          })
          map("n", "<leader>cp", function() swap.swap_previous("@parameter.inner") end, {
            desc = "Swap with previous parameter",
          })
        end,
      },
    },
    config = function()
      local languages = {
        "bash",
        "c",
        "c_sharp",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "javascript",
        "json",
        "kotlin",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "php",
        "prisma",
        "python",
        "query",
        "regex",
        "ruby",
        "sql",
        "toml",
        "tsx",
        "twig",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      }

      local treesitter = require("nvim-treesitter")
      treesitter.setup({})
      treesitter.install(languages)

      local group = vim.api.nvim_create_augroup("jakob_treesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(event)
          if vim.bo[event.buf].buftype ~= "" then return end

          local filetype = vim.bo[event.buf].filetype
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not pcall(vim.treesitter.language.add, language) then return end

          vim.treesitter.start(event.buf, language)
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Incremental selection was removed from nvim-treesitter main. This
      -- lightweight replacement keeps the familiar Ctrl-Space / Backspace UX.
      local selections = {}

      local function select_node(node)
        if not node then return end

        local start_row, start_col, end_row, end_col = node:range()
        if end_col == 0 and end_row > start_row then
          end_row = end_row - 1
          end_col = #vim.api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1]
        else
          end_col = math.max(end_col - 1, 0)
        end

        vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
        vim.cmd("normal! v")
        vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
      end

      local function start_selection()
        local node = vim.treesitter.get_node({ ignore_injections = false })
        if not node then return end
        selections[vim.api.nvim_get_current_buf()] = { node }
        select_node(node)
      end

      local function expand_selection()
        local buf = vim.api.nvim_get_current_buf()
        local stack = selections[buf]
        if not stack or not stack[#stack] then return start_selection() end

        local node = stack[#stack]:parent()
        if not node then return end
        stack[#stack + 1] = node
        select_node(node)
      end

      local function shrink_selection()
        local stack = selections[vim.api.nvim_get_current_buf()]
        if not stack or #stack <= 1 then return end
        table.remove(stack)
        select_node(stack[#stack])
      end

      vim.keymap.set("n", "<C-Space>", start_selection, { desc = "Start syntax selection" })
      vim.keymap.set("x", "<C-Space>", expand_selection, { desc = "Expand syntax selection" })
      vim.keymap.set("x", "<BS>", shrink_selection, { desc = "Shrink syntax selection" })

      vim.api.nvim_create_autocmd("BufDelete", {
        group = group,
        callback = function(event) selections[event.buf] = nil end,
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {},
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascriptreact",
      "svelte",
      "typescriptreact",
      "vue",
      "xml",
    },
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter search" },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
    },
    keys = {
      { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "TODO comments" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
    },
  },
}
