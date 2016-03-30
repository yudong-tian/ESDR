
ifort -convert big_endian -assume byterecl -o global-mpdi18 global-mpdi18.F90 /home/ytian/lib/Read-Z-file/readzipf.o /home/ytian/lib/fmktime/fmktime.a -lz
exit

ifort -convert big_endian -assume byterecl -o global-mpdi36 global-mpdi36.F90 /home/ytian/lib/Read-Z-file/readzipf.o /home/ytian/lib/fmktime/fmktime.a -lz

exit 

ifort -convert big_endian -assume byterecl -o mean_stdev mean_stdev.F90

ifort -convert big_endian -assume byterecl -o global-4-indices global-4-indices.F90 /home/ytian/lib/Read-Z-file/readzipf.o /home/ytian/lib/fmktime/fmktime.a -lz
