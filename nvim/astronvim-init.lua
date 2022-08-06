local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  colorscheme = "gruvbox",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides
    --   Normal = { bg = "#000000" },
    -- },
    default_theme = function(highlights) -- or a function that returns one
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      guifont = {
        "FiraCode Nerd Font",
        ":h11",
      },
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      neovide_cursor_vfx_mode = "railgun",
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      { "phaazon/hop.nvim" },
      { "indianboy42/hop-extensions" },
      { "ellisonleao/gruvbox.nvim" },
      {
        "mhartington/formatter.nvim",
        config = function()
          local util = require "formatter.util"

          -- Provides the Format and FormatWrite commands
          require("formatter").setup {
            -- Enable or disable logging
            logging = true,
            -- Set the log level
            log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = {
              -- Formatter configurations for filetype "lua" go here
              -- and will be executed in order
              lua = {
                -- "formatter.filetypes.lua" defines default configurations for the
                -- "lua" filetype
                require("formatter.filetypes.lua").stylua,

                -- You can also define your own configuration
                function()
                  -- Supports conditional formatting
                  if util.get_current_buffer_file_name() == "special.lua" then return nil end

                  -- Full specification of configurations is down below and in Vim help
                  -- files
                  return {
                    exe = "stylua",
                    args = {
                      "--search-parent-directories",
                      "--stdin-filepath",
                      util.escape_path(util.get_current_buffer_file_path()),
                      "--",
                      "-",
                    },
                    stdin = true,
                  }
                end,
              },
              typescript = {
                require("formatter.filetypes.typescript").prettier,
              },
              javascript = {
                require("formatter.filetypes.javascript").prettier,
              },
              json = {
                
              },

              -- Use the special "*" filetype for defining formatter configurations on
              -- any filetype
              ["*"] = {
                -- "formatter.filetypes.any" defines default configurations for any
                -- filetype
                require("formatter.filetypes.any").remove_trailing_whitespace,
              },
            },
          }
        end,
      },
      {
        "MunifTanjim/prettier.nvim",
        config = function()
          require("prettier").setup {
            bin = "prettier", -- or `prettierd`
            filetypes = {
              "css",
              "graphql",
              "html",
              "javascript",
              "javascriptreact",
              "json",
              "less",
              "markdown",
              "scss",
              "typescript",
              "typescriptreact",
              "yaml",
            },

            -- prettier format options (you can use config files too. ex: `.prettierrc`)
            arrow_parens = "always",
            bracket_spacing = true,
            embedded_language_formatting = "auto",
            end_of_line = "lf",
            html_whitespace_sensitivity = "css",
            jsx_bracket_same_line = false,
            jsx_single_quote = false,
            print_width = 80,
            prose_wrap = "preserve",
            quote_props = "as-needed",
            semi = true,
            single_quote = false,
            tab_width = 2,
            trailing_comma = "es5",
            use_tabs = false,
            vue_indent_script_and_style = false,
          }
        end,
      },
      {
        "simrat39/rust-tools.nvim",
        config = function()
          require("rust-tools").setup {}
          -- os.exit(1);
        end,
      },

      {
        "Pocco81/AutoSave.nvim",
        on_off_commands = true,
        config = function()
          local autosave = require("autosave").setup {
            enabled = true,
            execution_message = function() return "AutoSave: saved at " .. vim.fn.strftime "%H:%M:%S" end,
            -- execution_message = "Saved",
            events = { "InsertLeave", "TextChanged" },
            conditions = {
              exists = true,
              filename_is_not = {},
              filetype_is_not = {},
              modifiable = true,
            },
            write_all_buffers = false,
            on_off_commands = false,
            clean_command_line_interval = 0,
            debounce_delay = 135,
          }
        end,
      },
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.rufo,
        -- Set a linter
        null_ls.builtins.diagnostics.rubocop,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = { "lua" },
    },
    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- which-key registration table for normal mode, leader prefix
          -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
        },
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without lsp-installer
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
      ["x"] = { '"_x' },
      ["X"] = { '"_X' },
      ["d"] = { '"_d' },
      ["D"] = { '"_D' },
      ["c"] = { '"_c' },
      ["C"] = { '"_C' },
      ["<C-d>"] = { '"+d' },
      ["cw"] = { "caw" },
      ["dw"] = { "daw" },
      -- ["<C-D>"] = {"\"+D"},
      ["<C-q>"] = { ":bd\n" }
      -- ["-"] = {"\"+d"},
    },
    v = {
      
      ["d"] = { '"_d' },
      ["<C-d>"] = { '"+d' },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }

    vim.api.nvim_command "set clipboard^=unnamed"
  end,
}

require("rust-tools").setup {}
-- vim.api.cmd("ASToggle")
return config
