C************************************************************************
C
C SUBROUTINE CARI1D
C
C PURPOSE: Compute interpolated function value by polynomial
C          interpolation on Lagrange form.
C
C REFERENCES: Equation numbers refer to 
C          Kincaid and Cheney (1991): Numerical Analyisis.
C          Mathematics of scientific computing. (Chapter 6)
C          Brooks/Cole publ. Company.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD AUGUST    1999
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE CARI1D(PIA,DPIA,DDPIA,FUN,CAF,DCAF,DDCAF,NPOL,NDERIV)

      IMPLICIT NONE

C---  External output variables:
      REAL*4  PIA             ! Polynomial approximation
      REAL*4  DPIA            ! 1st derivative of Polynomial approx
      REAL*4  DDPIA           ! 2nd derivative of Polynomial approx

C---  External input variables:
      INTEGER NPOL            ! Degree of polynomial
      INTEGER NDERIV          ! Highest order derivatives
      REAL*4  FUN(NPOL+1)     ! Function value at the nodes
      REAL*4  CAF(NPOL+1)     ! Cardinal functions
      REAL*4  DCAF (NPOL+1)   ! 1st derivatives of Cardinal functions
      REAL*4  DDCAF(NPOL+1)   ! 2nd derivatives of Cardinal functions

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      INTEGER  K

C-----------------------------------------------------------------------
C     Compute polynomial interpolation,
C     Kincaid and Cheney, Chap. 6.1, eq. (9)
C-----------------------------------------------------------------------

C--- Polynomial approximation:
      PIA   = 0.0
      DO K=1,NPOL+1
         PIA   = PIA + FUN(K)*CAF(K)
      ENDDO

C--- 1st derivative of Polynomial approx:
      DPIA  = 0.0
      IF (NDERIV.GE.1) THEN
         DO K=1,NPOL+1
            DPIA  = DPIA + FUN(K)*DCAF(K)
         ENDDO
      ENDIF

C--- 2nd derivative of Polynomial approx:
      DDPIA = 0.0
      IF (NDERIV.GE.2) THEN
         DO K=1,NPOL+1
            DDPIA = DDPIA + FUN(K)*DDCAF(K)
         ENDDO
      ENDIF

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CARI1D
C-----------------------------------------------------------------------

