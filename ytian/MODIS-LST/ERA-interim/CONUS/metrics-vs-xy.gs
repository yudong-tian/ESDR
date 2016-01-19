* 9/24/2014: use maskout(skt, lst.2) to make sure x and y grids are identical.

'open ../monthly.ctl'
'open LST-0.75.ctl'
'set lon 230.25 290.25'
'set lat 24.75 54.75' 

'define xbar=ave(lst.2, t=7, t=174)' 
'define sigmax2=ave( (lst.2-xbar)*(lst.2-xbar), t=7, t=174)' 
'define ybar=ave(maskout(skt, lst.2), t=7, t=174)'
'define xbyb=ave( (skt-ybar)*(lst.2-xbar), t=7, t=174)'
'define xb2=ave( (lst.2-xbar)*(lst.2-xbar), t=7, t=174)'
'define lamda=xbyb/xb2'
'define delta=ybar/lamda-xbar'
'define sigma2=ave( (skt - lamda * (lst.2 + delta))*(skt - lamda * (lst.2 + delta)),  t=7, t=174)'

'define sigma=sqrt(sigma2)' 
'define sR=lamda*sqrt(sigmax2/(lamda*lamda*sigmax2 + sigma2))' 
'define bias=ybar-xbar' 
* sR can be compared with the following ts
*'define ts=scorr(skt, lst.2, t=7, t=174)'

* now we have lamda, delta, sigma, and SR. Display them in 2x2


*** panel layout, landscape
cols=2
rows=2
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

* ic.ir, in km
var.1.1='delta'
*var.1.1='bias'
var.2.1='lamda'
var.1.2='sigma'
var.2.2='sR'

ttl.1.1='Adjusted bias (K)'
*ttl.1.1='Bias (K)'
ttl.2.1='Scale error'
ttl.1.2='Random error (K)'
ttl.2.2='Temporal correlation' 

vrg.1.1='-40 -20 0 20 40 60 80 100 120'
*vrg.1.1='-8 -6 -4 -2 0 2 4 6 8 10'
vrg.2.1='0.75 0.8 0.85 0.9 0.95 1.0 1.05 1.1 1.15 1.2 1.25' 
vrg.1.2='0 0.3 0.6 0.9 1.2 1.5 1.8 2.1 2.4 2.7 3.0' 
vrg.2.2='0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1' 

parea='0.7 10.2 1.0 8.0'

ir=1
while (ir <= rows)
 ic=1
 while (ic <= cols)

*compute vpage
 vx1=(ic-1)*vw+hgap
 vx2=ic*vw-hgap
 vy1=(rows-ir)*vh+vgap
 vy2=vy1+vh-vgap
 'set vpage 'vx1' 'vx2' 'vy1' 'vy2
 'set grads off'
 'set parea 'parea
 'set mpdset hires'
 'set gxout shaded'
 'set clevs 'vrg.ic.ir
 'set t 1'
 'set xlopts 1 0.5 0.15'
 'set ylopts 1 0.5 0.15'
 'd 'var.ic.ir
 'cbarn'
 'draw title 'ttl.ic.ir
 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 4000 -y 3000 2x2-metrics-vs-xy.png'
'gxyat -x 1000 -y 750 sm-2x2-metrics-vs-xy.png'
