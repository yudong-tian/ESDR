
# Desert site, 10x10-deg box around 22N, 29E: 
#X is varying   Lon = 24.125 to 33.875   X = 817 to 856
#Y is varying   Lat = 17.125 to 26.875   Y = 429 to 468

for orb in A D; do 
 for pol in V H; do 
  ofile=bigDesert-${pol}${orb}-Apr-Jun05.dat
  ./Tb-spectra-area $pol $orb 2005 4 1 2005 6 30 17.125 24.125 26.875 33.875 $ofile 

cat > spectra-bigDesert-${pol}${orb}-Apr-Jun05.ctl <<EOF

DSET       ^$ofile 
TITLE       AMSR-E TB, bigDesert, $pol-Pol, $orb-Pass 
OPTIONS     big_endian 
UNDEF       0
XDEF     40  LINEAR    24.125  0.25
YDEF     40  LINEAR    17.125  0.25
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
