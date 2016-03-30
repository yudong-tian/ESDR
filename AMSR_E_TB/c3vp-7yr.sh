
for orb in A D; do 
 for pol in V H; do 
  ofile=C3VP-${pol}${orb}-7yr.dat
  ./Tb-spectra $pol $orb 2004 1 1 2010 12 31 44 -80 $ofile 

cat > spectra-C3VP-${pol}${orb}-7yr.ctl <<EOF

DSET       ^$ofile 
TITLE       AMSR-E TB, C3VP, $pol-Pol, $orb-Pass 
OPTIONS     big_endian 
UNDEF       0
XDEF       6  levels 6 10 18 23 36 89 
YDEF       1  LINEAR         43.875   0.25
ZDEF          1 Linear 1 1 
TDEF          2557 LINEAR    00Z01jan2004     1dy 
VARS          1
tb            1  99  ** Brightness temperature (K) 
ENDVARS

EOF

 done
done
