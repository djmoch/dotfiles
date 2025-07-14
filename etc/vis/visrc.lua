-- load standard vis module, providing parts of the Lua API
require('vis')
require('io')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set autoindent')
	local stream = io.popen('dark-mode status')
	local result = stream:read('l')
	stream:close()
	if result == 'off' then	vis:command('set theme djmoch')
	else vis:command('set theme apprentice')
	end
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	set_indent(win.syntax)
	vis:command('set syntax off')
	vis:command('set numbers on')
	if vis.win.width >= 160 then vis:command('set layout v') end
end)

function set_indent(syntax)
	if syntax == 'powershell' then size_indent(4, true)
	elseif syntax == 'python' then size_indent(4, true)
	elseif syntax == 'rust' then size_indent(4, true)
	elseif syntax == 'java' then size_indent(2, true)
	elseif syntax == 'groovy' then size_indent(2, true)
	else size_indent(8, false)
	end
end

function size_indent(tabwidth, expandtab)
	vis:command('set tabwidth '..tabwidth)
	if expandtab
	then
		vis:command('set expandtab')
	else
		vis:command('set expandtab off')
	end
end
