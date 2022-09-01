fx_version 'cerulean'
game 'gta5'

name "LItemBasic"
description "fivem ressource"
author "LQuatre"
version "1.0.0"

dependency 'jsfour-idcard'

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'server/*.lua'
}
