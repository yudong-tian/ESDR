
! Aggregate 30min CMORPH data to monthly 

	program read8km

        integer, parameter :: nc=4948, nr=1649
        integer, parameter :: dt0 = 60*60   ! hourly data file 
        integer :: iyr, imo, ic, ir
        character*250 zipfile
        character*2 cmon, cdy, chr
        character*4 cyear

       ! time management
        integer st(9), et(9), fmktime, tout(9)
        ! start/end date
        integer :: syr, smon, sdy, eyr, emon, edy

        real rain00(nc, nr), rain30(nc, nr)
        real rsum(nc, nr)
        integer ::  cnt(nc, nr)


! data range: 20030101 - 20131231
       !syr = 2003
       !smon = 1 
       syr = 2008
       smon = 5 
       sdy = 1 

       eyr = 2013
       emon = 12 
       edy = 31 

        st=0
        et=0

        st(6) = syr-1900
        st(5) = smon -1
        st(4) = sdy
        st(3) = 0

        et(6) = eyr-1900
        et(5) = emon -1
        et(4) = edy
        et(3) = 23

        rsum = 0.0
        cnt = 0  
     !-------------------------------------------------------  
     do it =fmktime(st), fmktime(et), dt0
        call gmtime(it, tout)  !
        write(cyear, '(I4.4)') tout(6) + 1900
        write(cmon, '(I2.2)') tout(5) + 1
        write(cdy, '(I2.2)') tout(4)
        write(chr, '(I2.2)') tout(3)

      ! starting from 2008051820, there is an "e" in "interp"
      !  date +%s -d "18 May 2008 20:00:00"
      !   1211155200
      if ( it .LT. 1211155200 ) then 
	zipfile= & 
         "/home/ytian/proj-disk/MET_FORCING/CMORPH-zip/" &
          // cyear // cmon // "/advt-8km-intrp-prim-sat-spat-2lag-2.5+5dovlp8kmIR-" &
         // cyear // cmon // cdy // chr //".Z"

      else 
	zipfile= & 
         "/home/ytian/proj-disk/MET_FORCING/CMORPH-zip/" &
          // cyear // cmon // "/advt-8km-interp-prim-sat-spat-2lag-2.5+5dovlp8kmIR-" &
         // cyear // cmon // cdy // chr //".Z"
      end if
      write(*, *) trim(zipfile) 

        call rdcmorph8km(zipfile, rain00, rain30)

        Do ir=1, nr 
          Do ic =1, nc 
            if (rain00(ic, ir) .ge. 0 ) then 
               rsum(ic, ir) = rsum(ic, ir) + rain00(ic, ir) 
               cnt(ic, ir) = cnt(ic, ir) + 1
            end if 
            if (rain30(ic, ir) .ge. 0 ) then 
               rsum(ic, ir) = rsum(ic, ir) + rain30(ic, ir) 
               cnt(ic, ir) = cnt(ic, ir) + 1
            end if 
          End do 
        End do 

        ! reaching the end of month? 
        call gmtime(it+dt0, tout)  !
        ! =======================================
        IF (tout(4) .eq. 1 .and. tout(3) .eq. 0 )  then  ! day=1, hr=00:00
          Do ir=1, nr 
             Do ic =1, nc 
                if (cnt(ic, ir) .GT. 0 ) then 
                   rsum(ic, ir) = rsum(ic, ir) / real(cnt(ic, ir)) ! mean, mm/h
                else 
                   rsum(ic, ir) = -9999.0
                end if 
             End do 
          End do 

          write(*, *) "saving monthly mean to : monthly/"//cyear//cmon
          open(12, file="monthly/"//cyear//cmon, access="direct", &
              form="unformatted", recl=nc*nr*4)
              write(12, rec=1) rsum 
          close(12) 
          rsum = 0.0
          cnt = 0
        END IF  
        ! =======================================
        
     end do   !it
     !-------------------------------------------------------  

        stop 
        end 


! $Id: aggr-to-monthly.F90,v 1.3 2014/09/01 08:36:22 ytian Exp ytian $
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
        character*250 zipfile
	real rain00(nc, nr), rain30(nc, nr) 
        character*1 array(nc, nr, 4)    ! for holding the first 4 records
        integer readzipf, dlen, rdlen, i, j, r00, r30

        dlen=nc*nr*4

        rdlen = readzipf(trim(zipfile)//char(0), array, dlen)

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



