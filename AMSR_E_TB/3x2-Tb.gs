* Display TbV, TbH and TbV-TbH for Ascending and Descending AMSR-E 

*** panel layout, landscape 
cols=3
rows=2
hgap=0.0 
vgap=0.1
vh=8.5/rows
vw=11/cols
parea='0.0 11 1.0 8.0'


var.1.1='tb.1'
var.2.1='tb.2'
var.3.1='tb.1-tb.2'
var.1.2='tb.3'
var.2.2='tb.4'
var.3.2='tb.3-tb.4'

* col.row.reg
* Amazon2 (2N, 55W)
vrg.1.1.1='270 300' 
vrg.2.1.1='270 300' 
vrg.3.1.1='-1 4' 
vrg.1.2.1='270 300' 
vrg.2.2.1='270 300' 
vrg.3.2.1='-1 4' 

* Desert (22N, 29E)
vrg.1.1.2='220 310' 
vrg.2.1.2='220 310' 
vrg.3.1.2='0  70' 
vrg.1.2.2='220 310' 
vrg.2.2.2='220 310' 
vrg.3.2.2='0 70' 

* Ocean1 (0, 150W) 
vrg.1.1.3='80 290'
vrg.2.1.3='80 290'
vrg.3.1.3='0  100'
vrg.1.2.3='80 290'
vrg.2.2.3='80 290'
vrg.3.2.3='0 100'

* SGP (35N, 97W)
vrg.1.1.4='220 310' 
vrg.2.1.4='220 310' 
vrg.3.1.4='0 40' 
vrg.1.2.4='220 310'
vrg.2.2.4='220 310'
vrg.3.2.4='0 40' 

* Ocean4 (5, 150W)
vrg.1.1.5='80 290'
vrg.2.1.5='80 290'
vrg.3.1.5='0  100'
vrg.1.2.5='80 290'
vrg.2.2.5='80 290'
vrg.3.2.5='0 100'

ttl.1.1='TbV Asdg'
ttl.2.1='TbH Asdg' 
ttl.3.1='TbV-TbH Asdg'
ttl.1.2='TbV Dsdg' 
ttl.2.2='TbH Dsdg' 
ttl.3.2='TbV-TbH Dsdg' 

regs=5
reg.1='Amazon2'
reg.2='Desert'
reg.3='Ocean1'
reg.4='SGP'
reg.5='Ocean4'

ireg=5
while (ireg <= regs)

 'reinit'

 'open spectra-'reg.ireg'-VA.ctl' 
 'open spectra-'reg.ireg'-HA.ctl' 
 'open spectra-'reg.ireg'-VD.ctl' 
 'open spectra-'reg.ireg'-HD.ctl' 

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
     'set x 1 6'
     'set xlevs 6 10 18 23 36 89'

     tmax=365
     t0=1
     while (t0 <= tmax) 
       tc=t0/40+1
      'set t 't0
      'set cmark 0'
      'set ccolor 'tc
      'set vrange 'vrg.col.row.ireg 
      'd 'var.col.row
      t0=t0+1
     endwhile
     'draw xlab Frequency (Ghz)'
     'draw ylab Tb (K)'
     'draw title AMSR-E 'reg.ireg' 'ttl.col.row' 2009'

  col=col+1
  endwhile
 row=row+1
endwhile 

'printim 3x2-Tb-'reg.ireg'.gif white x2400 y1200' 
'printim 3x2-Tb-'reg.ireg'-sm.gif white x1200 y600' 

ireg=ireg+1
endwhile

