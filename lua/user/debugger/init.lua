local M = {}

local function configure()
	local dap_install = require("dap-install")
	dap_install.setup({
		installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
	})

	local dap_breakpoint = {
		error = {
			text = "🟥",
			texthl = "LspDiagnosticsSignError",
			linehl = "",
			numhl = "",
		},
		rejected = {
			text = "",
			texthl = "LspDiagnosticsSignHint",
			linehl = "",
			numhl = "",
		},
		stopped = {
			text = "⭐️",
			texthl = "LspDiagnosticsSignInformation",
			linehl = "DiagnosticUnderlineInfo",
			numhl = "LspDiagnosticsSignInformation",
		},
	}

	vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
	vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
	vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
	require("nvim-dap-virtual-text").setup({
		commented = true,
	})

	local dap, dapui = require("dap"), require("dapui")
	dapui.setup({}) -- use default
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

local function configure_debuggers()
	require("user.debugger.lua").setup()
	require("user.debugger.python").setup()
	--[[ require("user.debugger.rust").setup() ]]
	require("user.debugger.go").setup()
	require("user.debugger.vscode").setup()
end

function M.setup()
	configure() -- Configuration
	configure_exts() -- Extensions
	configure_debuggers() -- Debugger
	require("user.debugger.keymaps").setup(); -- Keymaps
  local adapters = {};
  adapters['pwa-node'] = {'javascript'};
  require("dap.ext.vscode").load_launchjs(nil, adapters);
end

return M
