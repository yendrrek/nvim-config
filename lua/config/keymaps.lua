-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Gradle (<leader>j) and Spock/Gradle tests (<leader>t). See lua/java/gradle.lua.
local function gradle(fn, ...)
  local args = { ... }
  return function()
    require("java.gradle")[fn](unpack(args))
  end
end
local function run(...)
  return gradle("run", { ... })
end

require("which-key").add({ { "<leader>j", group = "gradle" } })

local map = vim.keymap.set
map("n", "<leader>jb", run("build"), { desc = "Build" })
map("n", "<leader>jc", run("compileJava", "compileTestGroovy"), { desc = "Compile (fast check)" })
map("n", "<leader>jr", run("run"), { desc = "Run" })
map("n", "<leader>jt", run("-t", "run"), { desc = "Run (continuous)" })
map("n", "<leader>jd", gradle("debug", { "run" }), { desc = "Run with debugger" })
map("n", "<leader>jn", run("nativeCompile"), { desc = "Native compile" })
map("n", "<leader>js", run("spotlessApply"), { desc = "Spotless apply" })
map("n", "<leader>jp", run("dependencies"), { desc = "Dependencies" })
map("n", "<leader>jl", gradle("last"), { desc = "Re-run last task" })
map("n", "<leader>jk", "<cmd>OverseerRun<cr>", { desc = "Pick task" })

map("n", "<leader>tf", gradle("test_file"), { desc = "Test file (Gradle)" })
map("n", "<leader>tn", gradle("test_nearest"), { desc = "Test nearest (Gradle)" })
map("n", "<leader>tF", gradle("debug_test_file"), { desc = "Debug test file (Gradle)" })
map("n", "<leader>tN", gradle("debug_test_nearest"), { desc = "Debug nearest test (Gradle)" })
map("n", "<leader>ta", gradle("test_all"), { desc = "Test module (Gradle)" })
map("n", "<leader>tl", gradle("last"), { desc = "Re-run last (Gradle)" })
map("n", "<leader>to", gradle("open_report"), { desc = "Open test report" })
