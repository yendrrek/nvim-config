local overseer = require("overseer")

local ROOT_MARKERS = { "settings.gradle", "settings.gradle.kts", "gradlew" }

--- Task names from `gradlew tasks --all --console=plain`, e.g. `bootRun - Runs the app.`
---@param stdout string
---@return table<string, string> task name to description
local function parse_tasks(stdout)
  local tasks = {}
  for line in stdout:gmatch("[^\r\n]+") do
    local name, desc = line:match("^([%w_.:-]+) %- (.+)$")
    if not name then
      name = line:match("^([%w_.:-]+)$")
    end
    if name and not name:match("^%-") and name ~= "Tasks" then
      tasks[name] = desc or ""
    end
  end
  return tasks
end

---@type overseer.TemplateFileProvider
return {
  cache_key = function(opts)
    return vim.fs.root(opts.dir, ROOT_MARKERS)
  end,
  condition = {
    callback = function(opts)
      if not vim.fs.root(opts.dir, ROOT_MARKERS) then
        return false, "No Gradle project found"
      end
      return true
    end,
  },
  generator = function(opts, cb)
    local root = vim.fs.root(opts.dir, ROOT_MARKERS)
    if not root then
      return "No Gradle project found"
    end
    overseer.builtin.system(
      { root .. "/gradlew", "tasks", "--all", "--console=plain", "-q" },
      { cwd = root, text = true },
      vim.schedule_wrap(function(out)
        if out.code ~= 0 then
          cb(out.stderr ~= "" and out.stderr or "gradlew tasks failed")
          return
        end
        local ret = {}
        for name, desc in pairs(parse_tasks(out.stdout)) do
          table.insert(ret, {
            name = "gradle " .. name,
            desc = desc,
            builder = function()
              return { cmd = { root .. "/gradlew", "--console=plain", name }, cwd = root }
            end,
          })
        end
        cb(ret)
      end)
    )
  end,
}
