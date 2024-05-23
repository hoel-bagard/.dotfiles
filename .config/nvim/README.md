# My Neovim Configuration

It's still very much a work in progress.

# TODOs

## Leap

Similar to vimium "f", allows to jump anywhere.
<https://github.com/ggandor/leap.nvim>

## Jump keymaps

One of the below
Mini
<https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md>
vim-unimpaired
<https://github.com/tpope/vim-unimpaired>

## DAP

- nvim dap (and nvim-dap-python, nvim-dap-ui)
- https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/debug.lua
- <https://youtu.be/4BnVeOUeZxc?si=p-DH1AQ6IVmyBux8&t=591>
- <https://github.com/tjdevries/config_manager/blob/eb8c846bdd480e6ed8fb87574eac09d31d39befa/xdg_config/nvim/after/plugin/dap.lua>

## Treesitter

- <https://github.com/nvim-treesitter/nvim-treesitter-textobjects>
- The [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) plugin seems pretty useful.

## Reformatting config

- Split mason from lsp

## Trouble

- https://github.com/folke/trouble.nvim

## ToggleTerm

- https://github.com/akinsho/toggleterm.nvim

## Rust settup

- https://github.com/Saecki/crates.nvim
- https://github.com/mrcjkb/rustaceanvim
- https://www.youtube.com/watch?v=mh_EJhH49Ms

## Misc

- How to have <i+o> (inner symbol) ?
- How to have aa_aa not be a single word ?
- How to not have "'" insert two charaters (opening and ending) when typing comments ?
- Show trailing whitespaces
- Have the "help" (shift-K) at the bottom like in spacemacs, when editing the args. And when having cursor on a variable (get type).
- Have the lsp (ruff) show the error code and not just the message (otherwise can't ignore it)
- I have to restart (re-attach ?) the lsp a lot (:e), is there a way to remedy to that ? Also, sometimes the import suddenly don't get resolved anymore. In that case :e doesn't solve it and I have to restart nvim.
