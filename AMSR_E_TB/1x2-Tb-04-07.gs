* Display 3-yr time series of TB for each frequency, 
* Ascending and Descending AMSR-E  and 4 sites

*** panel layout, landscape 
cols=1
rows=2
hgap=0.15 
vgap=0.1
vh=8.5/rows
vw=11/cols
parea='0.0 11 1.0 8.0'

* .row  A and D 
varV.1='tb.1' 
varH.1='tb.2' 
varV.2='tb.3' 
varH.2='tb.4' 

* .col.page
* Amazon2 (2N, 55W)
vrg.1.1='250 300' 
ylint.1.1=10

* Desert (22N, 29E)
vrg.1.2='220 300' 
ylint.1.2=10

* Ocean1 (0, 150W) 
vrg.1.3='50 300'
ylint.1.3=50

* SGP (35N, 97W)
vrg.1.4='210 310' 
ylint.1.4=10

* C3VP (44N, 80W)
vrg.1.5='200 300' 
ylint.1.5=10

* HMT (34N, 81W)
vrg.1.6='240 300' 
ylint.1.6=10

* ND (46.5N, 98.5W)
vrg.1.7='180 300' 
ylint.1.7=10

* Amazon1 (7S, 70W) 
vrg.1.8='250 300'
ylint.1.8=10

* Desert2 (22N, 5W) 
vrg.1.9='220 300'
ylint.1.9=10


* .row
ttl.1='Asdg'
ttl.2='Dsdg'

* col.page 
reg.1.1='Amazon2'
reg.1.2='Desert'
reg.1.3='Ocean1'
reg.1.4='SGP'
reg.1.5='C3VP'
reg.1.6='HMT'
reg.1.7='ND'
reg.1.8='Amazon1'
reg.1.9='Desert2'

ipage=8
while (ipage <= 9)

 'reinit'

  col=1
  while (col <= cols)

 'open spectra-'reg.col.ipage'-VA-7yr.ctl' 
 'open spectra-'reg.col.ipage'-HA-7yr.ctl' 
 'open spectra-'reg.col.ipage'-VD-7yr.ctl' 
 'open spectra-'reg.col.ipage'-HD-7yr.ctl' 

  row=1
  while (row <= rows)

     vx1=(col-1)*vw+(col-1)*hgap
     vx2=col*vw-hgap
     vy1=(rows-row)*vh+vgap
     vy2=vy1+vh-vgap
     'set vpage 'vx1' 'vx2' 'vy1' 'vy2
     'set parea 'parea
     'set grads off'
     'set xlopts 1 0.5 0.15'
     'set ylopts 1 0.5 0.15'

     'set mproj off'
     'set time 1jul2004 30jun2007' 
   ix=1
   while (ix <= 6)
     'set x 'ix 
     'set vrange 'vrg.col.ipage
     'set ylint 'ylint.col.ipage
     'set digsize 0.01'
*     'd 'varV.row 
     'd 'varH.row 
     ix=ix+1
   endwhile
  'draw ylab TbH (K)'
  'draw title AMSR-E TbH 'reg.col.ipage' 'ttl.row 
*  'cbar_l -x 4.7 -y 3.3 -n 6 -t "6GHz" "10GHz" "18GHz" "23GHz" "36Ghz" "89Ghz"' 

   row=row+1
  endwhile 
  'close 4'
  'close 3'
  'close 2'
  'close 1'

 col=col+1
 endwhile

'printim 1x2-Tb-04-07-'reg.1.ipage'.gif white x2400 y1600' 
'printim 1x2-Tb-04-07-'reg.1.ipage'-sm.gif white x1200 y800' 
'printim 1x2-Tb-04-07-'reg.1.ipage'-icn.gif white x320 y210' 

ipage=ipage+1
endwhile

'quit'
