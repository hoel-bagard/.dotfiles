# My Neovim Configuration

It's still very much a work in progress.

## Usage

### Remote file editing

Edit files on server [using oil](https://github.com/stevearc/oil.nvim?tab=readme-ov-file#ssh):

```console
nvim oil-ssh://[username@]hostname[:port]/[path]
```

## Plugins

- [flit.nvim](https://github.com/ggandor/flit.nvim)
  - For better `f`/`F`/`t`/`T` motions.
  - Add "clever repeat": using `f` or `t` repeats the previous `f`/`F` or `t`/`T`.
  - Make the motions multiline.
- [leap.nvim](https://github.com/ggandor/leap.nvim)
  - Forward/backward jumps with `s`/`S`.
- [nvim-surround](https://github.com/kylechui/nvim-surround)
- [guess-indent](#https://github.com/NMAC427/guess-indent.nvim)
  - Automatic indentation style detection for Neovim

## To try out

- AI
  - `opencode.nvim` ([reddit post](https://www.reddit.com/r/neovim/comments/1my6vb1/opencodenvim_updates_external_process_support_and/?share_id=EjSmqjXcPkBbXYx9g9CoB&utm_medium=android_app&utm_name=androidcss&utm_source=share&utm_term=10))
- [Trouble](https://github.com/folke/trouble.nvim)
- Rust setup
  - https://github.com/mrcjkb/rustaceanvim
  - https://www.youtube.com/watch?v=mh_EJhH49Ms
- Misc
  - `ctrl + ^` to go back and forth between two files. -> Use harpoon instead.
