--- Runs, tests and debugs through ./gradlew. Gradle is the source of truth for compiling
--- because jdtls does not reliably run Micronaut's annotation processors.
local spock = require("java.spock")

local M = {}

local DEBUG_PORT = 5005
local JAVAC_EFM = table.concat({ "%f:%l: error: %m", "%f:%l: warning: %m", "%f: %l: %m" }, ",")

---@class java.gradle.Last
---@field args string[]
---@field debug boolean
local last ---@type java.gradle.Last?
local job ---@type integer?

local function root()
  return vim.fs.root(0, { "settings.gradle", "settings.gradle.kts", "gradlew" })
end

local stopped = {} ---@type table<integer, true> jobs that were stopped on purpose

local function stop_job()
  if job then
    stopped[job] = true
    pcall(vim.fn.jobstop, job)
    job = nil
  end
end

--- Attaches to the Gradle-launched JVM. nvim-jdtls derives the main class from the current buffer,
--- which is the Gradle output window here, so pass the project's own main class and project name.
local function attach()
  require("jdtls.util").execute_command({ command = "vscode.java.resolveMainClass" }, function(err, mainclasses)
    local main = not err and mainclasses and mainclasses[1] or nil
    vim.schedule(function()
      if not main then
        vim.notify("jdtls did not report a main class; the debugger may fail to attach", vim.log.levels.WARN)
      end
      require("dap").run({
        type = "java",
        request = "attach",
        name = "Gradle debug",
        hostName = "127.0.0.1",
        port = DEBUG_PORT,
        mainClass = main and main.mainClass,
        projectName = main and main.projectName,
      })
    end)
  end)
end

---@param args string[] Gradle arguments
---@param opts? { debug?: boolean }
function M.run(args, opts)
  opts = opts or {}
  local dir = root()
  if not dir then
    return vim.notify("No Gradle root found", vim.log.levels.ERROR)
  end
  stop_job()
  last = { args = args, debug = opts.debug or false }

  local cmd = vim.list_extend({ dir .. "/gradlew", "--console=plain" }, args)
  if opts.debug then
    table.insert(cmd, "--debug-jvm")
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "hide"
  vim.api.nvim_buf_set_name(buf, "gradle://" .. table.concat(args, " ") .. "#" .. buf)
  vim.cmd("botright 15split")
  vim.api.nvim_win_set_buf(0, buf)

  local attached = false
  local function append(_, data)
    if not data or not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
      if not attached and opts.debug then
        for _, line in ipairs(data) do
          if line:find("Listening for transport dt_socket", 1, true) then
            attached = true
            attach()
            break
          end
        end
      end
    end)
  end

  job = vim.fn.jobstart(cmd, {
    cwd = dir,
    on_stdout = append,
    on_stderr = append,
    on_exit = function(id, code)
      if job == id then
        job = nil
      end
      local was_stopped = stopped[id]
      stopped[id] = nil
      vim.schedule(function()
        if was_stopped or not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        vim.fn.setqflist({}, " ", { title = "gradle " .. table.concat(args, " "), lines = lines, efm = JAVAC_EFM })
        if code ~= 0 and #vim.fn.getqflist() > 0 then
          vim.notify("Gradle failed: errors in the quickfix list (:copen)", vim.log.levels.WARN)
        end
      end)
    end,
  })

  -- Terminating the debug session (`<leader>dt`) also stops the Gradle job.
  if opts.debug then
    require("dap").listeners.after.disconnect["java.gradle"] = stop_job
  end
end

function M.debug(args)
  M.run(args, { debug = true })
end

function M.last()
  if not last then
    return vim.notify("No previous Gradle task", vim.log.levels.INFO)
  end
  M.run(last.args, { debug = last.debug })
end

---@param debug boolean
---@param feature boolean
local function test(debug, feature)
  local dir = root()
  if not dir then
    return vim.notify("No Gradle root found", vim.log.levels.ERROR)
  end
  local class = spock.class_name()
  if not class then
    return vim.notify("Cannot resolve the test class", vim.log.levels.ERROR)
  end
  local filter = class
  if feature then
    local name = spock.feature_name()
    if not name then
      return vim.notify("No Spock feature found above the cursor", vim.log.levels.WARN)
    end
    -- The trailing `*` also matches the iterations of an `@Unroll`ed `where:` block.
    filter = class .. "." .. name .. "*"
  end
  -- `--rerun` stops Gradle skipping an up-to-date `test` task, which would start no JVM to run or debug.
  M.run({ spock.project_path(dir) .. ":test", "--rerun", "--tests", filter }, { debug = debug })
end

function M.test_file()
  test(false, false)
end
function M.test_nearest()
  test(false, true)
end
function M.debug_test_file()
  test(true, false)
end
function M.debug_test_nearest()
  test(true, true)
end

function M.test_all()
  local dir = root()
  if dir then
    M.run({ spock.project_path(dir) .. ":test", "--rerun" })
  end
end

function M.open_report()
  local dir = root()
  if dir then
    vim.ui.open(dir .. "/build/reports/tests/test/index.html")
  end
end

return M
