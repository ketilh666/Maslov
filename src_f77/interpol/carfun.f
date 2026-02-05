C************************************************************************
C
C SUBROUTINE CARFUN
C
C PURPOSE: Compute cardinal functions for polynomial 
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
C PROGRAMMED         : KETIL HOKSTAD   AUGUST 1999
C
C************************************************************************

      SUBROUTINE CARFUN(CAF,DCAF,DDCAF,HX,CA,DA,NPOL,NDERIV)

      IMPLICIT NONE

C---  External output variables:
      REAL*4  CAF  (NPOL+1)     ! Cardinal functions
      REAL*4  DCAF (NPOL+1)     ! 1st derivatives of Cardinal functions
      REAL*4  DDCAF(NPOL+1)     ! 2nd derivatives of Cardinal functions

C---  External input variables:
      INTEGER NPOL              ! Dgree of polynomial
      INTEGER NDERIV            ! Highest order derivatives
      REAL*4  HX                ! HX = X-X_L, where X is the interp. point
      REAL*4  CA(NPOL+1)        ! Precomputed array 
      REAL*4  DA(NPOL+1)        ! Precomputed array

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      REAL*4  PROD,SUM1,SUM2
      REAL*4  HDWRK(MAXPOL+1) ! Work array containing HX+DA(J)
      INTEGER I,J,K,L

C-----------------------------------------------------------------------
C     Precompute HX + DA(J)
C-----------------------------------------------------------------------

      DO J=1,NPOL+1
         HDWRK(J) = HX + DA(J)
      ENDDO

C-----------------------------------------------------------------------
C     Compute cardinal functions (always),
C     Kincaid and Cheney, Chap. 6.1, eq. (10)
C-----------------------------------------------------------------------

      DO K=1,NPOL+1
         PROD=1.0
         DO J=1,NPOL+1
            IF (J.NE.K) PROD = PROD*HDWRK(J)
         ENDDO
         CAF(K) = CA(K)*PROD
      ENDDO

C-----------------------------------------------------------------------
C     Compute 1st derivatives of cardinal functions (if NDERIV>0)
C-----------------------------------------------------------------------

      IF (NDERIV.GE.1) THEN 
         DO K=1,NPOL+1
            SUM1 = 0.0
            DO J=1,NPOL+1
               IF (J.NE.K) THEN
                  PROD = 1.0
                  DO I=1,NPOL+1
                     IF (I.NE.J .AND. I.NE.K) PROD = PROD*HDWRK(I)
                  ENDDO
                  SUM1 = SUM1 + PROD
               ENDIF
            ENDDO
            DCAF(K) = CA(K)*SUM1
         ENDDO
      ELSE
         DO K=1,NPOL+1
            DCAF(K) = 0.0
         ENDDO
      ENDIF

C-----------------------------------------------------------------------
C     Compute 2nd derivatives of cardinal functions (if NDERIV>1)
C-----------------------------------------------------------------------

      IF (NDERIV.GE.2) THEN 
         DO K=1,NPOL+1
            SUM2 = 0.0
            DO J=1,NPOL+1
               IF (J.NE.K) THEN
                  SUM1 = 0.0
                  DO I=1,NPOL+1
                     IF (I.NE.J .AND. I.NE.K) THEN
                        PROD = 1.0
                        DO L=1,NPOL+1
                           IF ((L.NE.I .AND. L.NE.J) .AND. L.NE.K) 
     +                          PROD = PROD*HDWRK(L)
                        ENDDO
                        SUM1 = SUM1 + PROD
                     ENDIF
                  ENDDO
                  SUM2 = SUM2+SUM1
               ENDIF
            ENDDO
            DDCAF(K) = CA(K)*SUM2
         ENDDO
      ELSE
         DO K=1,NPOL+1
            DDCAF(K) = 0.0
         ENDDO
      ENDIF

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CARFUN
C-----------------------------------------------------------------------


