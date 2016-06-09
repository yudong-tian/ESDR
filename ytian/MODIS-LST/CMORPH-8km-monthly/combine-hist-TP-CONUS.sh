
# combine four histograms (TP and CONUS) 

# label plot

convert -pointsize 65 -font helvetica -fill black -draw "text 450,100 'a) Tibetan Pl.'"  \
  TP/hist.png $TMPDIR/a.png
convert -pointsize 65 -font helvetica -fill black -draw "text 450,100 'b) CONUS'"  \
  CONUS/hist.png $TMPDIR/b.png

convert +append $TMPDIR/a.png $TMPDIR/b.png hist-TP-CONUS.png 
convert -resize 1000x800 hist-TP-CONUS.png sm-hist-TP-CONUS.png 
