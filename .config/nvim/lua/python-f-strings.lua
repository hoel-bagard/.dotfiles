-- Auto f-string insertion for Python
-- When typing {} inside a string, automatically adds 'f' prefix
-- When removing all {} from an f-string, automatically removes 'f' prefix
-- Based on: https://github.com/joshzcold/python.nvim/commit/125ff9466f43c86813b8136c03e24fa060567d17

local M = {}

M.config = {
    events = { "InsertLeave", "TextChanged" },
}

---Get node at cursor (requires nvim 0.9+)
---@return TSNode|nil
local function getNodeAtCursor()
    if vim.treesitter.get_node == nil then
        vim.notify("python-f-strings requires at least nvim 0.9.", vim.log.levels.WARN)
        return nil
    end
    return vim.treesitter.get_node()
end

---@param node TSNode
---@return string
local function getNodeText(node)
    return vim.treesitter.get_node_text(node, 0)
end

---@param node TSNode
---@param replacementText string
local function replaceNodeText(node, replacementText)
    local startRow, startCol, endRow, endCol = node:range()
    local lines = vim.split(replacementText, "\n")
    pcall(vim.cmd.undojoin) -- make undos ignore the next change
    vim.api.nvim_buf_set_text(0, startRow, startCol, endRow, endCol, lines)
end

---Find the parent string node from a given node
---@param node TSNode
---@return TSNode|nil
local function findStringNode(node)
    local nodeType = node:type()
    if nodeType == "string" then
        return node
    elseif nodeType:find("^string_") then
        return node:parent()
    elseif nodeType == "escape_sequence" then
        return node:parent():parent()
    end
    return nil
end

---Transform string to/from f-string based on brace content
local function pythonFStr()
    local node = getNodeAtCursor()
    if not node then
        return
    end

    local strNode = findStringNode(node)
    if not strNode then
        return
    end

    local text = getNodeText(strNode)
    if text == "" or #text > 200 then -- Don't convert empty strings (user might want to enter something) or likely invalid code.
        return
    end

    local isFString = text:find("^r?f") -- rf -> raw-formatted-string
    local hasBraces = text:find("{.-[^%d,%s].-}")

    if not isFString and hasBraces then
        replaceNodeText(strNode, "f" .. text)
    elseif isFString and not hasBraces then
        replaceNodeText(strNode, text:sub(2))
    end
end

---Setup auto f-string insertion for Python files
---@param opts? { events?: string[] }
function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    local group = vim.api.nvim_create_augroup("PythonFStrings", { clear = true })
    vim.api.nvim_create_autocmd(M.config.events, {
        group = group,
        desc = "Auto f-string insertion for Python",
        callback = function(ctx)
            if vim.bo[ctx.buf].filetype ~= "python" then
                return
            end
            vim.defer_fn(pythonFStr, 1)
        end,
    })
end

return M
