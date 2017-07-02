:: Author: Tomasz Ceszke 2017

"C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" http://ls.tkchopin.pl:1935/live/rybacka.stream/playlist.m3u8  --no-audio --video-filter=croppadd:scene --croppadd-croptop=330 --croppadd-cropbottom=350 --croppadd-cropleft=800 --croppadd-cropright=360 --scene-format=jpg --scene-path="datasource\live" --scene-prefix=scene --scene-ratio=5 --scene-replace 

::  -I dummy --network-caching=2000