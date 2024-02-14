return function(opts)
  local set_hl = require("utils.set_hl")
  local specs = {
    change = {
      regex = "(%d+) files? changed",
      icon  = opts.icon_change or "~",
      hl    = opts.hl_change,
    },
    delete = {
      regex = "(%d+) deletions?",
      icon  = opts.icon_delete or "-",
      hl    = opts.hl_delete,
    },
    insert = {
      regex = "(%d+) insertions?",
      icon  = opts.icon_insert or "+",
      hl    = opts.hl_insert,
    },
  }
  return function(_, _, s)
    local result = {}
    for k, v in pairs(specs) do
      local count = nil
      if type(s) == "string" then
        count = tonumber(string.match(s, v.regex))
      else
        count = s[k]
      end
      if count and count > 0 then
        table.insert(result, set_hl(v.hl, ("%s%d"):format(v.icon, count)))
      end
    end
    return table.concat(result, " ")
  end
end
