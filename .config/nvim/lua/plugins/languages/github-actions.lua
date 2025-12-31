-- GitHub Actions language configuration
--
-- LSP: actions-languageserver
--   Requires: npm install -g @actions/languageserver
--   Provides:
--     - Workflow syntax validation
--     - Autocompletion for actions, inputs, and expressions
--
-- Linter: actionlint (https://github.com/rhysd/actionlint)
--   Provides deeper validation than the LSP:
--     - Type checking for ${{ }} expressions
--     - Validates action inputs/outputs against actual action definitions
--     - Detects deprecated workflow syntax
--     - Shell script validation (shellcheck integration)
--     - Validates matrix configurations
--     - Detects unreachable code in conditionals
--
-- The helper functions are taken from https://github.com/actions/languageservices/tree/main/languageserver#in-neovim

--- Get GitHub token from the `gh` CLI for API access.
--- Requires: gh auth login
---@return string|nil token The GitHub token, or nil if unavailable
local function get_github_token()
    local handle = io.popen("gh auth token 2>/dev/null")
    if not handle then
        return nil
    end
    local token = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return token ~= "" and token or nil
end

--- Parse owner and repo name from a GitHub remote URL.
--- Supports both SSH (git@github.com:owner/repo.git) and HTTPS formats.
---@param url string|nil The git remote URL
---@return string|nil owner
---@return string|nil repo
local function parse_github_remote(url)
    if not url or url == "" then
        return nil
    end

    -- SSH format: git@github.com:owner/repo.git
    local owner, repo = url:match("git@github%.com:([^/]+)/([^/%.]+)")
    if owner and repo then
        return owner, repo:gsub("%.git$", "")
    end

    -- HTTPS format: https://github.com/owner/repo.git
    owner, repo = url:match("github%.com/([^/]+)/([^/%.]+)")
    if owner and repo then
        return owner, repo:gsub("%.git$", "")
    end

    return nil
end

--- Fetch repository metadata from GitHub API via `gh` CLI.
---@param owner string Repository owner
---@param repo string Repository name
---@return {id: number, organizationOwned: boolean}|nil
local function get_repo_info(owner, repo)
    local cmd = string.format(
        "gh repo view %s/%s --json id,owner --template '{{.id}}\t{{.owner.type}}' 2>/dev/null",
        owner,
        repo
    )
    local handle = io.popen(cmd)
    if not handle then
        return nil
    end
    local result = handle:read("*a"):gsub("%s+$", "")
    handle:close()

    local id, owner_type = result:match("^(%d+)\t(.+)$")
    if id then
        return {
            id = tonumber(id),
            organizationOwned = owner_type == "Organization",
        }
    end
    return nil
end

--- Build repository context for the LSP from the current git repository.
--- Returns nil if not in a git repo or if the remote is not GitHub.
---@return table[]|nil repos Array of repository context objects
local function get_repos_config()
    -- Get git repository root
    local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
    if not handle then
        return nil
    end
    local git_root = handle:read("*a"):gsub("%s+", "")
    handle:close()

    if git_root == "" then
        return nil
    end

    -- Get origin remote URL
    handle = io.popen("git remote get-url origin 2>/dev/null")
    if not handle then
        return nil
    end
    local remote_url = handle:read("*a"):gsub("%s+", "")
    handle:close()

    -- Parse GitHub owner/repo from remote
    local owner, name = parse_github_remote(remote_url)
    if not owner or not name then
        return nil
    end

    -- Fetch additional repo info from GitHub API
    local info = get_repo_info(owner, name)

    return {
        {
            id = info and info.id or 0,
            owner = owner,
            name = name,
            organizationOwned = info and info.organizationOwned or false,
            workspaceUri = "file://" .. git_root,
        },
    }
end

---@type LazyPluginSpec[]
return {
    {
        "neovim/nvim-lspconfig",
        opts = function()
            -- Register filetype for GitHub Actions workflow files
            -- This allows separate LSP config from regular YAML files
            vim.filetype.add({
                pattern = {
                    [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghactions",
                },
            })

            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("actions_ls", {
                cmd = { "actions-languageserver", "--stdio" },
                filetypes = { "yaml.ghactions" },
                root_markers = { ".git" },
                capabilities = capabilities,
                init_options = {
                    -- GitHub token enables secrets/variables autocompletion
                    -- Providing the GitHub token allows getting:
                    --   - Repository secrets/variables autocompletion (${{ secrets.* }}, ${{ vars.* }})
                    --   - Validation that referenced actions exist
                    --   - Reusable workflow completions
                    sessionToken = get_github_token(),
                    -- Through the repository context the LSP knows:
                    --   - Which repo to query for secrets/variables
                    --   - Whether it's an org repo (access to org-level secrets)
                    repos = get_repos_config(),
                },
            })
            vim.lsp.enable("actions_ls")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                ["yaml.ghactions"] = { "actionlint" },
            },
        },
    },
}
