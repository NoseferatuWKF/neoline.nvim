return function(opts)
  opts = opts or {}
  local wrap_fnc = require("utils.wrap_fnc")
  local set_hl = require("utils.set_hl")
  local extract_hl = require("utils.extract_hl")
  return wrap_fnc(opts, function(_, _)
    local fmt = opts.fmt or "%s:%s"
    local hls = opts.modes and opts.modes[vim.api.nvim_get_mode().mode][3]
    hls = vim.api.nvim_get_hl(0, {name = hls[1]})
    hls.underline = true
    hls = extract_hl(hls);
    return (fmt):format(set_hl(hls, opts.ln), opts.col)
  end)
end
