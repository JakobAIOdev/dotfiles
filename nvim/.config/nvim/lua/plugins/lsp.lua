local servers = {
  bashls = {},
  cssls = {},
  dockerls = {},
  emmet_ls = {
    filetypes = {
      "css",
      "html",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "svelte",
      "typescriptreact",
      "vue",
    },
  },
  eslint = {},
  gopls = {
    settings = {
      gopls = {
        analyses = {
          nilness = true,
          shadow = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        completeUnimported = true,
        gofumpt = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        staticcheck = true,
        usePlaceholders = true,
      },
    },
  },
  html = {},
  intelephense = {},
  jsonls = {},
  kotlin_language_server = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { globals = { "Snacks", "vim" } },
        hint = { enable = true },
        runtime = { version = "LuaJIT" },
        telemetry = { enable = false },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            "${3rd}/luv/library",
          },
        },
      },
    },
  },
  marksman = {},
  omnisharp = {
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          diagnosticMode = "openFilesOnly",
          typeCheckingMode = "basic",
        },
      },
    },
  },
  ruff = {},
  ruby_lsp = {},
  sqlls = {},
  tailwindcss = {},
  ts_ls = {
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts = {
          ui = {
            border = "rounded",
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "○",
            },
          },
        },
      },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = vim.tbl_keys(servers),
          automatic_enable = vim.tbl_keys(servers),
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git" },
      })

      for name, config in pairs(servers) do
        vim.lsp.config(name, config)
      end

      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        },
        virtual_text = {
          spacing = 2,
          source = "if_many",
          prefix = "●",
        },
        float = {
          border = "rounded",
          source = true,
          header = "",
          prefix = "",
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("jakob_lsp_attach", { clear = true }),
        callback = function(event)
          local function map(lhs, rhs, desc, mode)
            vim.keymap.set(mode or "n", lhs, rhs, {
              buffer = event.buf,
              desc = "LSP: " .. desc,
              silent = true,
            })
          end

          map("gd", function() Snacks.picker.lsp_definitions() end, "Definitions")
          map("gD", vim.lsp.buf.declaration, "Declaration")
          map("gr", function() Snacks.picker.lsp_references() end, "References")
          map("gI", function() Snacks.picker.lsp_implementations() end, "Implementations")
          map("gy", function() Snacks.picker.lsp_type_definitions() end, "Type definitions")
          map("K", vim.lsp.buf.hover, "Hover")
          map("gK", vim.lsp.buf.signature_help, "Signature help")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("<leader>cl", vim.lsp.codelens.run, "Run code lens")
          map("<leader>cL", vim.lsp.codelens.refresh, "Refresh code lens")
          map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "Document symbols")
          map("<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace symbols")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            map("<leader>uh", function()
              local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
            end, "Toggle inlay hints")
          end
        end,
      })
    end,
    keys = {
      { "gl", vim.diagnostic.open_float, desc = "Line diagnostics" },
      { "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous diagnostic" },
      { "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next diagnostic" },
      {
        "[e",
        function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true }) end,
        desc = "Previous error",
      },
      {
        "]e",
        function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true }) end,
        desc = "Next error",
      },
      {
        "<leader>uv",
        function()
          local config = vim.diagnostic.config()
          vim.diagnostic.config({ virtual_text = not config.virtual_text })
        end,
        desc = "Toggle diagnostic text",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "x" },
        desc = "Format",
      },
    },
    opts = {
      default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 1000,
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return {
          lsp_format = "fallback",
          timeout_ms = 1000,
        }
      end,
      formatters_by_ft = {
        bash = { "shfmt" },
        css = { "prettierd", "prettier", stop_after_first = true },
        go = { "goimports", "gofumpt" },
        html = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        python = { "ruff_fix", "ruff_format" },
        scss = { "prettierd", "prettier", stop_after_first = true },
        sh = { "shfmt" },
        svelte = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        bang = true,
        desc = "Disable autoformat (use ! for current buffer)",
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Enable autoformat",
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "goimports",
        "gofumpt",
        "prettierd",
        "ruff",
        "shfmt",
        "stylua",
      },
      run_on_start = true,
      start_delay = 1000,
      debounce_hours = 24,
    },
  },
}
