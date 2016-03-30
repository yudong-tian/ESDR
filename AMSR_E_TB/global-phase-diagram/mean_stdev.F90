
! $Id: mean_stdev.F90,v 1.4 2013/03/11 17:37:57 ytian Exp ytian $
! Compute the  mean and standard deviation giving a data file 
! Usage: 
! mean_stdev DJF_A_mpdi.1gd4r
! Output: 
! mean_DJF_A_mpdi.1gd4r
! stdev_DJF_A_mpdi.1gd4r
! Missing or undefined data are flagged as -9999.0. 
! Verification: verify_mean_stdev.gs
! Simple verification: 

!ga-> open DJF_A_mpdi.ctl
!ga-> set t 1 810
!ga-> set lat 35
!ga-> set lon -97
!ga-> set gxout stat
!ga-> d mpdi
!Data Type = grid
!Dimensions = 3 -1
!I Dimension = 1 to 810 Linear 00Z01DEC2002 1440mn
!J Dimension = -999 to -999
!Sizes = 810 1 810
!Undef value = -9.99e+08
!Undef count = 256  Valid count = 554
!Min, Max = 6.51787 29.8448
!Cmin, cmax, cint = 4 32 2
!Stats[sum,sumsqr,root(sumsqr),n]:     7756.68 115654 340.079 554
!Stats[(sum,sumsqr,root(sumsqr))/n]:     14.0012 208.762 14.4486
!Stats[(sum,sumsqr,root(sumsqr))/(n-1)]: 14.0266 209.139 14.4616
!Stats[(sigma,var)(n)]:     3.5675 12.7271
!Stats[(sigma,var)(n-1)]:   3.57072 12.7501
!ga-> open mean_DJF_A_mpdi
!ga-> open stdev_DJF_A_mpdi
!ga-> d mean.2(t=1)
!Result value = 14.0012
!ga-> d stdev.3(t=1)
!Result value = 3.57072



	program meanstdev 

        integer, parameter :: nc=1440, nr=720, maxnt=4000
        integer :: nt       ! time steps: 810 for DJF and 828 for JJA 

        integer :: nrec, iargc, ierr 
        character*200 ctmp, infile
        real :: rdata(nc, nr), meank(nc, nr), stdevk(nc, nr)  
        real :: meank_1(nc, nr), stdevk_1(nc, nr), xk
        integer :: cnt(nc, nr) 
        integer :: it, ip, i, k


        i =  iargc()
        If (i.NE.1) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), " <input_file>" 
          Stop
        End If

        call getarg(1, infile) 
        
      open(12, file=infile, access="direct",form="unformatted", &
               recl=nc*nr*4) 

      ! one-pass implementation per http://en.wikipedia.org/wiki/Standard_deviation
      ! also perAhttp://www.johndcook.com/standard_deviation.html:
      ! "This better way of computing variance goes back to a 1962 paper by 
      ! B. P. Welford and is presented in Donald Knuth's Art of Computer Programming, 
      !  Vol 2, page 232, 3rd edition."

      meank_1 = 0.0 
      meank = -9999.0 
      stdevk_1 = 0.0 
      stdevk = -9999.0 
      cnt = 0
      nt = 0 

      Do it=1, maxnt 
        read(12, rec=it, iostat=ierr) rdata
        if (ierr .ne. 0 ) exit 
        Do j=1, nr 
         Do i=1, nc 
           if (rdata(i, j) .GT. -9999.0) then 
              cnt(i, j) = cnt(i, j) + 1
              k=cnt(i, j) 
              xk = rdata(i, j) 
              meank(i, j)=meank_1(i, j) + (xk-meank_1(i, j) )/real(k) 
              stdevk(i, j) = stdevk_1(i, j) +  &
                     (xk - meank_1(i, j))*(xk - meank(i, j)) 

              meank_1 (i, j) = meank(i,  j) 
              stdevk_1 (i, j) = stdevk(i, j) 
           end if 
         End do  ! i
        End Do  ! j
       End Do   ! it

       write(*, *) "Total time steps read from file: ", it-1
       close(12) 
        Do j=1, nr 
         Do i=1, nc 
          if (cnt(i, j) .GE. 2) then  
            stdevk(i, j) = sqrt(  (stdevk(i, j) / real( cnt(i, j) -1 ) ) )
          else 
            stdevk(i, j) = -9999.0 
          end if 
         End do  ! i
        End Do  ! j

      open(21, file="mean_"//trim(infile), access="direct",form="unformatted", &
               recl=nc*nr*4) 
        write(21, rec=1) meank
      close(21)

      open(23, file="stdev_"//trim(infile), access="direct",form="unformatted", &
               recl=nc*nr*4) 
        write(23, rec=1) stdevk
      close(23)

      open(25, file="cnt_"//trim(infile), access="direct",form="unformatted", &
               recl=nc*nr*4) 
        write(25, rec=1) real(cnt) 
      close(25)

      stop 
      end 

