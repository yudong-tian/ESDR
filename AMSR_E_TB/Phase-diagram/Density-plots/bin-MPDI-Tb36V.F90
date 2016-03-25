
! $Id: bin-MPDI-Tb36V.F90,v 1.2 2012/09/27 19:48:04 ytian Exp ytian $ 
! Program to generate density data for the regime diagram. 
!  
! ./bin-MPDI-Tb36V.F90 <loc_name>
!
! Arguments:
! <loc_name>: name of location (e.g., "Rockies", "Ocean4"), which will correspond to
!   .6gd4ra files of
!      loc_name-HA-7yr.6gd4r
!      loc_name-HD-7yr.6gd4r
!      loc_name-VA-7yr.6gd4r
!      loc_name-VD-7yr.6gd4r
! <ddir>:.6gd4ra directory under which those.6gd4ra files are located.
! Ouput:
!  sensity data saved in two files:
!   loc_name-A.1gd4r 
!   loc_name-D.1gd4r 


	Program sensi

  implicit NONE

        integer, parameter :: nt=2557, ny=8
        integer, parameter :: nxbin=100, nybin=100  ! bins to hold the densities 
        character*200, parameter :: ddir="/home/ytian/lswg/AMSR_E_TB/locations"

        integer :: densi_A(0:nxbin-1, 0:nybin-1), densi_D(0:nxbin-1, 0:nybin-1) 
        integer :: i, iargc, nrec
        character*80 outfA, outfD, ctmp, loc_name
        real :: V6A(nt), V10A(nt), V18A(nt), V23A(nt), V36A(nt), V89A(nt)
        real :: H6A(nt), H10A(nt), H18A(nt), H23A(nt), H36A(nt), H89A(nt)
        real :: V6D(nt), V10D(nt), V18D(nt), V23D(nt), V36D(nt), V89D(nt)
        real :: H6D(nt), H10D(nt), H18D(nt), H23D(nt), H36D(nt), H89D(nt)
        real :: x, y, xmin, xmax, ymin, ymax
        real :: mpdi, tb36v
        integer :: nc1, nr1, it, irec, ts1, ts2, j, k

        xmin = 0
        xmax = 65
        ymin = 210
        ymax = 310

        i =  iargc()
        If (i.LT.1) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), &
            " <loc_name> " 
          Stop
        End If

       call getarg(1, loc_name)

      open(12, file=trim(ddir) // "/" // trim(loc_name) // "-HA.6gd4r", &
             access="direct",form="unformatted", recl=6*4)
      Do it=1, nt
        read(12, rec=it) H6A(it), H10A(it), H18A(it), H23A(it), H36A(it), H89A(it)
      End Do
      close(12)

      open(14, file=trim(ddir) // "/" // trim(loc_name) // "-HD.6gd4r", &
             access="direct",form="unformatted", recl=6*4)
      Do it=1, nt
        read(14, rec=it) H6D(it), H10D(it), H18D(it), H23D(it), H36D(it), H89D(it)
      End Do
      close(14)

      open(16, file=trim(ddir) // "/" // trim(loc_name) // "-VA.6gd4r", &
             access="direct",form="unformatted", recl=6*4)
      Do it=1, nt
        read(16, rec=it) V6A(it), V10A(it), V18A(it), V23A(it), V36A(it), V89A(it)
      End Do
      close(16)

      open(18, file=trim(ddir) // "/" // trim(loc_name) // "-VD.6gd4r", &
             access="direct",form="unformatted", recl=6*4)
      Do it=1, nt
        read(18, rec=it) V6D(it), V10D(it), V18D(it), V23D(it), V36D(it), V89D(it)
      End Do
      close(18)

      open(20, file=trim(loc_name) // "-A.1gd4r", form="unformatted", access="direct", &
               recl=nxbin*nybin*4)
      open(22, file=trim(loc_name) // "-D.1gd4r", form="unformatted", access="direct", &
               recl=nxbin*nybin*4)


     densi_A = 0 
     densi_D = 0 

     Do it=1, nt

       If (V10A(it) .GT. 10 .and. H10A(it) .GT. 10 ) then ! skip  missing.6gd4ra
          mpdi = (V10A(it)-H10A(it))/(V10A(it)+H10A(it))*600.0
          tb36v = V36A(it) 
                                
         j=nint( (nxbin -1 ) * ( mpdi - xmin ) / (xmax - xmin) ) 
         k=nint( (nybin -1 ) * ( tb36v - ymin) / (ymax - ymin) ) 
      
         if (j .GE. 0 .and. j .lt. nxbin .and. k .GE. 0 .and. k .lt. nybin) then 
           densi_A(j, k) = densi_A(j, k) + 1
         end if 
       End if 

       If (V10D(it) .GT. 10 .and. H10D(it) .GT. 10 ) then ! skip  missing.6gd4ra
          mpdi = (V10D(it)-H10D(it))/(V10D(it)+H10D(it))*600.0
          tb36v = V36D(it)

         j=nint( (nxbin -1 ) * ( mpdi - xmin ) / (xmax - xmin) )
         k=nint( (nybin -1 ) * ( tb36v - ymin) / (ymax - ymin) )

         if (j .GE. 0 .and. j .lt. nxbin .and. k .GE. 0 .and. k .lt. nybin) then
           densi_D(j, k) = densi_D(j, k) + 1
         end if
       End if

     End do 

     write(20, rec=1) real(densi_A) 
     write(22, rec=1) real(densi_D) 
       
     close(20)
     close(22)

  stop
End 

