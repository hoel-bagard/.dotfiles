# My Neovim Configuration

It's still very much a work in progress.

## Requirements:

To get the LSP for GitHub Actions:

```bash
sudo npm install -g @actions/languageserver
sudo pacman -S github-cli
```

## Usage

### Remote file editing

Edit files on server [using oil](https://github.com/stevearc/oil.nvim?tab=readme-ov-file#ssh):

```console
nvim oil-ssh://[username@]hostname[:port]/[path]
```

## Plugins

- [mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for LSP servers, formatters, linters, and debuggers.

### AI/Copilot

- [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) - AI chat, mainly used for translations.
- [copilot.lua](https://github.com/zbirenbaum/copilot.lua) - GitHub Copilot, only used for authentication to allow CoplilotChat to function.

### LSP/Completion

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Core LSP configuration with support for multiple language servers (rust-analyzer, pyright, ruff, etc...).
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine with multiple sources including LSP, buffer, path, and snippets.
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine integrated with nvim-cmp.
- [lazydev.nvim](https://github.com/folke/lazydev.nvim) - Faster LuaLS setup for Neovim plugin development.
- [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) - Shows function signatures with parameter hints while typing.
- [fidget.nvim](https://github.com/j-hui/fidget.nvim) - LSP progress indicator.
- [lspkind-nvim](https://github.com/onsails/lspkind-nvim) - Adds pictograms/icons to LSP completion items.

### Formatting/Linting

- [conform.nvim](https://github.com/stevearc/conform.nvim) - Autoformatter with format-on-save for multiple languages (stylua, ruff, rustfmt, prettier, shfmt).
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - Linter plugin complementary to the LSP, provides linting for languages without a LSP (for example jsonlint and hadolint).

### File Navigation/Management

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder for files, buffers, grep, help tags, and more.
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - File explorer with tree view and git integration.
- [oil.nvim](https://github.com/stevearc/oil.nvim) - Edit filesystem like a buffer with direct file/directory manipulation.
- [snacks.nvim](https://github.com/folke/snacks.nvim) - Multi-purpose plugin providing dashboard, picker, notifications, and git integration.

### Git Integration

- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Comprehensive Git integration.
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git decorations showing added, changed, and deleted lines in the gutter.
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Enhanced diff view for reviewing changes and file history.

### UI/Appearance

- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Tokyo Night color scheme (main theme).
- [mini.statusline](https://github.com/echasnovski/mini.statusline) - Simple and fast statusline.
- [noice.nvim](https://github.com/folke/noice.nvim) - Enhanced UI for messages, cmdline, and popupmenu.
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Shows indent guides with rainbow-colored scope highlights.
- [rainbow-delimiters.nvim](https://gitlab.com/HiPhish/rainbow-delimiters.nvim) - Rainbow-colored matching brackets.
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Displays available keybindings in a popup.
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - Notification manager with improved UI.
- [image.nvim](https://github.com/3rd/image.nvim) - Image rendering support in Neo-tree and markdown files.
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlights and searches TODO comments in code.

### Editing/Motions

- [leap.nvim](https://github.com/ggandor/leap.nvim) - Lightning-fast motion plugin for jumping to any location with 2-character search.
  - Forward/backward jumps with `s`/`S`
- [flit.nvim](https://github.com/ggandor/flit.nvim) - Enhanced f/t motions with multiline support built on leap.nvim.
  - For better `f`/`F`/`t`/`T` motions
  - Add "clever repeat": using `f` or `t` repeats the previous `f`/`F` or `t`/`T`.
- [nvim-surround](https://github.com/kylechui/nvim-surround) - Add, delete, and change surrounding characters (quotes, brackets, tags).
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Automatically closes brackets and quotes.
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Smart commenting for multiple languages.
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) - Adjusts comment strings based on treesitter context.
- [mini.ai](https://github.com/echasnovski/mini.ai) - Extended textobjects for better around/inside operations.
- [mini.trailspace](https://github.com/echasnovski/mini.trailspace) - Highlights and trims trailing whitespace.
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - Modern folding engine using treesitter.
- [vim-sleuth](https://github.com/tpope/vim-sleuth) - Automatically detects indentation settings.
- [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) - Automatic indentation style detection.
- [vim-repeat](https://github.com/tpope/vim-repeat) - Enhanced repeat (.) functionality for plugin mappings.

### Language-Specific

- [nvim-java](https://github.com/nvim-java/nvim-java) - Java development support with JDK auto-installation.
- [crates.nvim](https://github.com/saecki/crates.nvim) - Rust dependency management for Cargo.toml.
- [tailwind-tools.nvim](https://github.com/luckasRanarison/tailwind-tools.nvim) - Tailwind CSS support with custom patterns for Rust (Dioxus) and JS/TS.
- [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) - Obsidian note-taking integration with daily notes and templates.
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) - Renders markdown with inline headings and bordered code blocks.
- [uv.nvim](https://github.com/benomahony/uv.nvim) - Python UV package manager integration with virtual environment auto-activation.

### Debugging

- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug Adapter Protocol client with Python debugging support.
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - UI for nvim-dap with automatic session management.
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) - Shows variable values inline during debugging.

### Syntax/Treesitter

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting and code understanding using treesitter parsers.
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Syntax-aware textobjects for functions, classes, and parameters.

### Terminal

- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) - Floating terminal toggled with `<C-\>`.

## To try out

- AI
  - `opencode.nvim` ([reddit post](https://www.reddit.com/r/neovim/comments/1my6vb1/opencodenvim_updates_external_process_support_and/?share_id=EjSmqjXcPkBbXYx9g9CoB&utm_medium=android_app&utm_name=androidcss&utm_source=share&utm_term=10))
- [Trouble](https://github.com/folke/trouble.nvim)
- Rust setup
  - https://github.com/mrcjkb/rustaceanvim
  - https://www.youtube.com/watch?v=mh_EJhH49Ms
- Misc
  - `ctrl + ^` to go back and forth between two files. -> Use harpoon instead.
