fx_version 'cerulean'
game 'gta5'

name "John_Changename"
description "John"
author "John"
version "1.0.0"


client_scripts {
	'Config.lua',
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'Config.lua',
	'server/*.lua'
}

ui_page 'Interface/index.html'

file {
	'Interface/*.html',
	'Interface/*.css',
	'Interface/*.js',
	'Interface/sound/*.mp3'
}