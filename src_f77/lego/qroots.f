C************************************************************************
C
C SUBROUTINE QROOTS
C
C PURPOSE: Compute the roots of a 2nd dgree equation AX**2-BX+C=0.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE QROOTS(XM,XP,A,B,C)

      IMPLICIT NONE

C---  External variables:
      REAL*8    XM,XP    ! Roots
      REAL*8    A,B,C    ! Coefficients

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'

C---  Internal variables:
      REAL*8    B1,B2,C1,C2,D1,D2

C-----------------------------------------------------------------------
C   Compute the real roots of AX**2-BX+C = 0
C-----------------------------------------------------------------------

c$$$      B1 = 0.5d0*B/A
c$$$      C1 = C/A
c$$$      D2 = B1*B1-C1
c$$$      
c$$$      IF (D2 .GE. 0.0d0) THEN
c$$$         D1 = SQRT(D2)
c$$$         XP = B1 + D1
c$$$         XM = B1 - D1
c$$$      ELSE 
c$$$         D1 = SQRT(-D2)
c$$$         XP = B1 + D1
c$$$         XM = B1 - D1
c$$$      ENDIF

      B1 = 0.5d0*B/A
      B2 = B1*B1
      C1 = C/A
      D2 = 1.0d0 - C1/B2

      IF (D2 .GE. 0.0d0) THEN
         D1 = SQRT(D2)
         XP = B1*(1.0d0 + D1)
         XM = B1*(1.0d0 - D1)
      ELSE
         D1 = SQRT(-D2)
         XP = B1*(1.0d0 + TOSH)
         XM = B1*(1.0d0 - TOSH)
c$$$         XP = B1*(1.0d0 + D1)
c$$$         XM = B1*(1.0d0 - D1)
      ENDIF

C******** BEGIN DEBUGGING ********
c$$$      IF(D2.GE.0.0) THEN
c$$$         WRITE(6,*) '   QROOTS: REAL '
c$$$      ELSE
c$$$         WRITE(6,*) '   QROOTS: COMPLEX         !!!!!!!!!!! '
c$$$      ENDIF
c$$$      WRITE(6,*) '     - A,B,C = ',A,B,C
c$$$      WRITE(6,*) '     - B1,C1 = ',B1,C1
c$$$      WRITE(6,*) '     - D2,D1 = ',D2,D1
c$$$      WRITE(6,*) '     - GN    = ',SQRT(XM),SQRT(XP),A
C******** END   DEBUGGING ********

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE QROOTS
C-----------------------------------------------------------------------


