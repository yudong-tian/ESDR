
#X is varying   Lon = -169.875 to -115.125   X = 41 to 260
#Y is varying   Lat = 57.625 to 74.875   Y = 591 to 660

for orb in A D; do 
 for pol in V H; do 
  ofile=Alaska-BanksIsl-${pol}${orb}-9yr.dat
#  ./Tb-spectra-area $pol $orb 2002 7 1 2011 6 30 57.625 -169.875 74.875 -115.125 $ofile 

cat > spectra-Alaska-BanksIsl-${pol}${orb}-9yr.ctl <<EOF

DSET       ^$ofile 
TITLE       AMSR-E TB, global, $pol-Pol, $orb-Pass 
OPTIONS     big_endian 
UNDEF       0
XDEF       220 LINEAR        -169.875    0.25
YDEF       70 LINEAR         57.625    0.25
ZDEF       1 Linear 1 1 
TDEF       3287 LINEAR    00Z01Jul2002     1dy 
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
