*
*  Script to plot a cross at a point given by lon/lat 
*
*  Yudong Tian, Sept. 2006. 
*
function plotx (args)
*  example: plotx lon lat "label"
******     lon, lat: 	location 
***********************   STANDARDS   **************************************************
lon=subwrd(args, 1)
lat=subwrd(args, 2)
label=subwrd(args, 3)

'set line 1 1 6' 
'q ll2xy 'lon' 'lat 
x0=subwrd(result, 1)
y0=subwrd(result, 2)
x1=x0-0.1
x2=x0+0.1
y1=y0-0.1
y2=y0+0.1

'draw line 'x1' 'y0' 'x2' 'y0
'draw line 'x0' 'y1' 'x0' 'y2

'set string 1 tc 0.02 0' 
'set strsiz 0.08'
'draw string 'x2' 'y2' 'label

exit
***********************   END   **************************************************
**********************************************************************************
**********************************************************************************
**********************************************************************************

