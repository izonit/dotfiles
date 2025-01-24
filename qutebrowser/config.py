# Autoconfig
config.load_autoconfig(False)

# Enable JavaScript
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.local_content_can_access_remote_urls', True, 'file:///home/daniil/.local/share/qutebrowser/userscripts/*')
config.set('content.local_content_can_access_file_urls', False, 'file:///home/daniil/.local/share/qutebrowser/userscripts/*')

# Dark mode
#config.set('colors.webpage.darkmode.enabled', True)

config.source('qb-themes/themes/onedark.py')
