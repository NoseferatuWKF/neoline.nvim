return function(diagnostic, _, buffer)
  local counts = { 0, 0, 0, 0 }
  local diags = diagnostic.get(buffer.bufnr)

  if diags and not vim.tbl_isempty(diags) then
    for _, d in ipairs(diags) do
      if tonumber(d.severity) then
        counts[d.severity] = counts[d.severity] + 1
      end
    end
  end

  return {
    errors   = counts[1],
    warnings = counts[2],
    infos    = counts[3],
    hints    = counts[4],
  }
end

