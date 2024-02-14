if not pcall(require, "el") then
  return
end

local M = {}

M.extract_hl = require("utils.extract_hl")

M.mode = require("components.mode")

M.line_number = require("components.line_number")

M.git_branch = require("integrations.el_git_branch")

M.git_changes = require("integrations.gitsigns")

M.diagnostics = require("integrations.el_buf_diagnostic")

M.file_icon = require("integrations.devicons")(M)

return M
