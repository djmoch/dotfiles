-- load standard vis module, providing parts of the Lua API
require('vis')
require('ctags')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set theme djmoch')
	vis:command('set autoindent')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set number')
	set_indent(win.syntax)
end)

function set_indent(syntax)
	if syntax == "powershell" then size_indent(4, true)
	elseif syntax == "python" then size_indent(4, true)
	elseif syntax == "rust" then size_indent(4, true)
	elseif syntax == "java" then size_indent(2, true)
	elseif syntax == "groovy" then size_indent(2, true)
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
