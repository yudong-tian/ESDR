
'open D-TIM.ctl'
'set grads off' 
'set clevs 0 15 30 45 60 75 90 105 120'
'set gxout shaded'
'd min'
'cbarn'
'draw title Local Time: Minutes after Midnight, Orbit 2009007D'
'printim LST-2009007D-sm.gif gif white x600 y400'
'printim LST-2009007D.gif gif white x1200 y800'
'reinit'

'open A-TIM.ctl'
'set grads off'
'set gxout shaded'
'set clevs 0 15 30 45 60 75 90 105 120'
'd min-720'
'cbarn'
'draw title Local Time: Minutes after Noon, Orbit 2009007A'
'printim LST-2009007A-sm.gif gif white x600 y400'
'printim LST-2009007A.gif gif white x1200 y800'
'reinit'

'open D-GMT-TIM.ctl'
'set grads off'
'set clevs 0 3 6 9 12 15 18 21' 
'set gxout shaded'
'd min/60'
'cbarn'
'draw title GMT Time: Hours, Orbit 2009007D'
'printim GMT-2009007D-sm.gif gif white x600 y400'
'printim GMT-2009007D.gif gif white x1200 y800'
'reinit'

'open A-GMT-TIM.ctl'
'set grads off'
'set gxout shaded'
'set clevs 0 3 6 9 12 15 18 21' 
'd min/60'
'cbarn'
'draw title GMT Time: Hours, Orbit 2009007A'
'printim GMT-2009007A-sm.gif gif white x600 y400'
'printim GMT-2009007A.gif gif white x1200 y800'
'quit'

