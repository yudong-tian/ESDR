
for orb in A D; do 
 for pol in V H; do 
  ofile=Desert-${pol}${orb}-3yr.dat
  ./Tb-spectra $pol $orb 2008 1 1 2010 12 31 22 29 $ofile 

cat > spectra-Desert-${pol}${orb}-3yr.ctl <<EOF

DSET       ^$ofile 
TITLE       AMSR-E TB, Desert, $pol-Pol, $orb-Pass 
OPTIONS     big_endian 
UNDEF       0
XDEF       6  levels 6 10 18 23 36 89 
YDEF       1  LINEAR         -89.875    0.25
ZDEF          1 Linear 1 1 
TDEF          1096 LINEAR    00Z01jan2008     1dy 
VARS          1
tb            1  99  ** Brightness temperature (K) 
ENDVARS

EOF

 done
done
