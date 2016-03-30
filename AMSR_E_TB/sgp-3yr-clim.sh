
for orb in A D; do 
 for pol in V H; do 
  ofile=SGP-${pol}${orb}-3yr.dat
  cfile=SGP-${pol}${orb}-3yr-clim.dat
  #./Tb-spectra $pol $orb 2008 1 1 2010 12 31 35 -97 $ofile 

  ./Tb-clim 1096 $ofile $cfile

cat > spectra-SGP-${pol}${orb}-3r-clim.ctl <<EOF

DSET       ^$cfile 
TITLE       AMSR-E TB, SGP, $pol-Pol, $orb-Pass 
OPTIONS     big_endian 
UNDEF       0
XDEF       6  levels 6 10 18 23 36 89 
YDEF       1  LINEAR         -89.875    0.25
ZDEF          1 Linear 1 1 
TDEF          1096 LINEAR    00Z01jan2008     1dy 
VARS          1
tb            1  99  ** Brightness temperature clim (K) 
ENDVARS

EOF

 done
done