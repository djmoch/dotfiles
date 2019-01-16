import os
editor = os.environ.get('EDITOR', 'vi')
c.aliases['o'] = 'open'
c.aliases['h'] = 'help'

c.colors.tabs.odd.bg = '#262626'
c.colors.tabs.odd.fg = '#BCBCBC'
c.colors.tabs.even.bg = '#262626'
c.colors.tabs.even.fg = '#BCBCBC'
c.colors.tabs.selected.odd.bg = '#6C6C6C'
c.colors.tabs.selected.odd.fg = '#BCBCBC'
c.colors.tabs.selected.even.bg = '#6C6C6C'
c.colors.tabs.selected.even.fg = '#BCBCBC'

c.content.cookies.accept = 'no-3rdparty'
c.content.default_encoding = 'utf-8'
c.content.desktop_capture = 'ask'
c.content.javascript.enabled = False

c.spellcheck.languages = ['en-US']

c.url.default_page = 'https://archlinux.org'
c.url.start_pages = ['https://mastodon.technology',
                     'https://twitter.com',
                     'https://archlinux.org']
c.url.searchengines = { 'DEFAULT': 'https://duckduckgo.com/html/?q={}' }

config.bind('<z><l>', "spawn --userscript qute-pass -u '^user.*:\s(.*)$' -U secret -d dmenu")
config.bind('<Ctrl-n>', 'completion-item-focus next', mode="command")
config.bind('<Ctrl-p>', 'completion-item-focus prev', mode="command")
config.bind('<Ctrl-Shift-N>', 'completion-item-focus next-category', mode="command")
config.bind('<Ctrl-Shift-P>', 'completion-item-focus prev-category', mode="command")
config.bind('<z><c>', 'config-edit')
config.bind('<,><z><c>', 'spawn -v my term -e ' + editor + ' .config/qutebrowser/config_local.py')

# JavaScript whitelist
config.set('content.javascript.enabled', True, 'https://mastodon.technology')
config.set('content.javascript.enabled', True, 'https://twitter.com')
config.set('content.javascript.enabled', True, 'https://github.com')
config.set('content.javascript.enabled', True, 'https://*.djmoch.org')
config.set('content.javascript.enabled', True, 'https://*.danielmoch.com')
config.set('content.javascript.enabled', True, 'https://docs.python.org')

try:
    import config_local
    config_local.config(config)
except ModuleNotFoundError:
    pass
