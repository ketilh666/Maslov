C************************************************************************
C
C SUBROUTINE CARPRE
C
C PURPOSE: Precompute constant arrays for computation of 
C          cardinal functions used in polynomial 
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

      SUBROUTINE CARPRE(LPOL,CA,DA,NPOL,DX)

      IMPLICIT NONE

C---  External output variables:
      INTEGER LPOL             ! Left midpoint LP=(NPOL+1)/2
      REAL*4  CA(NPOL+1)       ! Precomputed array     
      REAL*4  DA(NPOL+1)       ! Precomputed array      

C---  External input variables:
      INTEGER NPOL             ! Degree of polynomial
      REAL*4  DX               ! Node sampling

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      INTEGER  J,K

C-----------------------------------------------------------------------
C     Compute constant arrays for computation of Cardinal functions,
C     Kincaid and Cheney, Chap. 6.1, page 282
C-----------------------------------------------------------------------

C---  Check that the polynomial is odd degree:
      IF (NPOL .GT. MAXPOL) NPOL = MAXPOL  

C---  Left center index in the array:
      LPOL = NPOL/2+1

C---  Precomputed array DA:
      DO J=1,NPOL+1
         DA(J) = REAL(LPOL-J)*DX
      ENDDO

C---  Precomputed array CA:
      DO K=1,NPOL+1
         CA(K) = 1.0
         DO J=1,NPOL+1
            IF(J.NE.K) CA(K)=CA(K)*REAL(K-J)*DX
         ENDDO
         CA(K) = 1.0/CA(K)
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CARPRE
C-----------------------------------------------------------------------


