
! Compute "climatology"  of Tb for each frequency, with running average, 
!   given the raw Tb files 
! Usage: 
! ./Tb-clim <nrec> <infile> <outfile> 
!                
! Arguments: 
! <nrec>:  number of records (days) 
! <infile>:  input file name
! <outfile>: output file name


	program tbclim

        integer, parameter :: nf=6, nd=10  ! days back/forth in running avg.

        integer :: i, iargc, nrec
        character*200 infile, outfile, ctmp
        real :: freqs(nf)
        real, allocatable :: tb(:, :), ctb(:, :)
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
      allocate(ctb(nf, nrec))

      open(11, file=infile, access="direct",form="unformatted", recl=nf*4)

      do it =1, nrec 
        read(11, rec=it) tb(:, it) 
        !if (tb(1, it) .GT. 0.0) write(*, '(I4, F10.2)') it, tb(1, it) 
      end do 
      close(11) 

      do jf=1, nf
        do it=1, nrec
          ! bracket of running average
          n1 = max(1, it-nd)
          n2 = min(nrec, it+nd)   
          write(*, *)"n1=", n1, " n2=", n2
          tbs = 0.0 
          cnt = 0
          do i=n1, n2
           if (tb(jf, i) .GT. 0.0) then
              tbs = tbs + tb(jf, i)
              cnt = cnt + 1
           end if
          end do
          ctb(jf, it) = tbs / cnt
        end do
      end do 

      open(12, file=outfile, access="direct",form="unformatted", recl=nf*4)
      do it = 1, nrec
        write(12, rec=it) ctb(:, it)
      end do 
      close(12)

      deallocate(tb)
      deallocate(ctb)
      stop 
      end 

