return function(hls, s)
  if not hls or not s then return s end
  hls = type(hls) == "string" and { hls } or hls
  for _, hl in ipairs(hls) do
    if vim.fn.hlID(hl) > 0 then
      return ("%%#%s#%s%%0*"):format(hl, s)
    end
  end
  return s
end

