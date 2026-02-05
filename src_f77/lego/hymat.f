C************************************************************************
C
C SUBROUTINE HYMAT
C
C PURPOSE: Compute the matrix of derivatives Hy relating raycentered
C          cartesian coordinate systems
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE HYMAT(HY,GVEC,EVEC)

      IMPLICIT NONE

C---  External variables:
      REAL*8   HY(3,3)
      REAL*8   GVEC(3,3)
      REAL*8   EVEC(3,3)

C---  Parameters:

C---  Internal variables:
      INTEGER  I,J,K
      REAL*8   RG(3),RE(3),RH

C-----------------------------------------------------------------------
C  Compute normalization factors (just in case ....)
C-----------------------------------------------------------------------

      DO K=1,3
         RE(K) = 0.0
         RG(K) = 0.0
         DO J=1,3
            RE(K) = RE(K) + EVEC(J,K)**2
            RG(K) = RG(K) + GVEC(J,K)**2
         ENDDO
         RE(K) = 1.0/SQRT(RE(K))
         RG(K) = 1.0/SQRT(RG(K))
      ENDDO

C-----------------------------------------------------------------------
C  Compute matrix Hy using Cerveny equation (4.1.42)
C-----------------------------------------------------------------------

      DO K=1,3
         DO J=1,3
            HY(J,K) = 0.0
            DO I=1,3
               HY(J,K) = HY(J,K) + EVEC(I,J)*GVEC(I,K)
            ENDDO
            HY(J,K) = HY(J,K)*RE(J)*RG(K)
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE HYMAT
C-----------------------------------------------------------------------


