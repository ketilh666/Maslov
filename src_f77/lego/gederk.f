C************************************************************************
C
C SUBROUTINE GEDERK
C
C PURPOSE: Compute the derivative of polarization vectors with
C          respect to slowness or position.
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

      SUBROUTINE GEDERK(GIDGK,ZDOT,GVDOT,GVEC,GN,KMODE)

      IMPLICIT NONE

C---  External input variables:
      REAL*8   ZDOT(3)         ! Derivative of X or P
      REAL*8   GVDOT(3,3)      ! Derivative of polariz. vector w.r.t time
      REAL*8   GVEC(3,3)       ! Polarization
      REAL*8   GN(3)           ! Eigen values of the Christoffel tensor
      INTEGER  KMODE(3)        ! Wavemodes. Current mode is in kmode(1).


C---  External output variables:
      REAL*8   GIDGK(3,3,3)    ! Outer prod. of pol. vector and deriv.

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'
      REAL*8     ETA
      PARAMETER (ETA=1.0d-3)

C---  Internal variables:
      INTEGER  I,J,K,M1
      REAL*8   DGDK(3,3),ZINV(3),RZ

C-----------------------------------------------------------------------
C  Current wave mode
C-----------------------------------------------------------------------

      M1 = KMODE(1)

C-----------------------------------------------------------------------
C  Compute derivatives of polarization vectors w.r.t. X or P
C-----------------------------------------------------------------------

c$$$      RZ = 0.0
c$$$      DO K=1,3
c$$$         RZ = RZ + ZDOT(K)*ZDOT(K)
c$$$      ENDDO
c$$$      RZ = SQRT(RZ)
c$$$
c$$$C      WRITE(6,*) 'GEDERK: RZ, ZDOT(K) = ',RZ,(ZDOT(K),K=1,3)
c$$$
c$$$      DO K=1,3
c$$$         IF (ABS(ZDOT(K)) .GE. ETA*RZ) THEN
c$$$            ZINV(K) = 1.0/ZDOT(K)
c$$$         ELSE
c$$$            ZINV(K) = 0.0
c$$$         ENDIF
c$$$      ENDDO

      DO K=1,3
         DO J=1,3
            DGDK(J,K) = GVDOT(J,M1)*ZINV(K)
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C  Compute product g_i*(dg_j/da_k) of polarization and derivatives
C-----------------------------------------------------------------------

      DO K=1,3
         DO J=1,3
            DO I=1,3
               GIDGK(I,J,K) = GVEC(I,M1)*DGDK(J,K)
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE GEDERK
C-----------------------------------------------------------------------




