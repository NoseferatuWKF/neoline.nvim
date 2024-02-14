return function(opts)
  opts = opts or {}

  local Job = require("plenary.job")
  local el_sub = require("el.subscribe")
  local wrap_fnc = require("utils.wrap_fnc")
  local set_hl = require("utils.set_hl")

  return el_sub.buf_autocmd("el_git_branch", "BufEnter",
    wrap_fnc(opts, function(_, buffer)
      local branch = vim.g.loaded_fugitive == 1 and
      -- TODO: usage of fugitive needs to be documented here
        vim.fn.FugitiveHead() or nil
      if not buffer or not (buffer.bufnr > 0) then
        return
      end
      if not branch or #branch == 0 then
        local ok, res = pcall(vim.api.nvim_buf_get_var,
          buffer.bufnr, "gitsigns_head")
        if ok then branch = res end
      end
      if not branch then
        local j = Job:new {
          command = "git",
          args = { "branch", "--show-current" },
          cwd = vim.fn.fnamemodify(buffer.name, ":h"),
        }

        local ok, result = pcall(function()
          return vim.trim(j:sync()[1])
        end)
        if ok then
          branch = result
        end
      end

      if branch and #branch > 0 then
        local fmt = opts.fmt or "%s %s"
        local icon = opts.icon or ""
        return set_hl(opts.hl, (fmt):format(icon, branch))
      end
    end))
end

