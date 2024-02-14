return function(opts)
  local wrap_fnc = require("utils.wrap_fnc")
  local set_hl = require("utils.set_hl")
  opts = opts or {}
  return wrap_fnc(opts, function(_, _)
    local fmt = opts.fmt or "%s%s"
    local mode = vim.api.nvim_get_mode().mode
    local mode_data = opts.modes and opts.modes[mode]
    local hls = mode_data and mode_data[3]
    local icon = opts.hl_icon_only and set_hl(hls, opts.icon) or opts.icon
    mode = mode_data and mode_data[1]:upper() or mode
    mode = (fmt):format(icon or "", mode)
    return not opts.hl_icon_only and set_hl(hls, mode) or mode
  end)
end
