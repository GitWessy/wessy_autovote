fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"

ui_page "show.html"

server_script {
	'server.lua'
}

client_script {
	'client.lua',
}

shared_scripts {
	'config.lua'
}

files {
	'show.html',
	'init.js'
}
