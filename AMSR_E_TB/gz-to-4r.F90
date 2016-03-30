
! Read AMSR-E TB data from raw .gz files and covert to real numbers. 

	program gz24r

        integer, parameter :: nc=1440, nr=720
        integer :: i, iargc
        character*200 zipfile, outfile, ctmp
        real tb(nc, nr)

        i =  iargc()
        If (i.NE.2) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), &
            " <inputfile> <outputfile>"
          Stop
        End If

       call getarg(1, ctmp)
       zipfile = trim(ctmp)
       call getarg(2, ctmp)
       outfile = trim(ctmp)

        call rdtb(zipfile, tb) 

        open(12, file=outfile, access="direct", &
            form="unformatted", recl=nc*nr*4)
          write(12, rec=1) tb 
        close(12) 
        stop 
        end 


! $Id: gz-to-4r.F90,v 1.1 2011/05/03 21:41:10 ytian Exp ytian $ 
! Subroutine to read AMSR-E 0.25-deg global Tb data from a ".gz" file directly,
!  without  uncompressing the file. 
! Each .gz file contains a 1440*720 array of two-byte unsigned integers, 
!  little-endian byte order. 
! The raw data are flipped to big-endian before converting to real numbers.  
! Inputs: 
!   zipfile: the name of the gz file, 200-character long
!
! Outputs: 
!   tb(): 2-D array of real*4 for Tb (K). Missing data is 0. 

    subroutine rdtb(zipfile, tb) 
        integer, parameter :: nc=1440, nr=720
        character*200 zipfile
	real tb(nc, nr) 
        integer*2 :: array(nc, nr) ! for holding the raw 2-byte data 
        character*1 carray(nc*nr*2), ctmp
        integer readzipf, dlen, rdlen, i, j, r00, r30, id

	equivalence (array, carray)

        dlen=nc*nr*2

        rdlen = readzipf(zipfile, array, dlen)

        if (rdlen .NE. dlen) then 
	  write(*, *)"rdlen=", rdlen, " Zipfile reading error: ", zipfile 
	  tb = 0.0 
          return
        end if 

        ! flip little-endian to big
        Do i=1, nc*nr
           ctmp = carray(i*2-1)
           carray(i*2-1) = carray(i*2) 
           carray(i*2) = ctmp
        End Do
        
        Do j=1, nr
         Do i=1, nc 
          id = i + (j-1)* nc
          tb(i, j) = ( ichar(carray(id*2-1) ) * 256.0 + &
                     ichar(carray(id*2) ) ) * 0.1  ! to K
         End Do 
        End Do 

     return
     end 



