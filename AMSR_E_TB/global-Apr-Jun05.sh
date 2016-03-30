
#X is varying   Lon = -179.875 to 179.875   X = 1 to 1440
#Y is varying   Lat = -89.875 to 89.875   Y = 1 to 720

for orb in A D; do 
 for pol in V H; do 
  ofile=global-${pol}${orb}-Apr-Jun05.dat
  ./Tb-spectra-area $pol $orb 2005 4 1 2005 6 30 -89.875 -179.875 89.875 179.875 $ofile 

cat > spectra-global-${pol}${orb}-Apr-Jun05.ctl <<EOF

DSET       ^$ofile 
TITLE       AMSR-E TB, global, $pol-Pol, $orb-Pass 
OPTIONS     big_endian 
UNDEF       0
XDEF       1440 LINEAR        -179.875    0.25
YDEF        720 LINEAR         -89.875    0.25
ZDEF          1 Linear 1 1 
TDEF          91 LINEAR    00Z01Apr2005     1dy 
VARS          6
${pol}6    1  99  **  1 insert description here W/m2
${pol}10    1  99  **  1 insert description here W/m2
${pol}18    1  99  **  1 insert description here W/m2
${pol}23    1  99  **  1 insert description here W/m2
${pol}36    1  99  **  1 insert description here W/m2
${pol}89    1  99  **  1 insert description here W/m2
ENDVARS
EOF

 done
done
