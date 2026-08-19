--[[ telescope_pipe_fix.lua ]]
-- Workaround for: "Oneshot channel can only send once" on quit, which aborts
-- VimLeavePre and leaves Neovim unquittable until you SIGKILL it.
--
--   plenary/async/control.lua:122: Oneshot channel can only send once
--     telescope/_.lua:141   (LinesPipe:read read_start callback)
--     [C]: in function 'wait'
--     vim/lsp.lua:1203      (vim.lsp's VimLeavePre exit handler)
--
-- Why it happens:
--   telescope.LinesPipe:read() creates a fresh plenary oneshot channel per
--   read, then calls read_start(). Its callback does read_stop() and sends the
--   chunk exactly once. That holds while the main loop is running normally.
--
--   Neovim defers libuv callbacks that reach Lua while it is in a fast/no-Lua
--   context; vim.lsp's VimLeavePre handler calls vim.wait(), which pumps the
--   loop in exactly such a context. Several read callbacks for the same pipe
--   can therefore queue up *before* the first one's read_stop() takes effect.
--   When they flush, the second callback calls the already-used sender and
--   plenary asserts. The error escapes VimLeavePre, so the quit is cancelled;
--   every retry re-triggers it.
--
--   Trigger in practice: quitting while a telescope job (rg for live_grep, fd
--   for find_files, git ...) still has a live stdout pipe.
--
-- The fix: keep one send per oneshot, and stash the surplus chunks so the next
-- read() drains them instead of dropping output (dropping would silently
-- truncate picker results). Patch is applied to the class tables, so it also
-- covers pipes created before this ran.
--
-- Remove this once telescope.nvim/plenary.nvim are replaced (both are frozen;
-- plenary is slated for archival) or upstream fixes the pipe.

local M = {}

--- Build a replacement for BasePipe subclasses whose `read` is the
--- one-oneshot-per-read pattern (LinesPipe, ChunkPipe).
--- @return function read method
local function make_read()
	local channel = require("plenary.async").control.channel

	return function(self)
		-- Drain chunks a previous read over-collected before returning to libuv.
		if self._surplus and #self._surplus > 0 then
			return table.remove(self._surplus, 1)
		end
		if self._eof_seen then
			return nil
		end

		local read_tx, read_rx = channel.oneshot()
		local sent = false

		self.handle:read_start(function(err, data)
			assert(not err, err)

			-- read_stop() is best-effort: callbacks queued while Neovim was in a
			-- fast context still arrive after it. Buffer them rather than sending
			-- twice.
			if sent then
				if data == nil then
					self._eof_seen = true
					if not self._eof_sent then
						self._eof_sent = true
						self.eof_tx()
					end
				else
					self._surplus = self._surplus or {}
					table.insert(self._surplus, data)
				end
				return
			end

			sent = true
			self.handle:read_stop()

			read_tx(data)

			if data == nil then
				self._eof_seen = true
				if not self._eof_sent then
					self._eof_sent = true
					self.eof_tx()
				end
			end
		end)

		return read_rx()
	end
end

--- Patch telescope's pipe classes. Safe to call more than once.
M.setup = function()
	local ok, tele = pcall(require, "telescope._")
	if not ok then
		return
	end

	local read = make_read()
	for _, cls in ipairs({ tele.LinesPipe, tele.ChunkPipe }) do
		if cls then
			cls.read = read
		end
	end
end

return M
