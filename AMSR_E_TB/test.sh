


cd Read-Z-file
cc -c readzipf.c 
cd ..
cc -c fmktime.c
ifort -warn -convert big_endian -assume byterecl -o Tb-spectra-area Tb-spectra-area.F90 readzipf.o fmktime.o
