
for yr in 2008 2009 2010; do 
 mkdir $yr
 cd $yr
 wget --passive-ftp ftp://sidads.colorado.edu/pub/DATASETS/nsidc0302_amsre_qtrdeg_tbs/$yr/*
 cd ..

done


