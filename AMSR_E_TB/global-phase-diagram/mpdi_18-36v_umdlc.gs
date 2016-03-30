* Display mean and stdev for mpdi as a phase space, colored by different UMD land cover

*** panel layout, portrait 
cols=1
rows=1
hgap=0.0 
vgap=0.1
vh=11.0/rows
vw=8.5/cols
parea='0.5 10.5 0.5 8.0'

transp=0.7

'set_rgba 19 0 0 0 0'
'set_rgba 20 0 0 0 'transp
'set_rgba 21 0 220 0 'transp
'set_rgba 22 0 200 200 'transp
'set_rgba 23 170 170 170 'transp
'set_rgba 24 30 60 255 'transp
'set_rgba 25 240 0 130 'transp
'set_rgba 26 230 220 50 'transp
'set_rgba 27 160 0 200 'transp
'set_rgba 28 240 130 40 'transp
'set_rgba 29 230 175 45 'transp
'set_rgba 30 255 0 0 'transp
'set_rgba 31 0 220 0 'transp
'set_rgba 32 160 230 50 'transp

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

vrg.1='-20 50'
vrg.2='-15 15'

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
     'open output/mean_'sn.is'_'ps.ip'_mpdi.ctl' 
     'open output/mean_'sn.is'_'ps.ip'_tbdif.ctl' 
     'open output/landmask_UMD.ctl' 
     'open /home/ytian/proj-disk/LS_PARAMETERS/UMD/25KM/landcover_UMD.ctl'
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
     'set vrange -30 150'
     'set vrange2 -30 50'
     'set vrange2 'vrg.is 
     'set digsize 0.02'  

     lc=1
     while (lc <= 13) 
*     'set ccolor 22'
     'set digsize 0.02'  
     'set cmark 'marks.lc
      col=lc+19
     'set ccolor 'col
     'define lcmask=maskout(vegtype'lc'.4(t=1), vegtype'lc'.4(t=1)-300)'
*     'd maskout(mean, mask.3(t=1)-0.5);maskout(mean.2, mask.3(t=1)-0.5)' 
     'd maskout(mean, lcmask);maskout(mean.2, lcmask)' 
     lc=lc+1
     endwhile
*     'd mean;mean.2' 
*     'cbarn' 
     'draw xlab Mean MPDI'
     'draw ylab Mean Tb18-36V'
     'draw title 'sn.is' 'ps.ip'-pass '
     'close 4' 
     'close 3' 
     'close 2' 
     'close 1' 

'my_cbar_l -x 9.7 -y 7.5 -n 13 -t "ENF" "EBF" "DNF" "DBF" "MxF" "WdL" "WdG" "CSr" "OSr" "Grs" "Crp" "BrG" "Urb"'
'gxyat -x 2400 -y 2000 mpdi_18-36_phase_lcmask-'sn.is'-'ps.ip'.png' 
'gxyat -x 1200  -y 1000 mpdi_18-36_phase_lcmask-'sn.is'-'ps.ip'-sm.png' 

 is=is+1
 endwhile

ip=ip+1
endwhile



