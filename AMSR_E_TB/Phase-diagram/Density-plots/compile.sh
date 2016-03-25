
ifort  -g -u -traceback -fpe0 -nomixed_str_len_arg -names lowercase -convert big_endian -assume byterecl -o bin-MPDI-Tb36V bin-MPDI-Tb36V.F90

exit 

ifort  -g -u -traceback -fpe0 -nomixed_str_len_arg -names lowercase -convert big_endian -assume byterecl -o dump-lai-smc-as-txt dump-lai-smc-as-txt.F90

ifort  -g -u -traceback -fpe0 -nomixed_str_len_arg -names lowercase -convert big_endian -assume byterecl -o F13-bin-smc-lai F13-bin-smc-lai.F90

