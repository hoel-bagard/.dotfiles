-- LSP Configuration
---@type LazyPluginSpec
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        -- Useful status updates for LSP.
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end
                --  To jump back, press <C-t>.
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under the cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the type of the word under the cursor.
                --  Useful when you"re not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                -- Fuzzy find all the symbols in the current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Rename the variable under the cursor.
                --  Most Language Servers support renaming across files, etc.
                map("<leader>r", vim.lsp.buf.rename, "[R]ename")

                -- Execute a code action, usually the cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                -- For example to activate the "auto-complete" import on a function/class that was typed manually.
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                -- Opens a popup that displays documentation about the word under the cursor
                map("K", vim.lsp.buf.hover, "Hover Documentation")

                -- This is not Goto Definition, this is Goto Declaration. For example, in C this would take you to the header.
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- The following two autocommands are used to highlight references of the
                -- word under the cursor when the cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When the cursor moves, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        local servers = {
            -- Use pyright from path, since there are a lot of differences between pyright versions.
            pyright = {},
            ruff = {},
            clangd = {},
            ts_ls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        diagnostics = {
                            globals = { "vim" },
                            -- disable = { 'missing-fields' }
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            },
            graphql = {},
            typos_lsp = {
                capabilities = capabilities,
                init_options = {
                    diagnosticSeverity = "hint",
                    config = vim.env.XDG_CONFIG_HOME .. "/nvim/spell/typos.toml",
                },
            },
        }

        require("lspconfig").rust_analyzer.setup({
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = {
                            "--",
                            "--no-deps",
                            "-Wclippy::pedantic",
                            "-Wclippy::nursery",
                            -- "-Wclippy::unwrap_used",
                            -- "-Wclippy::expect_used",
                            "-Adead_code",
                        },
                    },
                    diagnostics = {
                        disabled = { "inactive-code" },
                    },
                    cargo = {
                        allFeatures = true,
                    },
                },
            },
        })

        local pyright = {}
        pyright.capabilities = vim.tbl_deep_extend("force", {}, capabilities, pyright.capabilities or {})
        require("lspconfig").pyright.setup(pyright)

        local ruff = {}
        ruff.capabilities = vim.tbl_deep_extend("force", {}, capabilities, ruff.capabilities or {})
        require("lspconfig").ruff.setup(ruff)

        vim.lsp.enable("nushell")

        require("lspconfig").tailwindcss.setup({
            capabilities = capabilities,
            filetypes = { "html", "css", "javascript", "typescript", "rust" },
            root_dir = require("lspconfig").util.root_pattern("tailwind.css"),
            init_options = {
                userLanguages = {
                    rust = "html",
                },
            },
            settings = {
                tailwindCSS = {
                    includeLanguages = {
                        rust = "html",
                    },
                    experimental = {
                        classRegex = {
                            [[class:\s*"([^"]*)"]],
                            [[class:\s*'([^']*)']],
                            [[class\s*=\s*"([^"]*)"]],
                            [[class\s*=\s*'([^']*)']],
                        },
                    },
                },
            },
        })

        require("lspconfig").just.setup({})

        require("lspconfig.configs").ty = {
            default_config = {
                cmd = { "ty", "server" },
                filetypes = { "python" },
                root_dir = function(fname)
                    return require("lspconfig").util.root_pattern(
                        "ty.toml",
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        ".git"
                    )(fname)
                end,
            },
        }

        -- require("java").setup()
        require("lspconfig").jdtls.setup({})

        -- Ensure the servers and tools above are installed
        require("mason").setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua", -- Used to format Lua code
            "hadolint",
            "jsonlint",
            -- "markdownlint",
            "prettier", -- Used to format markdown amongst other things.
            "google-java-format",
            "taplo", -- toml formatter
            "yamlfmt",
            "bash-language-server",
            "shellcheck", -- bash linter
            "typos-lsp",
            "rustywind",
            "graphql-language-service-cli",
            -- Use Omnisharp (and not csharp-language-server or roslyn) because it can be installed using Mason. Also, no setup needed.
            "omnisharp", -- C# LSP
            "tailwindcss-language-server",
            -- "just-lsp",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {}, -- tools are installed with mason-tool-installer.
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for ts_ls)
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
