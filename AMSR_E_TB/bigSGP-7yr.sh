
for orb in A D; do 
 for pol in V H; do 
  ofile=bigSGP-${pol}${orb}-7yr.dat
  ./Tb-spectra-area $pol $orb 2004 1 1 2010 12 31 34.125 -99.875 38.875 -95.125 $ofile 

cat > spectra-bigSGP-${pol}${orb}-7yr.ctl <<EOF

DSET       ^$ofile 
TITLE       AMSR-E TB, bigSGP, $pol-Pol, $orb-Pass 
OPTIONS     big_endian 
UNDEF       0
XDEF     20  LINEAR  -99.875  0.25
YDEF     20  LINEAR    34.125  0.25
ZDEF          1 Linear 1 1 
TDEF          2557 LINEAR    00Z01jan2004     1dy 
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
