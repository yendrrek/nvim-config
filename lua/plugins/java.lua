-- Extends the lang.java extra. jdtls runs on the system JDK, independent of SDKMAN.
local jdk_home = "/usr/lib/jvm/java-25-openjdk"

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- No Lombok in the project: start jdtls without the agent the extra adds.
      opts.cmd = { vim.fn.exepath("jdtls"), "--jvm-arg=-Xmx2g", "--jvm-arg=-XX:+UseParallelGC" }

      -- In a multi-module build, resolve to the directory holding settings.gradle.
      local default_root = opts.root_dir
      opts.root_dir = function(path)
        return vim.fs.root(path, { "settings.gradle", "settings.gradle.kts" }) or default_root(path)
      end

      opts.jdtls = vim.tbl_deep_extend("force", opts.jdtls or {}, {
        cmd_env = { JAVA_HOME = jdk_home, PATH = jdk_home .. "/bin:" .. vim.env.PATH },
      })

      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          home = jdk_home,
          configuration = {
            updateBuildConfiguration = "automatic",
            runtimes = { { name = "JavaSE-25", path = jdk_home, default = true } },
          },
          import = {
            gradle = {
              enabled = true,
              wrapper = { enabled = true },
              java = { home = jdk_home },
              annotationProcessing = { enabled = true },
            },
          },
          eclipse = { downloadSources = true },
          contentProvider = { preferred = "fernflower" },
          referencesCodeLens = { enabled = true },
          implementationsCodeLens = { enabled = true },
          signatureHelp = { enabled = true },
          inlayHints = { parameterNames = { enabled = "literals" } },
          saveActions = { organizeImports = false },
          sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
          completion = {
            favoriteStaticMembers = {
              "org.mockito.Mockito.*",
              "org.mockito.ArgumentMatchers.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
            },
            importOrder = { "java", "javax", "jakarta", "io.micronaut", "org", "com" },
          },
          -- Spotless owns Java formatting.
          format = { enabled = false },
        },
      })
    end,
  },

  -- Code lenses (reference counts, "Run test") are off by default in LazyVim.
  {
    "neovim/nvim-lspconfig",
    opts = { codelens = { enabled = true } },
  },
}
