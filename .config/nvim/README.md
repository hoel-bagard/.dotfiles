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
- Better folds: https://github.com/kevinhwang91/nvim-ufo
- `ctrl + ^` to go back and forth between two files. -> Use harpoon instead.

## Plugins

- [flit.nvim](https://github.com/ggandor/flit.nvim)
  - For better `f`/`F`/`t`/`T` motions.
  - Add "clever repeat": using `f` or `t` repeats the previous `f`/`F` or `t`/`T`.
  - Make the motions multiline.
- [leap.nvim](https://github.com/ggandor/leap.nvim)
  - Forward/backward jumps with `s`/`S`.
- [nvim-surround](https://github.com/kylechui/nvim-surround)
