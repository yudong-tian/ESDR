
'reinit'
*** panel layout, landscape
cols=2
rows=2
hgap=0.15
vgap=0.1
vh=8.5/rows
vw=11/cols
parea='1.0 10 1.0 7.5'

'open ARS.ctl'
'open ARS-y1.ctl'
'open ARS-y2.ctl'
var.1='sm.2' 
var.2='sm.3' 
lab.1='a)'
lab.2='b)'

col=1
 while (col <= cols)

  row=1
  while (row <= 1)

     vx1=(col-1)*vw+(col-1)*hgap
     vx2=col*vw-hgap
     vy1=(rows-row)*vh+vgap
     vy2=vy1+vh-vgap
     'set vpage 'vx1' 'vx2' 'vy1' 'vy2
     'set parea 'parea
     'set grads off'
     'set xlopts 1 0.5 0.15'
     'set ylopts 1 0.5 0.15'
     'set digsize 0.02'

     'set time 1jul2007 1jan2009' 
     'set vrange 0 0.7' 
     'set ccolor 1' 
     'set cthick 6'
     'set cmark 0' 
     'd sm' 
     'set ccolor 4' 
     'set cmark 0' 
     'd 'var.col 
       
*  'draw xlab Time'
  'draw ylab Soil moisture (m^3/m^3)'
*  'draw title AMSR-E 'ttl.col
  'my_cbar_l -x 7.9 -y 7.1 -n 2 -t "Truth" "Measurements"'
  'set strsiz 0.3'
  'draw string 1.2 7 'lab.col

   row=row+1
  endwhile

 col=col+1
 endwhile

'gxyat -x 2400 -y 1600 2x1-ARS-example.png'
'gxyat -x 1200 -y 800  2x1-ARS-example-sm.png'
     
