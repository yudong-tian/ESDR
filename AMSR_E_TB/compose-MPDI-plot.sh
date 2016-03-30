
len=2070   # image length
hgt=720 

# 1st row ------------------------------------------------

convert -crop ${len}x${hgt}+200+50 1x2-Tb-mpdi-04-07-Desert.gif $TMPDIR/r1.gif 
convert -pointsize 65 -font helvetica -fill black -draw "text 450,100 'a)'"  \
  $TMPDIR/r1.gif $TMPDIR/lr1.png 

convert -crop ${len}x${hgt}+200+50 1x2-Tb-mpdi-04-07-Amazon2.gif $TMPDIR/r2.gif 
convert -pointsize 65 -font helvetica -fill black -draw "text 450,100 'b)'"  \
  $TMPDIR/r2.gif $TMPDIR/lr2.png 

convert -crop ${len}x${hgt}+200+50 1x2-Tb-mpdi-04-07-SGP.gif $TMPDIR/r3.gif 
convert -pointsize 65 -font helvetica -fill black -draw "text 450,100 'c)'"  \
  $TMPDIR/r3.gif $TMPDIR/lr3.png 

convert -append $TMPDIR/lr1.png $TMPDIR/lr2.png $TMPDIR/lr3.png Tb-mpdi-3-site.png 
convert -resize 1000x1000 Tb-mpdi-3-site.png sm-Tb-mpdi-3-site.png

