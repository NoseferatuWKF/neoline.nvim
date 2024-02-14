return function(spec)
  if not spec or vim.tbl_isempty(spec) then return end
  local hl_name, hl_opts = { "El" }, {}
  for attr, val in pairs(spec) do
    if type(val) == "table" then
      table.insert(hl_name, attr)
      assert(vim.tbl_count(val) == 1)
      local hl, what = next(val)
      local hlID = vim.fn.hlID(hl) if hlID > 0 then
        table.insert(hl_name, hl)
        local col = vim.fn.synIDattr(hlID, what)
        if col and #col > 0 then
          table.insert(hl_name, what)
          hl_opts[attr] = col
        end
      end
    else
      -- bold, underline, etc
      hl_opts[attr] = val
    end
  end

  hl_name = table.concat(hl_name, "_")
  local newID = vim.fn.hlID(hl_name)
  if newID > 0 then
    for what, expected in pairs(hl_opts) do
      local res = vim.fn.synIDattr(newID, what)
      if type(expected) == "boolean" then
        res = res and res == "1" and true
      end
      if res ~= expected then
        newID = 0
      end
    end
  end
  if newID == 0 then
    vim.api.nvim_set_hl(0, hl_name, hl_opts)
  end
  return hl_name
end
