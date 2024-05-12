fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'BX-Intro'
author 'B3NDO'
description 'Introduction for server'
version 'V.1.0'
url 'https://github.com/xB3NDO'

client_scripts {
    'client/client.lua',
    'config.lua'
}

server_scripts {
    'server/server.lua',
    'version.lua',
    'config.lua'
}

shared_scripts {
    'config.lua',
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'  -- uniquement si vous utilisez OX Lib
}

loadscreen 'html/index.html'
loadscreen_manual_shutdown 'yes'