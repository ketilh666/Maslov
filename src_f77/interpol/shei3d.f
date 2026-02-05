C************************************************************************
C
C SUBROUTINE SHEI38
C
C PURPOSE: Perform Shepard interpolation of 3D data.
C          The data to be interpolated may be scalras (NCOMP=1)
C          or vectors (NCOMP=3). 
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

      SUBROUTINE SHEI38(SIP,NCOMP,VFUN,SHEW,NSHE)

      IMPLICIT NONE

C---  External output variables:
      REAL*8  SIP (NCOMP)        ! Shepard interpolation result (vector)

C---  External input variables:
      INTEGER NCOMP              ! No of components in interpolated function
      INTEGER NSHE               ! No of points used in interpolation
      REAL*8  VFUN(NCOMP,NSHE)   ! Function values at the nodes
      REAL*8  SHEW(NSHE)         ! Shepard weight (cardinal) functions

C---  Parameters:
      INCLUDE '../include_files/interpol.inc'

C---  Internal variables:
      INTEGER J,K

C-----------------------------------------------------------------------
C     Perform shepard interpolation of the vector VFUN,
C     Kincaid and Cheney, Chap. 6.10, eq. (25)
C      * NCOMP = 1 for scalars (like traveltime and geom. spreading)
C      * NCOMP = 3 for vectors (like slowness and polarization)
C-----------------------------------------------------------------------

      DO J=1,NCOMP
         SIP(J) = 0.0
      ENDDO

      DO K=1,NSHE
         DO J=1,NCOMP
            SIP(J) = SIP(J) + VFUN(J,K)*SHEW(K)
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE SHEI38
C-----------------------------------------------------------------------

