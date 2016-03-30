
! test main program 

	program read8km

        integer, parameter :: nc=4948, nr=1649
        character*200 zipfile
        real rain00(nc, nr), rain30(nc, nr)

	zipfile= & 
         "test-data/advt-8km-intrp-prim-sat-spat-2lag-2.5+5dovlp8kmIR-2005083118.Z"
        call rdcmorph8km(zipfile, rain00, rain30)
        open(12, file="test-data/2005083118.2gd4r", access="direct", &
            form="unformatted", recl=nc*nr*4)
          write(12, rec=1) rain00
          write(12, rec=2) rain30
        close(12) 
        stop 
        end 


! $Id: rdcmorph8km.F90,v 1.1 2010/08/20 15:25:14 ytian Exp $
! Subroutine to read CMORPH 8km data from a ".Z" file directly, without
!  uncompressing the file. 
! Each .Z file contains 6 records, each record has 4948*1649 bytes. 
! The 1st and 4th records are rainfall data over the global grid
! for top and bottom half of the hour, respectively. 
! Inputs: 
!   zipfile: the name of the *Z file, 200-character long
!
! Outputs: 
!   rain00(), rain30(): 2-D array of real*4 for global rain rate (mm/hr)
!                       from east to west, south to north
!			for top and bottom half of the hour, respectively
!  Grid:		XDEF 4948 LINEAR   0.036378335 0.072756669
!			YDEF 1649 LINEAR -59.963614    0.072771377



    subroutine rdcmorph8km(zipfile, rain00, rain30) 
        integer, parameter :: nc=4948, nr=1649
        character*200 zipfile
	real rain00(nc, nr), rain30(nc, nr) 
        character*1 array(nc, nr, 4)    ! for holding the first 4 records
        integer readzipf, dlen, rdlen, i, j, r00, r30

        dlen=nc*nr*4

        rdlen = readzipf(zipfile, array, dlen)

        if (rdlen .NE. dlen) then 
	  write(*, *)"rdlen=", rdlen, " CMORPH-8KM Zipfile reading error ... assign undef now" 
	  rain00 = -9999.0 
	  rain30 = -9999.0 
          return
        end if 

        Do j=1, nr
         Do i=1, nc 
           r00 = ichar(array(i, nr-j+1, 1))   !flip N/S
           r30 = ichar(array(i, nr-j+1, 4))
           rain00(i, j) = real(r00)*0.2       !convert to mm/h 
           rain30(i, j) = real(r30)*0.2       !convert to mm/h 
           if (r00 .eq. 255) rain00(i, j) = -9999.0
           if (r30 .eq. 255) rain30(i, j) = -9999.0
         End Do 
        End Do 

     return
     end 



