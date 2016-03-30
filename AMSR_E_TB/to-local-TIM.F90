
! Read AMSR-E TIM data from raw .gz files and covert to real numbers. 
!  TIM data are two-byte signed int, TB data are two-byte unsigned int.

	program gz24r

        integer, parameter :: nc=1440, nr=720
        real, parameter :: lat0=89.875, lon0=-179.875, res=0.25
        real :: lon, toff
        integer :: i, j, iargc
        character*200 infile, outfile, ctmp
        real tb(nc, nr)

        i =  iargc()
        If (i.NE.2) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), &
            " <inputfile> <outputfile>"
          Stop
        End If

       call getarg(1, ctmp)
       infile = trim(ctmp)
       call getarg(2, ctmp)
       outfile = trim(ctmp)

        open(12, file=infile, access="direct", &
            form="unformatted", recl=nc*nr*4)
           read(12, rec=1) tb 
        close(12) 
! locate the point in the grid. (1, 1) is (89.875, -179.875)
      Do i=1, nc
       lon  = lon0 + (i-1) * res 
       toff = lon /15.0 * 60.0   ! minutes in UTC offset 
       Do j=1, nr
         if (tb(i, j) .GE. 0 ) then 
             tb(i, j) = tb(i, j) + toff
             if (tb(i, j) .LT. 0 ) tb(i, j) = tb(i, j) + 24*60.0 ! add 24-hours   
             if (tb(i, j) .GE. 1440 ) tb(i, j) = tb(i, j) - 24*60.0 ! minus 24-hours   
         end if
       End Do 
      End Do 

        open(14, file=outfile, access="direct", &
            form="unformatted", recl=nc*nr*4)
          write(14, rec=1) tb 
        close(14) 
        stop 
        end 


