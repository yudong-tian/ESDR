
! Compute MPDI at 36G on the global scale
! for JJA 2003-2011 and DJF 2002-2009. 


	program tbspectra 

        integer, parameter :: nc=1440, nr=720, nf=6
        ! Original data were yrev, but flip it in rdtb2(), so now no yrev. 
        integer, parameter :: dt0 = 24*60*60   ! 24hr time resolution (sec)

        integer :: nrec
        character*200 ctmp
        character*1 oflag(2), pass    ! polarization and orbit  flags
        real :: tb18h(nc, nr), tb18v(nc, nr)
        real :: mpdi18(nc, nr)
        real :: freqs(nf)
        ! time management
        integer ::  date2esec, iyear 
        ! start/end date
        integer :: it, ip

        data freqs /6.925, 10.65, 18.7, 23.8, 36.5, 89.0/
        data oflag /"A", "D"/ 

    Do ip = 1, 2  ! A and D passes 
      ! DJF: 2002-2010
      ctmp = "output/DJF_" // oflag(ip)
      pass = oflag(ip) 
      open(12, file=trim(ctmp) // "_mpdi18.1gd4r", access="direct",form="unformatted", &
               recl=nc*nr*4) 
      nrec=1

      do iyear=2002, 2010 
        do it=date2esec(iyear, 12, 1, 0, 0, 0), date2esec(iyear+1, 2, 28, 0, 0, 0), dt0 
         call rdtb2(it, tb18h, nc, nr, "18H", pass) 
         call rdtb2(it, tb18v, nc, nr, "18V", pass) 
         call compute_mpdi18(tb18h, tb18v, nc, nr, mpdi18) 

         write(12, rec=nrec) mpdi18
         nrec=nrec+1
        end do ! it
      end do  ! iyear
      close(12) 

      ! JJA: 2003-2011
      ctmp = "output/JJA_" // oflag(ip)
      pass = oflag(ip)
      open(22, file=trim(ctmp) // "_mpdi18.1gd4r", access="direct",form="unformatted", &
               recl=nc*nr*4)
      nrec=1

      do iyear=2003, 2011
        do it=date2esec(iyear, 6, 1, 0, 0, 0), date2esec(iyear, 8, 31, 0, 0, 0), dt0
         call rdtb2(it, tb18h, nc, nr, "18H", pass)
         call rdtb2(it, tb18v, nc, nr, "18V", pass)
         call compute_mpdi18(tb18h, tb18v, nc, nr, mpdi18) 

         write(22, rec=nrec) mpdi18
         nrec=nrec+1
        end do ! it
      end do  ! iyear
      close(22)

    End Do  ! ip 

      stop 
      end 

    subroutine compute_mpdi18(tb18h, tb18v, nc, nr, mpdi18) 
	integer :: nc, nr, i, j
        real :: tb18h(nc, nr), tb18v(nc, nr)
        real :: mpdi18(nc, nr)
	real :: h18, v18

        mpdi18 = -9999.0

	Do j=1, nr
	  Do i=1, nc
           h18=tb18h(i, j) 
           v18=tb18v(i, j) 
	   if (h18 > 10 .and. v18 > 10) then 
             mpdi18(i, j) = (v18 - h18) / (v18 + h18) * 600.0
           end if 
         End do 
       End do 

    return 
    end 

    subroutine rdtb2(it, tb, nc, nr, chan, pass) 
        !integer, parameter :: nc=1440, nr=720, nf=6
        integer :: nc, nr
        integer, parameter :: dt0 = 24*60*60 
        integer :: it, j, iy, im, id, ihr, imn, isc, date2esec, doy 
        real :: tb(nc, nr), tb0(nc, nr) 
        character*3 :: chan 
        character*1 :: pass 
        character*200 zipfile
        character*4 cyear
        character*3 cdoy


        call esec2date(it, iy, im, id, ihr, imn, isc) 

        doy = (it - date2esec(iy, 1, 1, 0, 0, 0))/dt0 + 1

        write(cyear, '(I4.4)') iy 
        write(cdoy, '(I3.3)') doy 

         ! e.g.: ID2r1-AMSRE-D.252009244A.v03.06V.gz
         zipfile = "/home/ytian/lswg/AMSR_E_TB/" // cyear &
                // "/ID2r1-AMSRE-D.25"//cyear//cdoy//pass//".v03." &
                // chan // ".gz"
         write(*, *)"Reading ", trim(zipfile)
         call rdtb(zipfile, tb0)
         ! reverse y-direction 
         Do j=1, nr
           tb(:, j) = tb0(:, nr-j+1) 
         End Do

   return
   end

! $Id: global-mpdi18.F90,v 1.1 2013/03/12 21:50:23 ytian Exp ytian $ 
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

        rdlen = readzipf(trim(zipfile)//char(0), array, dlen)

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



