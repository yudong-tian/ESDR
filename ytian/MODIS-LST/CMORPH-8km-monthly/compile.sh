cc -c readzipf.c 
cc -c fmktime.c
ifort -convert big_endian -assume byterecl -o aggr-to-monthly aggr-to-monthly.F90 readzipf.o fmktime.o
