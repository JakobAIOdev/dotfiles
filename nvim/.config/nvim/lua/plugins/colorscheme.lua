return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1001,
    opts = {
      flavour = "mocha",
      background = {
        dark = "mocha",
        light = "latte",
      },
      transparent_background = false,
      dim_inactive = {
        enabled = false,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "italic" },
        functions = { "bold" },
      },
      integrations = {
        blink_cmp = {
          style = "bordered",
        },
        bufferline = true,
        dap = true,
        dap_ui = true,
        gitsigns = true,
        mason = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            information = { "undercurl" },
            warnings = { "undercurl" },
          },
        },
        neotest = true,
        snacks = {
          enabled = true,
          indent_scope_color = "lavender",
        },
        treesitter = true,
        treesitter_context = true,
        trouble = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          CursorLine = { bg = colors.mantle },
          FloatBorder = { fg = colors.surface2, bg = colors.base },
          NormalFloat = { bg = colors.base },
          WinSeparator = { fg = colors.surface0 },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
