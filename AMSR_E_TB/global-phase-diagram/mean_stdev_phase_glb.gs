* Display mean and stdev for mpdi as a phase space

*** panel layout, portrait 
cols=1
rows=1
hgap=0.0 
vgap=0.1
vh=11.0/rows
vw=8.5/cols
parea='0.5 10.5 0.5 8.0'

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
'set_rgba 32 160 230 50 'transp

* passes
np=2
ps.1='A'
ps.2='D'

* page
nv=2
var.1='mean'
var.2='stdev'

seasons=2 
sn.1='DJF' 
sn.2='JJA'

* row 
rvar.1='mpdi'
rvar.2='tb36v' 
rvar.3='tbdif'
rvar.4='tbdif2' 

lab.1='MPDI10'
lab.2='Tb36V'
lab.3='Tb18V-Tb36V'
lab.4='Tb36V-Tb89V'

* row.page
* page1: mean
clev.1.1='0 5 10 15 20 25 30 35 40 45 50 55 60 65' 
clev.2.1='200 210 220 230 240 250 260 270 280 290 300' 
clev.3.1='-3 0 3 6 9 12 15 18 21 24 27 30' 
clev.4.1='-9 -6 -3 0 3 6 9 12 15 18 21 24' 

* page2: stdev 
clev.1.2='0 1 2 3 4 5 6 7 8 9 10 11 12' 
clev.2.2='0 1 2 3 4 5 6 7 8 9 10 11 12' 
clev.3.2='0 1 2 3 4 5 6 7 8 9 10 11 12' 
clev.4.2='0 1 2 3 4 5 6 7 8 9 10 11 12' 


* two passes 
ip=1
while (ip <= np) 

* two seasons 
 is=1
 while (is <= 2) 

'reinit'

     row=1
     col=1 
     'open output/mean_'sn.is'_'ps.ip'_'rvar.row'.ctl' 
     'open output/stdev_'sn.is'_'ps.ip'_'rvar.row'.ctl' 
     'open output/landmask_UMD.ctl' 
     vx1=(col-1)*vw+(col-1)*hgap
     vx2=col*vw-hgap
     vy1=(rows-row)*vh+vgap
     vy2=vy1+vh-vgap
*     'set vpage 'vx1' 'vx2' 'vy1' 'vy2
*     'set parea 'parea
     'set grads off'
     'set xlopts 1 0.5 0.15'
     'set ylopts 1 0.5 0.15'
     'set grads off' 
     'set gxout scatter' 
     'set vrange 0 210'
     'set vrange2 0 80' 
     'set digsize 0.02'  
     'set ccolor 22'
*     'd maskout(mean, mask.3(t=1));maskout(stdev.2, mask.3(t=1))' 
     'd mean;stdev.2' 
*     'cbarn' 
     'draw xlab MPDI mean'
     'draw ylab MPDI stdev'
     'draw title 'sn.is' 'ps.ip'-pass '
     'close 3' 
     'close 2' 
     'close 1' 

'gxyat -x 2400 -y 2000 glb_phase-'sn.is'-'ps.ip'.png' 
'gxyat -x 1200  -y 1000 glb_phase-'sn.is'-'ps.ip'-sm.png' 

 is=is+1
 endwhile

ip=ip+1
endwhile



