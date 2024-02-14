return function(opts, fn)
  return function(window, buffer)
    if not window and buffer then
      window = { win_id = vim.fn.bufwinid(buffer.bufnr) }
    end
    if opts.hide_inactive and window and window.win_id ~= vim.api.nvim_get_current_win() then
      return ""
    end
    return fn(window, buffer)
  end
end

