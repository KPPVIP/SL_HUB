fx_version "cerulean"
game "gta5"

author "restrict"
description "modern carhud"
version "1.0.0"

ui_page "html/car_hud.html"

files {
    "html/*.*",
    "html/images/*.*"
}

client_scripts {"config.lua", "main.lua"}

lua54 'yes'
escrow_ignore {
    'config.lua',
    'main.lua'
}