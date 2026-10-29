--- Resolves Gradle test targets for Spock specifications, which jdtls cannot discover.
local M = {}

---@param buf? integer
---@return string? fully qualified class name
function M.class_name(buf)
  buf = buf or 0
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t:r")
  if name == "" then
    return nil
  end
  for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    local pkg = line:match("^%s*package%s+([%w_.]+)")
    if pkg then
      return pkg .. "." .. name
    end
  end
  return name
end

--- Nearest feature method at or above the cursor, e.g. `def "does a thing"()`.
---@return string?
function M.feature_name()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  for lnum = row, 1, -1 do
    local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
    local _, name = line:match("^%s*def%s+([\"'])(.-)%1%s*%(")
    if not name then
      _, name = line:match("^%s*void%s+([\"'])(.-)%1%s*%(")
    end
    if name then
      return name
    end
  end
end

--- Gradle project path (`:a:b`) of the module containing the current file, `""` for the root project.
---@param root string Gradle root directory
---@return string
function M.project_path(root)
  local file = vim.api.nvim_buf_get_name(0)
  local module = vim.fs.root(file, { "build.gradle", "build.gradle.kts" })
  if not module or module == root then
    return ""
  end
  local rel = module:sub(#root + 2)
  return ":" .. rel:gsub("/", ":")
end

return M
