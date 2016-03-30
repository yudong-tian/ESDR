* Display 3-yr time series of MPDI [(TbV-TbH)/(TbV+TbH)] for each frequency, 
* Ascending and Descending AMSR-E  and 4 sites

*** panel layout, landscape 
cols=2
rows=2
hgap=0.15 
vgap=0.1
vh=8.5/rows
vw=11/cols
parea='0.0 11 1.0 8.0'

* .row  A and D 
var.1='(tb.1-tb.2)/(tb.1+tb.2)'
var.2='(tb.3-tb.4)/(tb.3+tb.4)'

* .col.page
* Amazon2 (2N, 55W)
vrg.1.1='0 0.01' 

* Desert (22N, 29E)
vrg.2.1='0 0.15'

* Ocean1 (0, 150W) 
vrg.1.2='0 0.4' 

* SGP (35N, 97W)
vrg.2.2='0 0.06' 

* .row
ttl.1='MPDI Asdg'
ttl.2='MPDI Dsdg'

* col.page 
reg.1.1='Amazon2'
reg.2.1='Desert'
reg.1.2='Ocean1'
reg.2.2='SGP'

ipage=1
while (ipage <= 2)

 'reinit'

  col=1
  while (col <= cols)

 'open spectra-'reg.col.ipage'-VA-3yr.ctl' 
 'open spectra-'reg.col.ipage'-HA-3yr.ctl' 
 'open spectra-'reg.col.ipage'-VD-3yr.ctl' 
 'open spectra-'reg.col.ipage'-HD-3yr.ctl' 

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
     'set t 1 1096' 
   ix=1
   while (ix <= 6)
     'set x 'ix 
     'set vrange 'vrg.col.ipage
     'set digsize 0.04'
     'd 'var.row
     ix=ix+1
   endwhile
  'draw ylab MPDI'
  'draw title AMSR-E 'reg.col.ipage' 'ttl.row 
  'cbar_l -x 8.7 -y 7.5 -n 6 -t "6GHz" "10GHz" "18GHz" "23GHz" "36Ghz" "89Ghz"' 

   row=row+1
  endwhile 
  'close 4'
  'close 3'
  'close 2'
  'close 1'

 col=col+1
 endwhile

'printim 2x2-Tb-mpdi-3yr-'ipage'.gif white x2400 y1600' 
'printim 2x2-Tb-mpdi-3yr-'ipage'-sm.gif white x1200 y800' 

ipage=ipage+1
endwhile

