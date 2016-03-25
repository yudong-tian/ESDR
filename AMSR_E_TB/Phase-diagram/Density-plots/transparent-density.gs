* Plot phase density diagram in MPDI/V36 space, with transparent shading 
* $Id$ 
*passes
ps.1='D'
ps.2='A'
np=2
* regions 
reg.1='Amazon1' 
reg.2='C3vp' 
reg.3='Desert' 
reg.4='Hmt'
reg.5='Nd'
reg.6='Sgp'
reg.7='Rockies' 
reg.8='Wgch' 
reg.9='Tibet' 
reg.10='Canada' 
reg.11='Wetland'
reg.12='Finland' 
reg.13='Inlandw' 
reg.14='Grnld' 
reg.15='Ocean1'

cols.1=3
cols.2=5
cols.3=15
cols.4=4
cols.5=6
cols.6=7
cols.7=9
cols.8=8
cols.9=12
cols.10=1
cols.11=3
cols.12=15
cols.13=13
cols.14=5
cols.15=4
cols.16=6

marks.1=3
marks.2=3
marks.3=9
marks.4=3
marks.5=4
marks.6=1
marks.7=2
marks.8=3
marks.9=7
marks.10=8
marks.11=6
marks.12=8
marks.13=1
marks.14=6
marks.15=4
marks.16=7

transp=0.3

'set_rgba 19 0 0 0 0'  
'set_rgba 21 0 220 0 'transp 
'set_rgba 22 0 200 200 'transp 
'set_rgba 23 170 170 170 'transp 
'set_rgba 24 30 60 255 'transp 
'set_rgba 25 240 0 130 'transp 
'set_rgba 26 230 220 50 'transp 
'set_rgba 27 160 0 200 'transp 
'set_rgba 28 240 130 40 'transp 
'set_rgba 29 230 175 45 'transp 
'set_rgba 30 255 255 255 'transp 
'set_rgba 31 0 220 0 'transp 
'set_rgba 32 170 170 170 'transp 

* semi-transparent shading 
scols.1=21 
scols.2=22
scols.3=23
scols.4=24
scols.5=25
scols.6=26
scols.7=27
scols.8=28
scols.9=29
scols.10=30
scols.11=31
scols.12=32


ip=1
while(ip<=np)
prompt 'Hit enter to start pass-'ps.ip' ...' 
pull tmp
'reinit'
'set grads off'
'set parea 1 9.0 1 7.5'

nreg=11
ir=1
while(ir<=nreg)
* descending and ascending
 'open 'reg.ir'-'ps.ip'.ctl'
 'open coarse.ctl' 
 'set mproj off' 
 'set cterp on' 
 'set csmooth on' 
 'set xlopts 1 0.5 0.15'
 'set ylopts 1 0.5 0.15'
 'set gxout shaded' 
 'set ccols 19 'scols.ir' 'scols.ir
 'set clevs 2 4' 
 'd lterp(densi, densi.2)'
 'set gxout contour' 
 'set ccolor 'cols.ir
* 'set clevs 2 4 8 16 32 64 128' 
 'set clevs 2 4 8 16 32' 
 'set cthick 6' 
 'set clab off' 
 'd lterp(densi, densi.2)'
 'close 2'
 'close 1'

ir=ir+1
endwhile
 'draw xlab MPDI*600'
 'draw ylab Tb36V (K)'

'draw title AMSR-E 2004-2010 'ps.ip'-pass'
'my_cbar_l -x 9.2 -y 7.5 -n 11 -t "Amz1" "C3VP" "Sahr1" "HMT" "ND" "SGP" "Rcks1" "WGch" "Tibet1" "Cand" "Wetld"'
'gxyat -x 2000 -y 1600 transp-plot-zoom-locs-'ps.ip'.png' 
'gxyat -x 1000 -y 800 transp-plot-zoom-locs-'ps.ip'-sm.png' 


ip=ip+1
endwhile


