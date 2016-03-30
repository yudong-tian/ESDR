* Display 3-yr time series of MPDI [(TbV-TbH)/(TbV+TbH)] for each frequency, 
* Ascending and Descending AMSR-E  and 4 sites

*** panel layout, landscape 
cols=1
rows=3
hgap=0.15 
vgap=0.1
vh=11/rows
vw=8.5/cols
parea='1.0 7.5 0.5 3.1'

* .row  A and D 
var.1='(tb.1-tb.2)/(tb.1+tb.2)'
var.2='(tb.3-tb.4)/(tb.3+tb.4)'

* .col.page
* Amazon2 (2N, 55W)
vrg.1.1='0 0.01' 
ylint.1.1=0.001

* Desert (22N, 29E)
vrg.1.2='0 0.15'
ylint.1.2=0.03

* Ocean1 (0, 150W) 
vrg.1.3='0 0.4' 
ylint.1.3=0.1 

* SGP (35N, 97W)
vrg.1.4='0 0.05' 
ylint.1.4=0.01 

* C3VP (44N, 80W)
vrg.1.5='0 0.1' 
ylint.1.5=0.02 

* HMT (34N, 81W)
vrg.1.6='0 0.05' 
ylint.1.6=0.01 

* ND (46.5N, 98.5W)
vrg.1.7='0 0.10' 
ylint.1.7=0.02 

* .row
ttl.1='MPDI Asdg'
ttl.2='MPDI Dsdg'

* col.page 
reg.1.1='Amazon2'
reg.1.2='Desert'
reg.1.3='Ocean1'
reg.1.4='SGP'
reg.1.5='C3VP'
reg.1.6='HMT'
reg.1.7='ND'

ipage=4
while (ipage <= 4)

 'reinit'

  col=1
  while (col <= cols)

 'open spectra-'reg.col.ipage'-VA-7yr.ctl' 
 'open spectra-'reg.col.ipage'-HA-7yr.ctl' 
 'open spectra-'reg.col.ipage'-VD-7yr.ctl' 
 'open spectra-'reg.col.ipage'-HD-7yr.ctl' 

  row=1
*  while (row <= rows)
  while (row <= 2) 

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
* 19G
     'set x 3' 
     'set ccolor 7'
     'set vrange 'vrg.col.ipage
     'set ylint 'ylint.col.ipage
     'set digsize 0.02'
     'd 'var.row

     'set x 5'
     'set ccolor 8'
     'set vrange 'vrg.col.ipage
     'set ylint 'ylint.col.ipage
     'set digsize 0.02'
     'd 'var.row

     'set x 6'
     'set ccolor 9'
     'set vrange 'vrg.col.ipage
     'set ylint 'ylint.col.ipage
     'set digsize 0.02'
     'd 'var.row

  'draw ylab MPDI'
  'draw title AMSR-E 'reg.col.ipage' TB 'ttl.row 
  'cbar_line -x 2.7 -y 2.8 -c 7 8 9 -l 1 1 1 -m "2" "3" "4" -t "19GHz" "37GHz" "89GHz"'

   row=row+1
  endwhile 
  'close 4'
  'close 3'
  'close 2'
  'close 1'

 col=col+1
 endwhile

'printim 1x2-Tb-mpdi-04-07-'reg.1.ipage'-3fqs.gif white x2000 y2800' 
'printim 1x2-Tb-mpdi-04-07-'reg.1.ipage'-3fqs-sm.gif white x1000 y1400' 
'printim 1x2-Tb-mpdi-04-07-'reg.1.ipage'-3fqs-icn.gif white x210 y320' 

ipage=ipage+1
endwhile

