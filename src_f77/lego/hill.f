C************************************************************************
C
C SUBROUTINE HILL
C
C PURPOSE: Compute derivatives of position and slowness for
C          anisotropic kinematic raytracing in Cartesian coordinates.
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C          Hill is the First Lady of the United States.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE HILL(XDOT,PDOT,DGAMDX,DGAMDP,GIGJ)

      IMPLICIT NONE

C---  External output variables:
      REAL*8   XDOT(3),PDOT(3) ! Derivatives of position and slowness

C---  External input variables:
      REAL*8   DGAMDX(3,3,3)   ! Deriv. of Christ. tensor w.r.t. x
      REAL*8   DGAMDP(3,3,3)   ! Deriv. of Christ. tensor w.r.t. p
      REAL*8   GIGJ(3,3)       ! Outer product of polarization vectors

C---  Parameters:

C---  Internal variables:
      INTEGER  I,J,K

      REAL*4   VG(3),ET(3)

C-----------------------------------------------------------------------
C  Derivatives of position (group velocity) and slowness
C  w.r.t. traveltime along the ray, Cerveny equation (3.6.8)
C-----------------------------------------------------------------------

      DO K=1,3
         XDOT(K) = 0.0
         PDOT(K) = 0.0
         DO J = 1,3
            DO I=1,3
               XDOT(K) = XDOT(K) + 0.5*DGAMDP(I,J,K)*GIGJ(I,J)
               PDOT(K) = PDOT(K) - 0.5*DGAMDX(I,J,K)*GIGJ(I,J)
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE HILL
C-----------------------------------------------------------------------


