local getwinforfile = function(file)
  for win in vis:windows() do
    if win and win.file and win.file.path == file.path then
      return win
    end
  end
end

local options = {
  makefile = {
    expandtab = false,
  },
}

local apply = function(win)
  for syntax, updater in pairs(options) do
    if win.syntax == syntax then
      if type(updater) == 'table' then
        for key, value in pairs(updater) do
          win.options[key] = value
        end
      elseif type(updater) == 'function' then
        updater(win)
      elseif updater ~= nil then
        vis:info(
          'File type ' .. syntax .. ' options must be a table or function'
        )
      end
    end
  end
end

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
  apply(win)
end)
vis.events.subscribe(vis.events.FILE_OPEN, function(file)
  local win = getwinforfile(file)
  if win then
    apply(win)
  end
end)

return options
