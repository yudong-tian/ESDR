
'reinit'
'open spectra-Amazon2-VA.ctl'
'open spectra-Amazon2-HA.ctl'
'set grads off'
'set xlopts 1 0.5 0.15'
'set ylopts 1 0.5 0.15'

'set mproj off'
'set x 1 6' 
'set xlevs 6 10 18 23 36 89'
*'set xlabs 6|10|18|23|36|89'
tmax=365
t0=1
while (t0 <= tmax) 
  tc=t0/40+1
* say 'tc='tc
  'set t 't0
  'set cmark 0'
  'set ccolor 'tc 
  'set vrange -1 4' 
  'd tb-tb.2' 
  t0=t0+1
endwhile

'draw xlab Frequency (Ghz)'
'draw ylab TbV-TbH (K)' 
'draw title AMSR-E TbV-TbH Amazon2 Ascending 2009'


