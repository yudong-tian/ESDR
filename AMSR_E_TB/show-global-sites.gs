
* Show the big sites (5x5-deg, or 20x20 0.25-deg grids)

'reinit'
*'open /home/ytian/proj-disk/LS_PARAMETERS/UMD/25KM/MODIS_RT/lai-2009.ctl'
'open /home/ytian/proj-disk/LS_PARAMETERS/UMD/25KM/elev_GTOPO30.ctl'
'set lat -80 80' 
'set lon -180 180' 
'set grads off'
'set gxout shaded'
*'set mpdset hires'
'set gxout grfill' 
*'d lai*0.1'
'set clevs 0 50 100 200 500 1000 1500 2000' 
'd elev' 
'cbar'
* SGP
*'plotbox -99.875 34.125 -95.125 38.875'
'plotx -97 35 SGP'
* HMT
*'plotbox -84.625 33.125 -79.875 37.875'
*'plotbox -86.875 30.875 -82.125 34.125'
'plotx -81 34 HMT'
* C3VP
'plotx -80 44 C3VP' 
* Amazon1 
'plotx -70 -7 AMZ1' 
* Amazon2 
'plotx -55 2 AMZ2' 
* Desert 
'plotx 29 22 DRT' 
* Desert2
'plotx -5 22 DRT2' 
* Finland 
'plotx 25 60 FNLD' 
* Wetland 
'plotx -57 -18 WTLD' 
* Inland water 
'plotx -87 48 ILWTR' 
* North Dakota 
'plotx -98.5 46.5 ND' 


'draw title LSWG Land Sites'
'printim global-sites.gif gif white x1000 y800'



