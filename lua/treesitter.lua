local M = {}

--- @alias available_parsers table<string, boolean>
---
--- @type available_parsers
local available

--- @return available_parsers Table of available parsers
local function get_available(ts)
  if available then return available end
  available = {}

  for _, language in ipairs(ts.get_available()) do
    available[language] = true
  end

  return available
end

--- @param buf integer Current buffer id
--- @param language string Name of the parser
--- @return boolean True if the parser can be attached to the buffer safely
local function buffer_still_matches(buf, language)
  if not vim.api.nvim_buf_is_loaded(buf) then return false end
  return vim.treesitter.language.get_lang(vim.bo[buf].filetype) == language
end

--- @param buf integer Current buffer id
--- @param language string Name of the parser
--- @return boolean True if the parser has successfully attached
local function attach(buf, language)
  -- Attachment runs after FileType's critical path, so the buffer may have
  -- changed or been unloaded before we get here
  if not buffer_still_matches(buf, language) then return false end
  if not vim.treesitter.language.add(language) then return false end

  local ok = pcall(vim.treesitter.start, buf, language)
  if not ok then return false end

  if vim.treesitter.query.get(language, "indents") then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end

  return true
end

function M.setup(opts)
  local ts = require "nvim-treesitter"
  ts.install(opts.ensure_installed)

  local supported = get_available(ts)

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom-treesitter-lazy", { clear = true }),
    callback = function(args)
      local buf = args.buf
      local language = vim.treesitter.language.get_lang(args.match)

      if not language then return end

      -- Defer parser startup so FileType does not block first paint. Revalidate
      -- the buffer on execution because it may have changed in the meantime
      vim.schedule(function()
        if attach(buf, language) then return end

        if not supported[language] then return end

        ts.install(language):await(function(err, ok)
          if err or not ok then return end
          vim.schedule(function() attach(buf, language) end)
        end)
      end)
    end,
  })
end

return M
