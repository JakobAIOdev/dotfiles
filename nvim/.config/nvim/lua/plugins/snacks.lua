local function with_lazygit(action)
  return function()
    if vim.fn.executable("lazygit") == 0 then
      Snacks.notify.warn("Lazygit fehlt noch. Installiere es mit: brew install lazygit")
      return
    end
    action()
  end
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        width = 48,
        pane_gap = 8,
        preset = {
          header = table.concat({
            "     ██╗ █████╗ ██╗  ██╗ ██████╗ ██████╗ ",
            "     ██║██╔══██╗██║ ██╔╝██╔═══██╗██╔══██╗",
            "     ██║███████║█████╔╝ ██║   ██║██████╔╝",
            "██   ██║██╔══██║██╔═██╗ ██║   ██║██╔══██╗",
            "╚█████╔╝██║  ██║██║  ██╗╚██████╔╝██████╔╝",
            " ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ",
            "",
            "────────  N E O V I M  •  F O C U S  ────────",
          }, "\n"),
          keys = {
            { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "g", desc = "Search text", action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
            { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
            { icon = " ", key = "s", desc = "Restore session", section = "session" },
            { icon = " ", key = "n", desc = "New buffer", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "c",
              desc = "Edit config",
              action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
            },
            { icon = "󰒲 ", key = "l", desc = "Plugin manager", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        formats = {
          key = function(item)
            return {
              { "  ", hl = "SnacksDashboardNormal" },
              { item.key, hl = "SnacksDashboardKey" },
              { "  ", hl = "SnacksDashboardNormal" },
            }
          end,
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "QUICK ACCESS", section = "keys", gap = 0, padding = 1 },
          { section = "startup", padding = 1 },
          {
            pane = 2,
            text = {
              { "󰉋  ", hl = "SnacksDashboardIcon" },
              { "WORKSPACE", hl = "SnacksDashboardTitle" },
              { "  " .. vim.fn.fnamemodify(vim.uv.cwd(), ":~"), hl = "SnacksDashboardDesc" },
            },
            padding = 1,
            enabled = function() return vim.o.columns >= 120 end,
          },
          {
            pane = 2,
            icon = " ",
            title = "RECENT FILES",
            section = "recent_files",
            limit = 8,
            indent = 2,
            padding = 1,
            enabled = function() return vim.o.columns >= 120 end,
          },
          {
            pane = 2,
            icon = " ",
            title = "PROJECTS",
            section = "projects",
            limit = 5,
            indent = 2,
            padding = 1,
            enabled = function() return vim.o.columns >= 120 end,
          },
          {
            pane = 2,
            icon = " ",
            title = "GIT STATUS",
            section = "terminal",
            cmd = "git status --short --branch --renames",
            height = 6,
            ttl = 300,
            indent = 2,
            padding = 1,
            enabled = function() return vim.o.columns >= 120 and Snacks.git.get_root() ~= nil end,
          },
        },
      },
      explorer = { enabled = true },
      indent = {
        enabled = true,
        indent = { char = "│" },
        scope = { char = "│" },
      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 2500,
      },
      picker = {
        enabled = true,
        ui_select = true,
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
          },
        },
      },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
    },
    keys = {
      -- Find
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep project" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep project" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config files" },
      { "<leader>fw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Word or selection" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Help pages" },
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>fu", function() Snacks.picker.undo() end, desc = "Undo history" },
      { "<leader>fR", function() Snacks.picker.registers() end, desc = "Registers" },
      { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },

      -- Explorer, buffers and terminal
      { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
      { "<C-\\>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
      { "<leader>ot", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Floating terminal" },

      -- UI
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
      { "<leader>uh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
      { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
      { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom window" },
      { "<leader>.", function() Snacks.scratch() end, desc = "Scratch buffer" },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select scratch buffer" },

      -- Git helpers
      { "<leader>gg", with_lazygit(function() Snacks.lazygit() end), desc = "Lazygit" },
      { "<leader>gl", with_lazygit(function() Snacks.lazygit.log() end), desc = "Git log" },
      { "<leader>gL", with_lazygit(function() Snacks.lazygit.log_file() end), desc = "File history" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Blame line" },
      { "<leader>go", function() Snacks.gitbrowse() end, mode = { "n", "x" }, desc = "Open in browser" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
      { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git commits" },

      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Previous reference" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
          vim.print = _G.dd
        end,
      })
    end,
  },
}
