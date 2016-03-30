
'open DJF_A_mpdi.ctl'
'define mean=ave(mpdi, t=1, t=810)'
'set gxout shaded'
'd mean'
'open mean_DJF_A_mpdi.ctl'
'set grads off'
'd mean.2(t=1)-mean'
'draw title diff in mean' 
*output
* Contouring: -0.0003 to 0.0003 interval 5e-05
'cbar' 
'gxyat -x 1200 -y 1000 mean_diff.png' 

'define stdev=sqrt(ave(pow(mean-mpdi, 2), t=1, t=810))'
'open stdev_DJF_A_mpdi.ctl'
* output
* Contouring: 10 to 70 interval 10
'd stdev.3(t=1)-stdev'
*output: differences are in north pole
* Contouring: 0.5 to 5.5 interval 0.5
'set lat -89 86'
'c'
'set grads off'
'd stdev.3(t=1)-stdev'
'cbar'
'draw title diff in stdev'
* output: difference is much smaller, but there due to algorithm difference 
* Contouring: 0.005 to 0.06 interval 0.005
'gxyat -x 1200 -y 1000 stdev_diff.png' 


