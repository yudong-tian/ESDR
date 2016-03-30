* Display TbV-TbV(6G), TbH-TbH(6G) and TbV-TbH for Ascending and Descending AMSR-E 

*** panel layout, landscape 
cols=3
rows=2
hgap=0.0 
vgap=0.1
vh=8.5/rows
vw=11/cols
parea='0.0 11 1.0 8.0'

var.1.1='tb.1-t1'
var.2.1='tb.2-t2'
var.3.1='tb.1-tb.2'
var.1.2='tb.3-t3'
var.2.2='tb.4-t4'
var.3.2='tb.3-tb.4'

* Amazon2 (2N, 55W)
vrg.1.1.1='-5 -4 -3 -2 -1 0 1 2 3 4 5' 
vrg.2.1.1='-5 -4 -3 -2 -1 0 1 2 3 4 5'
vrg.3.1.1='0 0.3 0.6 0.9 1.2 1.5 1.8 2.1 2.4' 
vrg.1.2.1='-5 -4 -3 -2 -1 0 1 2 3 4 5'
vrg.2.2.1='-5 -4 -3 -2 -1 0 1 2 3 4 5'
vrg.3.2.1='0 0.3 0.6 0.9 1.2 1.5 1.8 2.1 2.4'

* Desert (22N, 29E)
vrg.1.1.2='-24 -21 -18 -15 -12 -9 -6 -3 0 3' 
vrg.2.1.2='0 5 10 15 20 25 30 35 40 45' 
vrg.3.1.2='0 5 10 15 20 25 30 35 40 45 50 55 60' 
vrg.1.2.2='-24 -21 -18 -15 -12 -9 -6 -3 0 3'
vrg.2.2.2='0 5 10 15 20 25 30 35 40 45' 
vrg.3.2.2='0 5 10 15 20 25 30 35 40 45 50 55 60'

* Ocean1 (0, 150W) 
vrg.1.1.3='0 10 20 30 40 50 60 70 80 90 100' 
vrg.2.1.3='0 20 40 60 80 100 120 140 160 180' 
vrg.3.1.3='0 10 20 30 40 50 60 70 80 90 100'
vrg.1.2.3='0 10 20 30 40 50 60 70 80 90 100'
vrg.2.2.3='0 20 40 60 80 100 120 140 160 180'
vrg.3.2.3='0 10 20 30 40 50 60 70 80 90 100'

* SGP (35N, 97W)
vrg.1.1.4='-12 -9 -6 -3 0 3 6 9 12 15' 
vrg.2.1.4='-3 0 3 6 9 12 15 18 21 24' 
vrg.3.1.4='0 2 4 6 8 10 12 14 16 18 20' 
vrg.1.2.4='-12 -9 -6 -3 0 3 6 9 12 15'
vrg.2.2.4='-3 0 3 6 9 12 15 18 21 24'
vrg.3.2.4='0 2 4 6 8 10 12 14 16 18 20'

ttl.1.1='TbV-Tb6 Asdg'
ttl.2.1='TbH-Tb6 Asdg' 
ttl.3.1='TbV-TbH Asdg'
ttl.1.2='TbV-Tb6 Dsdg' 
ttl.2.2='TbH-Tb6 Dsdg' 
ttl.3.2='TbV-TbH Dsdg' 

regs=4
reg.1='Amazon2'
reg.2='Desert'
reg.3='Ocean1'
reg.4='SGP'

ireg=1
while (ireg <= regs)

 'reinit'

 'open spectra-'reg.ireg'-VA-3yr.ctl' 
 'open spectra-'reg.ireg'-HA-3yr.ctl' 
 'open spectra-'reg.ireg'-VD-3yr.ctl' 
 'open spectra-'reg.ireg'-HD-3yr.ctl' 

row=1
while (row <= rows)
  col=1
  while (col <= cols)

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
     'set gxout grfill' 
     'set x 1 6'
     'set t 1 1096' 
     'set xlevs 6 10 18 23 36 89'

      'set x 1'
      'define t1=tb.1'
      'define t2=tb.2'
      'define t3=tb.3'
      'define t4=tb.4'
      'set x 1 6'
      'set clevs 'vrg.col.row.ireg
      'd 'var.col.row
      'cbarn'
*     'draw xlab Frequency (Ghz)'
     'draw ylab Time'
     'draw title AMSR-E 'reg.ireg' 'ttl.col.row 

  col=col+1
  endwhile
 row=row+1
endwhile 

'printim 3x2-Tb-diff-'reg.ireg'-3yr.gif white x2400 y2000' 
'printim 3x2-Tb-diff-'reg.ireg'-3yr-sm.gif white x1200 y1000' 

ireg=ireg+1
endwhile

