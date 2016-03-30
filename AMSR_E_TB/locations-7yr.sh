
for orb in A D; do 
 for pol in V H; do 

  #./Tb-spectra-locations $pol $orb 2004 1 1 2010 12 31 locations.txt
  #./Tb-spectra-locations $pol $orb 2004 1 1 2010 12 31 locations2.txt
  #./Tb-spectra-locations $pol $orb 2004 1 1 2010 12 31 locations3.txt
  ./Tb-spectra-locations $pol $orb 2004 1 1 2010 12 31 locations4.txt

 done
done

mail -s "location4 is done" "yudong.tian@nasa.gov" <<EOF

/home/ytian/lswg/AMSR_E_TB
.
EOF

