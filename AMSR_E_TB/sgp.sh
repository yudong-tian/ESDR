
for orb in A D; do 
 for pol in V H; do 
  ofile=SGP-${pol}${orb}.dat
  ./Tb-spectra $pol $orb 2009 1 1 2009 12 31 35 -97 $ofile 

cat > spectra-SGP-${pol}${orb}.ctl <<EOF

DSET       ^$ofile 
TITLE       AMSR-E TB, SGP, $pol-Pol, $orb-Pass 
OPTIONS     big_endian 
UNDEF       0
XDEF       6  levels 6 10 18 23 36 89 
YDEF       1  LINEAR         -89.875    0.25
ZDEF          1 Linear 1 1 
TDEF          365 LINEAR    00Z01jan2009     1dy 
VARS          1
tb            1  99  ** Brightness temperature (K) 
ENDVARS

EOF

 done
done
