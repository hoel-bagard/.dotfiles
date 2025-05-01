# My Neovim Configuration

It's still very much a work in progress.

## Usage

### Remote file editing

Edit files on server [using oil](https://github.com/stevearc/oil.nvim?tab=readme-ov-file#ssh):

```console
nvim oil-ssh://[username@]hostname[:port]/[path]
```

# TODOs

## DAP

- nvim dap (and nvim-dap-python, nvim-dap-ui)
- https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/debug.lua
- <https://youtu.be/4BnVeOUeZxc?si=p-DH1AQ6IVmyBux8&t=591>
- <https://github.com/tjdevries/config_manager/blob/eb8c846bdd480e6ed8fb87574eac09d31d39befa/xdg_config/nvim/after/plugin/dap.lua>

## Trouble

- https://github.com/folke/trouble.nvim

## Rust setup

- https://github.com/mrcjkb/rustaceanvim
- https://www.youtube.com/watch?v=mh_EJhH49Ms

## Misc

- How to have <i+o> (inner symbol) ?
- How to not have "'" insert two characters (opening and ending) when typing comments ?
- Have the "help" (shift-K) at the bottom like in spacemacs, when editing the args. And when having cursor on a variable (get type).
  - https://www.reddit.com/r/neovim/comments/uwycp6/first_neovim_plugin_show_go_signatures_in_echo/
  - https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
    - Tried it, quite bad
  - https://github.com/ray-x/lsp_signature.nvim
    - Not ideal, but better than nothing at all ?
  - Or switch to coc ?
    - Worth it even with the new nvim version ?
  - Try noice: https://github.com/folke/noice.nvim signature help
- Better folds: https://github.com/kevinhwang91/nvim-ufo
