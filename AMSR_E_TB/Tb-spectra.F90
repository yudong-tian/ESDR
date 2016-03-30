
! Assemble Tbs for 6 frequencies, for a given polarization (V|H), descending/ascending (D|A), 
!  grid point (lat, lon), and time period, 
! from raw .gz files and covert to real numbers, and save in a binary file.  
! Usage: 
! ./Tb-spectra <V|H> <A|D> <syr> <smon> <sdy> <eyr> <emon> <edy> <lat> <lon> <outfile>
!                
! Arguments: 
! <V|H>: polarization
! <A|D>: ascending/descending 
! <syr> <smon> <sdy> <eyr> <emon> <edy>: start/end year/month/day
! <lat> <lon>: location 
! <outfile>: output file name


	program tbspectra 

        integer, parameter :: nc=1440, nr=720, nf=6
        real, parameter :: lat0=89.875, lon0=-179.875, res=0.25
        integer, parameter :: dt0 = 24*60*60   ! 24hr time resolution (sec)

        integer :: i, iargc, nrec
        character*200 outfile, ctmp
        character*1 pflag, oflag      ! polarization and orbit  flags
        real tb(nf), freqs(nf)
        ! time management
        integer st(9), et(9), fmktime
        ! start/end date
        integer :: syr, smon, sdy, eyr, emon, edy
        real :: lat, lon
        integer :: nc1, nr1, it


        data freqs /6.925, 10.65, 18.7, 23.8, 36.5, 89.0/

        i =  iargc()
        If (i.NE.11) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), &
            "  <V|H> <A|D> <syr> <smon> <sdy> <eyr> <emon> <edy> <lat> <lon> <outfile>"
          Stop
        End If

       call getarg(1, pflag)
       call getarg(2, oflag)

       call getarg(3, ctmp)
       read(ctmp, *) syr
       call getarg(4, ctmp)
       read(ctmp, *) smon
       call getarg(5, ctmp)
       read(ctmp, *) sdy
       call getarg(6, ctmp)
       read(ctmp, *) eyr
       call getarg(7, ctmp)
       read(ctmp, *) emon
       call getarg(8, ctmp)
       read(ctmp, *) edy
! lat/lon subregion
       call getarg(9, ctmp)
       read(ctmp, *) lat
       call getarg(10, ctmp)
       read(ctmp, *) lon
! output file name
       call getarg(11, ctmp)
       outfile = trim(ctmp)

! locate the point in the grid. (1, 1) is (89.875, -179.875)
      nr1 = nint( (lat0 - lat)/res + 1)
      nc1 = nint( (lon - lon0)/res + 1)
      write(*, *)"nc1=", nc1, " nr1=", nr1

! Time span
        st=0
        et=0
        st(6) = syr-1900
        st(5) = smon -1
        st(4) = sdy
        st(3) = 0

        et(6) = eyr-1900
        et(5) = emon -1
        et(4) = edy
        et(3) = 0

      open(12, file=outfile, access="direct",form="unformatted", recl=nf*4)

      nrec=1
      do it =fmktime(st), fmktime(et), dt0
        call rdtb2(it, tb, nc1, nr1, pflag, oflag) 
        write(12, rec=nrec) tb 
        nrec=nrec+1
      end do 
      close(12) 
      stop 
      end 


    subroutine rdtb2(it, tb, nc1, nr1, pflag, oflag) 
        integer, parameter :: nc=1440, nr=720, nf=6
        integer, parameter :: dt0 = 24*60*60 
        integer :: it, nc1, nr1, j, tout(9), day1(9), it0, doy, fmktime
        real :: tb (nf), tb0(nc, nr) 
        character*1  pflag, oflag
        character*200 zipfile
        character*4 cyear
        character*3 cdoy
        character*2 cfreqs(nf) 

        data cfreqs /"06", "10", "18", "23", "36", "89"/ 


        call gmtime(it, tout)
        ! set day 1 as 1/1/year
        day1 = tout 
        day1(5)  = 0   ! Jan
        day1(4)  = 1   ! 1 st 


        it0 = fmktime(day1)
        write(*, *) tout(6)+1900, tout(5), tout(4), it, it0
        doy = (it - it0)/dt0 + 1
        write(*, *)"tout(6)=", tout(6),  " Doy=", doy
        write(cyear, '(I4.4)') tout(6) + 1900
        write(cdoy, '(I3.3)') doy 

        Do j=1, nf
         ! e.g.: ID2r1-AMSRE-D.252009244A.v03.06V.gz
         zipfile = cyear // "/ID2r1-AMSRE-D.25"//cyear//cdoy//oflag//".v03." &
                   //cfreqs(j)//pflag//".gz"
         write(*, *)"Reading ", trim(zipfile)
         call rdtb(zipfile, tb0)
         tb(j) = tb0(nc1, nr1)
        End Do

   return
   end

! $Id: Tb-spectra.F90,v 1.2 2011/05/04 18:48:23 ytian Exp ytian $ 
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
        integer readzipf, dlen, rdlen,  i, j,  id

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
                     ichar(carray(id*2) ) ) * 0.1   ! to K
         End Do 
        End Do 

     return
     end 



