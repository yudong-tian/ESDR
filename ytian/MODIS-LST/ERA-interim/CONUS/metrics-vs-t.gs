
'open ../monthly.ctl'
'open LST-0.75.ctl' 
* Jul2000-Jun2014
'set t 7 174'

'set x 1'
'set y 1' 

'define xbar=amean(lst.2, lon=230.25, lon=290.25, lat=24.75, lat=54.75)'
'define sigmax2=amean( (lst.2-xbar)*(lst.2-xbar), lon=230.25, lon=290.25, lat=24.75, lat=54.75)'
'define ybar=amean(skt, lon=230.25, lon=290.25, lat=24.75, lat=54.75)'
'define xbyb=amean( (skt-ybar)*(lst.2-xbar), lon=230.25, lon=290.25, lat=24.75, lat=54.75)'
'define xb2=amean( (lst.2-xbar)*(lst.2-xbar), lon=230.25, lon=290.25, lat=24.75, lat=54.75)'
'define lamda=xbyb/xb2'
'define delta=ybar/lamda-xbar'
'define sigma2=amean( (skt - lamda * (lst.2 + delta))*(skt - lamda * (lst.2 + delta)),  lon=230.25, lon=290.25, lat=24.75, lat=54.75)'

'define sigma=sqrt(sigma2)' 
'define sR=lamda*sqrt(sigmax2/(lamda*lamda*sigmax2 + sigma2))' 
'define bias=ybar-xbar'
* sR can be compared with the following ts
*'define ts=scorr(skt, lst.2, lon=230.25, lon=290.25, lat=24.75, lat=54.75)'

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
ttl.2.2='Spatial correlation' 

vrg.1.1='-40 100'
*vrg.1.1='-5 10'
vrg.2.1='0.5 1.5' 
vrg.1.2='0 10' 
vrg.2.2='0.5 1' 

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
* 'set clevs 0 200 400 600 800 1000 1200'
 'set xlopts 1 0.5 0.15'
 'set ylopts 1 0.5 0.15'
 'set vrange 'vrg.ic.ir
 'd 'var.ic.ir
* 'cbarn'
 'draw title 'ttl.ic.ir
 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 4000 -y 3000 2x2-metrics-vs-t.png'
'gxyat -x 1000 -y 750 sm-2x2-metrics-vs-t.png'
