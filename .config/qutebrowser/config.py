import os
editor = os.environ.get('EDITOR', 'vi')
c.aliases['o'] = 'open'
c.aliases['h'] = 'help'

c.colors.tabs.odd.bg = '#3A3A3A'
c.colors.tabs.odd.fg = '#FFFFFF'
c.colors.tabs.even.bg = '#3A3A3A'
c.colors.tabs.even.fg = '#FFFFFF'
c.colors.tabs.selected.odd.bg = '#BCBCBC'
c.colors.tabs.selected.odd.fg = '#000000'
c.colors.tabs.selected.even.bg = '#BCBCBC'
c.colors.tabs.selected.even.fg = '#000000'

c.colors.tabs.pinned.odd.bg = '#3A3A3A'
c.colors.tabs.pinned.odd.fg = '#FFFFFF'
c.colors.tabs.pinned.even.bg = '#3A3A3A'
c.colors.tabs.pinned.even.fg = '#FFFFFF'
c.colors.tabs.pinned.selected.odd.bg = '#BCBCBC'
c.colors.tabs.pinned.selected.odd.fg = '#000000'
c.colors.tabs.pinned.selected.even.bg = '#BCBCBC'
c.colors.tabs.pinned.selected.even.fg = '#000000'

c.content.cookies.accept = 'no-3rdparty'
c.content.default_encoding = 'utf-8'
c.content.desktop_capture = 'ask'
c.content.javascript.enabled = False

c.spellcheck.languages = ['en-US']

c.url.default_page = 'https://archlinux.org'
c.url.start_pages = ['https://mastodon.danielmoch.com',
                     'https://twitter.com',
                     'https://archlinux.org']
c.url.searchengines = { 'DEFAULT': 'https://duckduckgo.com/?q={}' }

config.bind('<z><l>', "spawn --userscript qute-pass -u '^user.*:\s(.*)$' -U secret -d dmenu")
config.bind('<Ctrl-n>', 'completion-item-focus next', mode="command")
config.bind('<Ctrl-p>', 'completion-item-focus prev', mode="command")
config.bind('<Ctrl-Shift-N>', 'completion-item-focus next-category', mode="command")
config.bind('<Ctrl-Shift-P>', 'completion-item-focus prev-category', mode="command")
config.bind('<c><e>', 'config-edit')
config.bind('<c><s>', 'config-source')
config.bind('<,><c><e>', 'spawn -v my term -e ' + editor + ' .config/qutebrowser/config_local.py')
config.bind('<,><r>', 'reload --force')

# JavaScript whitelist
config.set('content.javascript.enabled', True, 'https://*.duckduckgo.com')
config.set('content.javascript.enabled', True, 'https://*.twitter.com')
config.set('content.javascript.enabled', True, 'https://*.djmoch.org')
config.set('content.javascript.enabled', True, 'https://*.danielmoch.com')

# Notifications whitelist
config.set('content.notifications', True, 'https://*.danielmoch.com')

try:
    import config_local
    config_local.config(config)
except ModuleNotFoundError:
    pass
