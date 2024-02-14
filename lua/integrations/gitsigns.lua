return function(opts)
  opts = opts or {}

  local git_changes_formatter = require("utils.git_changes_formatter")
  local wrap_fnc = require("utils.wrap_fnc")

  local formatter = opts.formatter or git_changes_formatter(opts)

  return wrap_fnc(opts, function(window, buffer)

    local stats = {}

    if buffer and buffer.bufnr > 0 then
      local ok, res = pcall(vim.api.nvim_buf_get_var,
        buffer.bufnr, "vgit_status")
      if ok then stats = res end
    end

    if buffer and buffer.bufnr > 0 then
      local ok, res = pcall(vim.api.nvim_buf_get_var,
        buffer.bufnr, "gitsigns_status_dict")
      if ok then stats = res end
    end

    local counts = {
      insert = stats.added > 0 and stats.added or nil,
      change = stats.changed > 0 and stats.changed or nil,
      delete = stats.removed > 0 and stats.removed or nil,
    }

    if not vim.tbl_isempty(counts) then
      local fmt = opts.fmt or "%s"
      local out = formatter(window, buffer, counts)
      return out and fmt:format(out) or nil
    else
      return ""
    end
  end)
end
