* Display mean and stdev for mpdi, tb36v, tb18v-tb36v, tb36v-tb89v 

*** panel layout, portrait 
cols=2
rows=4
hgap=0.0 
vgap=0.1
vh=11.0/rows
vw=8.5/cols
parea='0.5 10.5 0.5 8.0'

* These are the BLUE shades
'set rgb 20 135 206 250'
'set rgb 21 0 191 255'
'set rgb 22 0 0 255'
'set rgb 23 0 0 205'
'set rgb 24 0 0 123'
'set rgb 25 0 0 83'
* These are the RED shades
'set rgb 30 245 222 179'
'set rgb 31 244 164 96'
'set rgb 32 210 105 30'
'set rgb 33 178 34 34'
'set rgb 34 165 42 42'
'set rgb 35 145 60 60'

* passes
np=2
ps.1='A'
ps.2='D'

* page
nv=2
var.1='mean'
var.2='stdev'

*col
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

* two pages
 iv=1
 while (iv <= nv) 

'reinit'

row=1
while (row <= rows)
  col=1
  while (col <= cols)

     'open output/'var.iv'_'sn.col'_'ps.ip'_'rvar.row'.ctl' 
     'open output/landmask_UMD.ctl' 
     vx1=(col-1)*vw+(col-1)*hgap
     vx2=col*vw-hgap
     vy1=(rows-row)*vh+vgap
     vy2=vy1+vh-vgap
     'set vpage 'vx1' 'vx2' 'vy1' 'vy2
     'set parea 'parea
     'set grads off'
     'set xlopts 1 0.5 0.15'
     'set ylopts 1 0.5 0.15'
*     'set mproj off'
*     'set lat 24 48'  
*     'set lon -125 -70'
*     'set mpdset hires' 
     'set grads off' 
     'set gxout shaded' 
     'set clevs 'clev.row.iv 
     'd maskout('var.iv', mask.2(t=1))' 
     'cbarn' 
     'draw title 'var.iv' 'lab.row' 'ps.ip'-pass 'sn.col
     'close 2' 
     'close 1' 

  col=col+1
  endwhile
 row=row+1
endwhile 

'gxyat -x 2000 -y 2800 2x4-'var.iv'-'ps.ip'.png' 
'gxyat -x 1000  -y 1400 2x4-'var.iv'-'ps.ip'-sm.png' 

 iv=iv+1
 endwhile

ip=ip+1
endwhile



