
* show the A- and D-pass difference in MPDI 10.65 Ghz

'open output/mean_JJA_A_mpdi.ctl'
'open output/mean_JJA_D_mpdi.ctl'
'set grads off'
'set gxout shaded' 
'set xlopts 1 0.5 0.15'
'set ylopts 1 0.5 0.15'
'set clevs -5 -4 -3 -2 -1 0 1 2 3 4 5'
'd mean-mean.2'
'cbarn'
'draw title MPDI*600 diff b/w A- and D-pass (10.65 GHz), JJA'
'gxyat -x 2000 -y 1600 mpdi-JJA-A-D-diff.png' 
'gxyat -x 1000 -y 800 mpdi-JJA-A-D-diff-sm.png' 

'reinit' 
'open output/mean_DJF_A_mpdi.ctl'
'open output/mean_DJF_D_mpdi.ctl'
'set grads off'
'set gxout shaded'
'set xlopts 1 0.5 0.15'
'set ylopts 1 0.5 0.15'
'set clevs -5 -4 -3 -2 -1 0 1 2 3 4 5'
'd mean-mean.2'
'cbarn'
'draw title MPDI*600 diff b/w A- and D-pass (10.65 GHz), DJF'
'gxyat -x 2000 -y 1600 mpdi-DJF-A-D-diff.png'
'gxyat -x 1000 -y 800 mpdi-DJF-A-D-diff-sm.png'


'reinit'

'open output/JJA_A_mpdi.ctl'
'open output/JJA_D_mpdi.ctl'
'set grads off'
'set gxout shaded'
'set xlopts 1 0.5 0.15'
'set ylopts 1 0.5 0.15'
'set clevs -5 -4 -3 -2 -1 0 1 2 3 4 5'
* JJA 2008
*time.1.3='t 461 552'
*June 08
'define meanA=ave(mpdi, t=461, t=491)' 
'define meanD=ave(mpdi.2, t=461, t=491)' 
'd meanA-meanD'
'cbarn'
'draw title MPDI*600 diff b/w A- and D-pass (10.65 GHz), Jun08'
'gxyat -x 2000 -y 1600 mpdi-Jun08-A-D-diff.png'
'gxyat -x 1000 -y 800 mpdi-Jun08-A-D-diff-sm.png'

'reinit'

'open output/DJF_A_mpdi.ctl'
'open output/DJF_D_mpdi.ctl'
'set grads off'
'set gxout shaded'
'set xlopts 1 0.5 0.15'
'set ylopts 1 0.5 0.15'
'set clevs -5 -4 -3 -2 -1 0 1 2 3 4 5'
* DJF 2008-09
*time.2.3='t 541 630'
* December 08 
'define meanA=ave(mpdi, t=541, t=572)'
'define meanD=ave(mpdi.2, t=541, t=572)'
'd meanA-meanD'
'cbarn'
'draw title MPDI*600 diff b/w A- and D-pass (10.65 GHz), Dec08'
'gxyat -x 2000 -y 1600 mpdi-Dec08-A-D-diff.png'
'gxyat -x 1000 -y 800 mpdi-Dec08-A-D-diff-sm.png'


'quit'

