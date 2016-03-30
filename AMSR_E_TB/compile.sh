


cd Read-Z-file
cc -c readzipf.c 
cd ..
cc -c fmktime.c
ifort -warn -convert big_endian -assume byterecl -o Tb-spectra-locations Tb-spectra-locations.F90 readzipf.o fmktime.o
ifort -warn -convert big_endian -assume byterecl -o Tb-spectra-area Tb-spectra-area.F90 readzipf.o fmktime.o
ifort -warn -convert big_endian -assume byterecl -o Tb-spectra Tb-spectra.F90 readzipf.o fmktime.o

exit 

ifort -warn -convert big_endian -assume byterecl -o gz-to-4r gz-to-4r.F90 readzipf.o 
ifort -warn -convert big_endian -assume byterecl -o gz-to-4r-TIM gz-to-4r-TIM.F90 readzipf.o 

ifort -warn -convert big_endian -assume byterecl -o to-local-TIM to-local-TIM.F90
ifort -warn -convert big_endian -assume byterecl -o Tb-diff Tb-diff.F90 
ifort -warn -convert big_endian -assume byterecl -o Tb-clim Tb-clim.F90 
