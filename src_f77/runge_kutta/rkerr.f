C************************************************************************
C
C SUBROUTINE RKERR
C
C PURPOSE: Write error messages from the Runge-Kutta integration
C          of Kinetic raytracing system.
C 
C ERROR CONDITIONS:
C          IERR = 0 : successful execution of routine
C          IERR = 1 : Max number of iterations reached.
C          IERR = 2 : Steplength becomes too small (less than HMIN)
C          IERR = 6 : Stepsize underflow encountered
C
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE RKERR(LUT,CNAME,ITH,IPH,NRAYEL,IERR)

      INTEGER       LUT     ! Output unit
      INTEGER       IERR    ! Error flag
      INTEGER       ITH,IPH ! Ray number
      INTEGER       NRAYEL  ! Number of rayelements
      CHARACTER*(*) CNAME   ! Subroutine name

C-----------------------------------------------------------------------
C     Write error message to unit LUT
C-----------------------------------------------------------------------
      
      IF     (IERR .EQ.  0) THEN
         RETURN
      ELSEIF(IERR .EQ.  1) THEN
         WRITE(LUT,3) '#%$ ERROR IN ',CNAME(1:6),' : '
         WRITE(LUT,1) '  : Max number of steps reached.' 
         WRITE(LUT,1) '  : Runge-Kutta iteration loop terminated. '
         WRITE(LUT,2) '  : ITH, IPH, NRAYEL = ',ITH,IPH,NRAYEL
      ELSEIF(IERR .EQ.  2) THEN
         WRITE(LUT,3) '#%$ ERROR IN '
         WRITE(LUT,1) '  : Stepsize too small.'
         WRITE(LUT,1) '  : Runge-Kutta iteration loop terminated. '
         WRITE(LUT,2) '  : ITH, IPH, NRAYEL = ',ITH,IPH,NRAYEL
      ELSEIF(IERR .EQ.  3) THEN
         WRITE(LUT,3) '#%$ ERROR IN ',CNAME(1:6),' : '
         WRITE(LUT,1) '  : Arrays to small to store all ray data.'
         WRITE(LUT,1) '  : Runge-Kutta iteration loop terminated. '
         WRITE(LUT,2) '  : ITH, IPH, NRAYEL = ',ITH,IPH,NRAYEL
      ELSEIF(IERR .EQ.  6) THEN
         WRITE(LUT,1) '#%$ ERROR IN RKQS: '
         WRITE(LUT,1) '  : Stepsize underflow '
         WRITE(LUT,1) '  : Runge-Kutta iteration loop terminated. '
         WRITE(LUT,2) '  : ITH, IPH, NRAYEL = ',ITH,IPH,NRAYEL
      ELSEIF(IERR .EQ.  9) THEN
         WRITE(LUT,3) '#%$ WARNING IN ',CNAME(1:6),' : '
         WRITE(LUT,1) '  : Degenerate Eigenvalues for qS1 and qS2'
         WRITE(LUT,2) '  : ITH, IPH, NRAYEL = ',ITH,IPH,NRAYEL
      ELSEIF(IERR .EQ. 10)THEN
         WRITE(LUT,3) '#%$ WARNING IN ',CNAME(1:6),' : '
         WRITE(LUT,1) '  : Sign swapped on qP polarization vector.'
         WRITE(LUT,2) '  : ITH, IPH, NRAYEL = ',ITH,IPH,NRAYEL
      ENDIF

 1    FORMAT(1A)
 2    FORMAT(1A,2I4,I6)
 3    FORMAT(3A)

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE RKERR
C-----------------------------------------------------------------------


