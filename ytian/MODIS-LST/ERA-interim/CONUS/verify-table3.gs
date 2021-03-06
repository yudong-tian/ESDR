
* Use conventional metrics, to compare with metrics-vs-xy.gs
* 9/24/2014: use maskout(skt, lst.2) to make sure x and y grids are identical. 

'open ../monthly.ctl'
'set t 7'
'open LST-0.75.ctl'
'set lon 230.25 290.25'
'set lat 24.75 54.75' 
*'set lat 24.75 51.75' 

* x: lst.2 (reference), y: skt (data) 
'define xbar=ave(lst.2, t=7, t=174)' 
'define sigmax2=ave( (lst.2-xbar)*(lst.2-xbar), t=7, t=174)' 
'define ybar=ave(maskout(skt, lst.2), t=7, t=174)'
'define sigmay2=ave( (skt-ybar)*(skt-ybar), t=7, t=174)' 
'define xbyb=ave( (skt-ybar)*(lst.2-xbar), t=7, t=174)'
'define xb2=ave( (lst.2-xbar)*(lst.2-xbar), t=7, t=174)'
'define lamda=xbyb/xb2'
'define delta=ybar/lamda-xbar'
'define sigma2=ave( (skt - lamda * (lst.2 + delta))*(skt - lamda * (lst.2 + delta)),  t=7, t=174)'

* conventional metrics 
'define bias=ybar-xbar' 
'define mse=ave( (lst.2-skt)*(lst.2-skt), t=7, t=174)' 
'define rmse=sqrt(mse)' 
* skill score 
'define sscore=1 - mse/xb2' 

* conventional metrics derived from new ones 
'define biasN=(lamda-1)*xbar+lamda*delta' 
*'define mseN=(ybar-xbar)*(ybar-xbar) + (lamda-1)*(lamda-1)*sigmax2 + sigma2' 
'define mseN=bias*bias + (lamda-1)*(lamda-1)*sigmax2 + sigma2' 
'define sscoreN=1- ((ybar-xbar)*(ybar-xbar) + (lamda-1)*(lamda-1)*sigmax2 + sigma2 )/sigmax2' 

'define sigma=sqrt(sigma2)' 
'define sR=lamda*sqrt(sigmax2/(lamda*lamda*sigmax2 + sigma2))' 
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
var.1.1='biasN - bias'
var.2.1='mseN- mse '
var.1.2='sscoreN - sscore'
var.2.2='lamda*sqrt( sigmax2/(lamda*lamda*sigmax2+sigma2) ) - sR'

ttl.1.1='Bias diff (K)'
ttl.2.1='MSE diff (K^2)'
ttl.1.2='Skill score diff'
ttl.2.2='Temporal correlation diff' 

vrg.1.1='-5 -4 -3 -2 -1 0 1 2 3 4 5' 
vrg.2.1='0 1 2 3 4 5 6 7 8' 
vrg.1.2='.9 .91 .92 .93 .94 .95 .96 .97 .98 .99 1'
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
* 'set clevs 'vrg.ic.ir
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
'gxyat -x 4000 -y 3000 2x2-verify-metrics-vs-xy.png'
'gxyat -x 1000 -y 750 sm-2x2-verify-metrics-vs-xy.png'
