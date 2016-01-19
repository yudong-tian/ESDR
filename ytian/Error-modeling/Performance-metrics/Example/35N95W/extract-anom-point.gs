
* exract day-time anomalies at one location (35N, 95W) 

'open /home/ytian/esdr-disk/ytian/MODIS-LST/MOD11C3.005/LST.ctl' 
'set lon -95' 
'set lat 35' 
'set t 1 168'
'define tsTP=lst'
'set t 1 12'
'define clim=ave(tsTP, t+0, t=168, 12)' 
'modify clim seasonal' 
'set t 1 168'
'define anom=tsTP-clim' 
'set undef dfile' 
'set gxout fwrite'
'set fwrite -be -st anom-35N-95W.1gd4r'
'd anom'
'disable fwrite'


