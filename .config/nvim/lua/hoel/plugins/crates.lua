-- wip, see https://github.com/Saecki/crates.nvim/wiki/Documentation-v0.5.0
return {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = function()
        require("crates").setup()
    end,
}
