return function(opts)
  return function(_, buffer, counts)
    local set_hl = require("utils.set_hl")

    local items = {}

    local icons = {
      ["errors"]   = { opts.icon_err or "E", opts.hl_err },
      ["warnings"] = { opts.icon_warn or "W", opts.hl_warn },
      ["infos"]    = { opts.icon_info or "I", opts.hl_info },
      ["hints"]    = { opts.icon_hint or "H", opts.hl_hint },
    }
    for _, k in ipairs({ "errors", "warnings", "infos", "hints" }) do
      if counts[k] > 0 then
        table.insert(items,
          set_hl(icons[k][2], ("%s:%s"):format(icons[k][1], counts[k])))
      end
    end
    local fmt = opts.fmt or "%s"
    if vim.tbl_isempty(items) then
      return ""
    else
      local contents = ("%s"):format(table.concat(items, " "))
      return #table.concat(items) > 0 and fmt:format(contents) or ""
    end
  end
end
