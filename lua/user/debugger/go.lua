local M = {}

function M.setup()
  require("dap-go").setup({
    external_config = {
      enabled = true
    }
  })
end

return M
