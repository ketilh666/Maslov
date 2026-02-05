C************************************************************************
C
C SUBROUTINE CARI3D
C
C PURPOSE: Compute interpolated 3D function value by 
C          polynomial interpolation on Lagrange form.
C
C REFERENCES: Equation numbers refer to 
C          Kincaid and Cheney (1991): Numerical Analyisis.
C          Mathematics of scientific computing. (Chapter 6)
C          Brooks/Cole publ. Company.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE CARI3D(PIA,DPIA,DDPIA,FUN,NPOLX,NPOLY,NPOLZ,
     +                  CAF,DCAF,DDCAF,NPXYZ,NDERIV)

      IMPLICIT NONE

C---  External output variables:
      REAL*4  PIA               ! Polynomial approximation
      REAL*4  DPIA (3  )        ! 1st deriv. of Polynomial approx
      REAL*4  DDPIA(3,3)        ! 2nd deriv. of Polynomial approx

C---  External input variables:
      INTEGER NDERIV            ! Highest derivative
      INTEGER NPOLX,NPOLY,NPOLZ ! Degree of interpolating polynomial
      INTEGER NPXYZ             ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4  CAF  (NPXYZ+1,3)  ! Cardinal functions
      REAL*4  DCAF (NPXYZ+1,3)  ! 1st deriv. of Cardinal func.
      REAL*4  DDCAF(NPXYZ+1,3)  ! 2nd deriv. of Cardinal func.
      REAL*4  FUN  (NPOLX+1,NPOLY+1,NPOLZ+1) ! Functions at nodes


C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      INTEGER  I,J,K

C-----------------------------------------------------------------------
C     Compute polynomial interpolation
C     Kincaid and Cheney, Chap. 6.10, eq. (13)  (extended to 3D)
C-----------------------------------------------------------------------

C--- Polynomial approximation:
      PIA   = 0.0
      DO K=1,NPOLZ+1
         DO J=1,NPOLY+1
            DO I=1,NPOLX+1
               PIA   = PIA + FUN(I,J,K)*CAF(I,1)*CAF(J,2)*CAF(K,3)
            ENDDO
         ENDDO
      ENDDO

C--- 1st derivative of Polynomial approx:
      DPIA(1)  = 0.0
      DPIA(2)  = 0.0
      DPIA(3)  = 0.0
      IF (NDERIV.GE.1) THEN
         DO K=1,NPOLZ+1
            DO J=1,NPOLY+1
               DO I=1,NPOLX+1
                  DPIA(1) = DPIA(1) + 
     +                      FUN(I,J,K)*DCAF(I,1)*CAF (J,2)*CAF (K,3)
                  DPIA(2) = DPIA(2) + 
     +                      FUN(I,J,K)*CAF (I,1)*DCAF(J,2)*CAF (K,3)
                  DPIA(3) = DPIA(3) + 
     +                      FUN(I,J,K)*CAF (I,1)*CAF (J,2)*DCAF(K,3)
               ENDDO
            ENDDO
         ENDDO
      ENDIF

C--- 2nd derivative of Polynomial approx:
      DDPIA(1,1)  = 0.0
      DDPIA(2,1)  = 0.0
      DDPIA(3,1)  = 0.0
      DDPIA(1,2)  = 0.0
      DDPIA(2,2)  = 0.0
      DDPIA(3,2)  = 0.0
      DDPIA(1,3)  = 0.0
      DDPIA(2,3)  = 0.0
      DDPIA(3,3)  = 0.0
      IF (NDERIV.GE.2) THEN
         DO K=1,NPOLZ+1
            DO J=1,NPOLY+1
               DO I=1,NPOLX+1
                  DDPIA(1,1) = DDPIA(1,1) + 
     +                         FUN(I,J,K)*DDCAF(I,1)*CAF (J,2)*CAF (K,3)
                  DDPIA(2,1) = DDPIA(2,1) + 
     +                         FUN(I,J,K)*DCAF (I,1)*DCAF(J,2)*CAF (K,3)
                  DDPIA(3,1) = DDPIA(3,1) + 
     +                         FUN(I,J,K)*DCAF (I,1)*CAF (J,2)*DCAF(K,3)
                  DDPIA(1,2) = DDPIA(2,1)
                  DDPIA(2,2) = DDPIA(2,2) + 
     +                         FUN(I,J,K)*CAF (I,1)*DDCAF(J,2)*CAF (K,3)
                  DDPIA(3,2) = DDPIA(3,2) + 
     +                         FUN(I,J,K)*CAF (I,1)*DCAF (J,2)*DCAF(K,3)
                  DDPIA(1,3) = DDPIA(3,1)
                  DDPIA(2,3) = DDPIA(3,2)
                  DDPIA(3,3) = DDPIA(3,2) + 
     +                         FUN(I,J,K)*CAF (I,1)*CAF (J,2)*DDCAF(K,3)
               ENDDO
            ENDDO
         ENDDO
      ENDIF

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CARI3D
C-----------------------------------------------------------------------
