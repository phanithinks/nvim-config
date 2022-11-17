local M = {}

function M.setup()
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
        runner = "unittest",
      },
      require "neotest-go",
      require "neotest-plenary",
      require "neotest-jest",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua" },
      },
    },

    icons = {
      child_indent = "│",
      child_prefix = "├",
      collapsed = "─",
      expanded = "╮",
      failed = "✖",
      final_child_indent = " ",
      final_child_prefix = "╰",
      non_collapsible = "─",
      passed = "✔",
      running = "🗘",
      running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
      skipped = "ﰸ",
      unknown = "?"
    },

  }
end

return M
