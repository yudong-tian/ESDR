
! Extract Tb for a list of locations, instead of a single grid box or a continuous area. 
! Assemble Tbs for 6 frequencies, for a given polarization (V|H), descending/ascending (D|A), 
!  grid point (lat, lon), and time period, 
! from raw .gz files and covert to real numbers, and save in a binary file.  
! Usage: 
! ./Tb-spectra <V|H> <A|D> <syr> <smon> <sdy> <eyr> <emon> <edy> <locationfile> 
!                
! Arguments: 
! <V|H>: polarization
! <A|D>: ascending/descending 
! <syr> <smon> <sdy> <eyr> <emon> <edy>: start/end year/month/day
! <locationfile>: text file containing location name and lat/lon. Example: 
!
!  Wetland	-18.0	-57.0
!  SGP		35.0	-97.0
!
!  One file is saved for each location/polarization/pass combination, such as:
!  Wetland-HA.6gd4r.  



	program tbspectra 

        integer, parameter :: nc=1440, nr=720, nf=6, maxloc=10000
        ! Original data were yrev, but flip it in rdtb2(), so now no yrev. 
        real, parameter :: lat0=-89.875, lon0=-179.875, res=0.25
        integer, parameter :: dt0 = 24*60*60   ! 24hr time resolution (sec)

        integer :: i, iargc, nrec
        character*200 locfile, outfile, ctmp
        character*20  locid(maxloc)
        integer ic(maxloc), ir(maxloc), iloc, nloc, jf, ir0
        character*1 pflag, oflag      ! polarization and orbit  flags
        real :: tb(nc, nr, nf), freqs(nf)
        real, allocatable :: otb(:, :, :)    ! for output, (nf, nt, nloc) 
        ! time management
        integer st(9), et(9), fmktime, it, ierr, sts, ets, nt
        ! start/end date
        integer :: syr, smon, sdy, eyr, emon, edy
        real :: lat, lon

        data freqs /6.925, 10.65, 18.7, 23.8, 36.5, 89.0/

        i =  iargc()
        If (i.NE.9) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), &
            "  <V|H> <A|D> <syr> <smon> <sdy> <eyr> <emon> <edy> <locationfile> "
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
       call getarg(9, locfile)

       open(15, file=locfile, form="formatted")
        Do iloc=1, maxLoc
          read(15, *, iostat=ierr) locid(iloc), lat, lon
          !write(*, *) "ierr=", ierr, " locid=", locid(iloc), lat, lon
          if (ierr .NE. 0 ) exit
          ic(iloc) = nint( (lon - lon0)/res + 1 )
          ir0  = nint( (-lat0-lat)/res + 1 )
          ir(iloc) = nr - ir0 + 1   ! to avoid different roundoffs from Tb-spectra.F90 
          write(*, *) " locid=", locid(iloc), " ic=", ic(iloc), " ir=", ir(iloc), " ir0=", ir0 
        end do
        nloc=iloc-1
        write(*, *)"Total locations: ", nloc, iloc

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

      sts=fmktime(st)
      ets=fmktime(et)
      nt = (ets-sts)/dt0+1

      allocate(otb(nf, nt, nloc)) 

      nrec=1
      DO it =sts, ets, dt0 
        call rdtb2(it, tb, nc, nr, pflag, oflag)
        Do iloc=1, nloc
         do jf=1, nf
          otb(jf, nrec, iloc) = tb(ic(iloc), ir(iloc), jf) 
         end do 
        End do 
        nrec=nrec+1
      END DO 
      write(*, *)"nt=", nt, " nrec=", nrec

      ! Save output

      Do iloc=1, nloc
        outfile="locations/"//trim(locid(iloc))//"-"//pflag//oflag//".6gd4r"
        open(12, file=outfile, access="direct",form="unformatted", recl=nf*nt*4) 
          write(12, rec=1) otb(:, :, iloc)  
        close(12) 
      End Do 

      stop 
      end 


    subroutine rdtb2(it, tb, nc, nr, pflag, oflag) 
        !integer, parameter :: nc=1440, nr=720, nf=6
        integer, parameter :: nf=6
        integer :: nc, nr
        integer, parameter :: dt0 = 24*60*60 
        integer :: it, j, jf, tout(9), day1(9), it0, doy, fmktime
        real :: tb(nc, nr, nf), tb0(nc, nr) 
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

        Do jf=1, nf
         ! e.g.: ID2r1-AMSRE-D.252009244A.v03.06V.gz
         zipfile = cyear // "/ID2r1-AMSRE-D.25"//cyear//cdoy//oflag//".v03." &
                   //cfreqs(jf)//pflag//".gz"
         write(*, *)"Reading ", trim(zipfile)
         call rdtb(zipfile, tb0)
         ! reverse y-direction 
         Do j=1, nr
           tb(:, j, jf) = tb0(:, nr-j+1) 
         End Do
        End Do

   return
   end

! $Id: Tb-spectra-locations.F90,v 1.2 2012/04/27 16:25:25 ytian Exp ytian $ 
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



