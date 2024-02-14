return function(M)
  local function try_devicons()
    if not M._has_devicons then
      M._has_devicons, M._devicons = pcall(require, "nvim-web-devicons")
    end
    return M._devicons
  end

  return function(opts)
    opts = opts or {}

    local el_sub = require("el.subscribe")

    local wrap_fnc = require("utils.wrap_fnc")
    local set_hl = require("utils.set_hl")

    return el_sub.buf_autocmd("el_file_icon", "BufRead",
      wrap_fnc(opts, function(_, buffer)
        if not try_devicons() then return "" end
        local fmt = opts.fmt or "%s"
        local ext = vim.fn.fnamemodify(buffer.name, ":p:e")
        local icon, hl = M._devicons.get_icon(buffer.name, ext:lower(), { default = true })
        if icon then
          if opts.hl_icon then
            local hlgroup = M.extract_hl({
              bg = { StatusLine = "bg" },
              fg = { [hl] = "fg" },
              bold = true,
            })
            icon = set_hl(hlgroup, icon)
          end
          return (fmt):format(icon)
        end
        return ""
      end))
  end
end
