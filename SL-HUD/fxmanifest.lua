fx_version 'cerulean'
game 'gta5'

author 'restricti'
description 'HUD System'

ui_page 'html/HUD.html'

files {
    'images/*.*',
    'html/*.*'
}

client_scripts{'config.lua', 'client.lua'}
server_scripts{'config.lua', 'server.lua'}

lua54 'yes'
escrow_ignore {
    'config.lua',
    'server.lua',
    'client.lua'
}