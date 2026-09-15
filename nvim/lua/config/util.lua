-- Small helpers behind the keymaps in config/keymaps.lua. Each fills a gap
-- where a built-in is almost right but not quite.
local M = {}

-- Delete the current buffer without closing the window(s) it is shown in.
-- Each window first moves to the alternate buffer, else the previous one,
-- else a fresh scratch buffer; only then is the buffer deleted.
function M.bufremove(force)
  local buf = vim.api.nvim_get_current_buf()
  if not force and vim.bo[buf].modified then
    vim.notify("Buffer is modified, use <leader>bD to force", vim.log.levels.WARN)
    return
  end
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      local alt = vim.fn.bufnr("#")
      if alt > 0 and alt ~= buf and vim.bo[alt].buflisted then
        vim.cmd.buffer(alt)
      elseif #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
        vim.cmd("bprevious")
      end
      if vim.api.nvim_get_current_buf() == buf then
        vim.cmd.enew()
      end
    end)
  end
  vim.api.nvim_buf_delete(buf, { force = force })
end

-- Delete every other listed, unmodified buffer.
function M.bufremove_others()
  local cur = vim.api.nvim_get_current_buf()
  local n = 0
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if b ~= cur and vim.bo[b].buflisted and not vim.bo[b].modified then
      vim.api.nvim_buf_delete(b, {})
      n = n + 1
    end
  end
  vim.notify(("Closed %d other buffer(s)"):format(n))
end

-- Toggle a floating terminal running `cmd` (a string or argv list). One
-- terminal per command: the buffer survives being hidden, and the window
-- closes when the command exits. Passing `key` also binds it inside that
-- terminal's buffer so the same key hides the float from terminal mode.
local terms = {}
function M.float_term(cmd, key)
  local id = type(cmd) == "table" and table.concat(cmd, " ") or cmd
  local t = terms[id] or {}
  terms[id] = t
  if t.win and vim.api.nvim_win_is_valid(t.win) then
    vim.api.nvim_win_hide(t.win)
    t.win = nil
    return
  end
  local fresh = not (t.buf and vim.api.nvim_buf_is_valid(t.buf))
  if fresh then
    t.buf = vim.api.nvim_create_buf(false, true)
  end
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.85)
  t.win = vim.api.nvim_open_win(t.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })
  if fresh then
    vim.fn.jobstart(cmd, {
      term = true,
      on_exit = function()
        vim.schedule(function()
          if t.buf and vim.api.nvim_buf_is_valid(t.buf) then
            vim.api.nvim_buf_delete(t.buf, { force = true })
          end
          t.buf, t.win = nil, nil
        end)
      end,
    })
    if key then
      vim.keymap.set("t", key, function()
        M.float_term(cmd, key)
      end, { buffer = t.buf, silent = true, desc = "Hide terminal" })
    end
  end
  vim.cmd.startinsert()
end

return M
