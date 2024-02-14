return function(opts)
  opts = opts or {}

  local el_sub = require("el.subscribe")
  local wrap_fnc = require("utils.wrap_fnc")
  local diag_formatter = require("utils.diag_formatter")
  local get_buffer_counts = require("utils.get_buffer_counts")
  local formatter = opts.formatter or diag_formatter(opts)

  return el_sub.buf_autocmd("el_buf_diagnostic", "LspAttach,DiagnosticChanged",
    wrap_fnc(opts, function(window, buffer)
      return formatter(window, buffer, get_buffer_counts(vim.diagnostic, window, buffer))
    end))
end
