
! Compute Tb difference from 6GHz for each frequency
!   given the raw Tb files 
! Usage: 
! ./Tb-diff <nrec> <infile> <outfile> 
!                
! Arguments: 
! <nrec>:  number of records (days) 
! <infile>:  input file name
! <outfile>: output file name


	program tbdiff

        integer, parameter :: nf=6

        integer :: i, iargc, nrec
        character*200 infile, outfile, ctmp
        real :: freqs(nf), dtb(nf)
        real, allocatable :: tb(:, :)
        ! start/end date
        integer :: syr, smon, sdy, eyr, emon, edy
        real :: tbs
        integer :: jf, it, n1, n2, cnt


        data freqs /6.925, 10.65, 18.7, 23.8, 36.5, 89.0/

        i =  iargc()
        If (i.NE.3) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), &
            " <nrec> <infile> <outfile>"
          Stop
        End If

       call getarg(1, ctmp)
       read(ctmp, *) nrec 
! in/output file name
       call getarg(2, infile)
       call getarg(3, outfile) 

      allocate(tb(nf, nrec))

      open(11, file=infile, access="direct",form="unformatted", recl=nf*4)
      open(12, file=outfile, access="direct",form="unformatted", recl=nf*4)

      do it =1, nrec 
        read(11, rec=it) tb(:, it) 
        do jf = 1, nf
         if (tb(jf, it) .GT. 0 ) then 
            dtb(jf) = tb(jf, it) - tb(1, it)
         else 
            dtb(jf) = -9999.0 
         end if
        end do 
           
        write(12, rec=it) dtb(:) 
      end do 
      close(11) 
      close(12) 

      deallocate(tb)
      stop 
      end 

