
for loc in Alaska Alps Amazon1 Amazon2 C3vp CAus Canada Canada2 \
           Congo Desert Desert2 EChina Florida Gobi Hmt Hmt2 \
           NEChina Nd Nd2 Rockies Rockies2 Rockies3 SCa SD \
           Seberia Sgp Sgp2 Tibet Tibet1 Tibet2 Tibet3 WGch2 Wgch Wetland; do

#./bin-MPDI-Tb36V $loc  

cat > ${loc}-A.ctl <<EOF

DSET       ^${loc}-A.1gd4r 
TITLE       Density of points in regime diagram 
OPTIONS     big_endian 
UNDEF       -9999 
XDEF     100  LINEAR  0   0.65 
YDEF     100  LINEAR  210 1.0 
ZDEF          1 Linear 1 1 
TDEF          1 LINEAR    00Z01jan2004     1dy 
VARS          1
densi       1  99  **  1 count 
ENDVARS
EOF

cat > ${loc}-D.ctl <<EOF1

DSET       ^${loc}-D.1gd4r
TITLE       Density of points in regime diagram
OPTIONS     big_endian
UNDEF       -9999 
XDEF     100  LINEAR  0   0.65 
YDEF     100  LINEAR  210 1.0 
ZDEF          1 Linear 1 1
TDEF          1 LINEAR    00Z01jan2004     1dy
VARS          1
densi       1  99  **  1 count
ENDVARS
EOF1


done 

