!************************************************************************
!
! Subroutine rk_error
!
! Purpose: Write error messages from the Runge-Kutta integration
!          of Kinetic raytracing system.
! 
! Error conditions:
!          IERR =  0 : Successful execution
!          IERR =  1 : Max number of iterations reached.
!          IERR =  2 : Steplength becomes too small (less than HMIN)
!          IERR =  3 : Arrays to small to store all data
!          IERR =  6 : Stepsize underflow encountered
!          IERR =  9 : Degenerate Eigenvalues for qS1 and qS2
!          IERR = 10 : Sign swapped on qP polarization vector
!
!
! Subroutines called : none
! Functions called   : none
!
! Programmed         : Ketil Hokstad December 1998
!                      Ketil Hokstad February 2000
!
!************************************************************************

subroutine rk_error(lut,cname,ith,iph,nrayel,ierr)

   integer         ,intent(in) :: lut     ! Output unit
   integer         ,intent(in) :: ierr    ! Error flag
   integer         ,intent(in) :: ith,iph ! Ray number
   integer         ,intent(in) :: nrayel  ! Number of rayelements
   character(len=*),intent(in) :: cname   ! Subroutine name

   !-----------------------------------------------------------------------
   !     Write error message to unit LUT
   !-----------------------------------------------------------------------
   
   if    (ierr .eq.  0) then
      return
   elseif(ierr .eq.  1) then
      write(lut,3) '   &@#%$ ERROR IN ',CNAME(1:6),' : '
      write(lut,1) '     : Max number of steps reached.' 
      write(lut,1) '     : Runge-Kutta iteration loop terminated. '
      write(lut,2) '     : IPH, ITH, NRAYEL = ',IPH,ITH,NRAYEL
   elseif(ierr .eq.  2) then
      write(lut,3) '   &@#%$ ERROR IN '
      write(lut,1) '     : Stepsize too small.'
      write(lut,1) '     : Runge-Kutta iteration loop terminated. '
      write(lut,2) '     : IPH, ITH, NRAYEL = ',IPH,ITH,NRAYEL
   elseif(ierr .eq.  3) then
      write(lut,3) '   &@#%$ ERROR IN ',CNAME(1:6),' : '
      write(lut,1) '     : Arrays to small to store all ray data.'
      write(lut,1) '     : Runge-Kutta iteration loop terminated. '
      write(lut,2) '     : IPH, ITH, NRAYEL = ',IPH,ITH,NRAYEL
   elseif(ierr .eq.  6) then
      write(lut,1) '   &@#%$ ERROR IN RKQS: '
      write(lut,1) '     : Stepsize underflow '
      write(lut,1) '     : Runge-Kutta iteration loop terminated. '
      write(lut,2) '     : IPH, ITH, NRAYEL = ',IPH,ITH,NRAYEL
   elseif(ierr .eq.  9) then
      write(lut,3) '   &@#%$ WARNING IN ',CNAME(1:6),' : '
      write(lut,1) '     : Degenerate Eigenvalues for qS1 and qS2'
!!$      write(lut,2) '     : IPH, ITH, NRAYEL = ',IPH,ITH,NRAYEL
      write(lut,*) '     : IPH, ITH, NRAYEL = ',IPH,ITH,NRAYEL
   elseif(ierr .eq. 10)then
      write(lut,3) '   &@#%$ WARNING IN ',CNAME(1:6),' : '
      write(lut,1) '     : Sign swapped on qP polarization vector.'
!!$      write(lut,2) '     : IPH, ITH, NRAYEL = ',IPH,ITH,NRAYEL
      write(lut,*) '     : IPH, ITH, NRAYEL = ',IPH,ITH,NRAYEL
   endif
   
1  format(1A)
2  format(1A,2I4,I6)
3  format(3A)
   
!-----------------------------------------------------------------------
   end subroutine rk_error
!-----------------------------------------------------------------------


