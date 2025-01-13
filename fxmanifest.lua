fx_version 'cerulean'
game 'gta5'

author 'Bence'
description 'A script for adding and removing PP and money with discord log system'
version '1.0.0'


repository 'https://github.com/xyzBence'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}
