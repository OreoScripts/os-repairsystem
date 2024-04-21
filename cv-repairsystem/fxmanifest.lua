fx_version ("cerulean")
game ("gta5")
description ("CV Repairsystem")
author ("CoreVersion")
version ("1.0.0")

shared_scripts {"repairsystem-sh.lua"}
server_scripts {"repairsystem-se.lua"}
client_scripts {"repairsystem-cl.lua"}

files {
    "ui/*.*",
    "ui/Hackman_Bold.ttf",
    "ui/Hackman_Regular.ttf",
}

ui_page {
    "ui/Index.html"
}

dependencies {
    'polyzonehelper'
}
