C************************************************************************
C
C SUBROUTINE WILL
C
C PURPOSE: Compute derivatives of the 3x2 matrices Qx and Px for
C          anisotropic dynamic raytracing in Cartesian coordinates.
C
C NOTE:    I think this routine is correct and according to theory.
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C          Bill is the President of the United States.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE WILL(QXDOT,PXDOT,QX,PX,DGAMDX,DGAMDP,DGAMXX,
     +                DGAMXP,DGAMPX,DGAMPP,GIGJ,GIDGJX,GIDGJP)

      IMPLICIT NONE

C---  External output variables:
      REAL*8   QXDOT(3,2)       ! Derivatives of 3x2 matrix Qx
      REAL*8   PXDOT(3,2)       ! Derivatives of 3x2 matrix Px

C---  External input variables:
      REAL*8   QX(3,2),PX(3,2)  ! 3x2 matrices Qx and Px
      REAL*8   DGAMDX(3,3,3  )  ! 1st deriv. of GAM w.r.t. position
      REAL*8   DGAMDP(3,3,3  )  ! 1st deriv. of GAM w.r.t. slowness
      REAL*8   DGAMXX(3,3,3,3)  ! 2nd deriv. of GAM w.r.t. position
      REAL*8   DGAMPP(3,3,3,3)  ! 2nd deriv. of GAM w.r.t. slowness
      REAL*8   DGAMXP(3,3,3,3)  ! Mixed 2nd deriv. og GAM (X 1st)
      REAL*8   DGAMPX(3,3,3,3)  ! Mixed 2nd deriv. og GAM (P 1st)
      REAL*8   GIGJ  (3,3    )  ! Outer product of polarization vectors
      REAL*8   GIDGJX(3,3,3  )  ! Prod. of pol.vector and deriv. w.r.t x
      REAL*8   GIDGJP(3,3,3  )  ! Prod. of pol.vector and deriv. w.r.t p

C---  Parameters:

C---  Internal variables:
      INTEGER  I,J,K,L
      REAL*8   DHDPP(3,3),DHDPX(3,3),DHDXP(3,3),DHDXX(3,3)
      REAL*8   H1XX,H1XP,H1PX,H1PP,H2XX,H2XP,H2PX,H2PP

C-----------------------------------------------------------------------
C  2nd derivatives of the Hamiltonian, Cerveny equation (4.14.7)
C-----------------------------------------------------------------------

      DO L=1,3
         DO K=1,3
            H1XX = 0.0
            H1XP = 0.0
            H1PX = 0.0
            H1PP = 0.0
            H2XX = 0.0
            H2XP = 0.0
            H2PX = 0.0
            H2PP = 0.0
            DO J=1,3
               DO I=1,3
C---              1st term:
                  H1PP = H1PP + DGAMPP(I,J,K,L)*GIGJ(I,J)
                  H1XX = H1XX + DGAMXX(I,J,K,L)*GIGJ(I,J)
                  H1PX = H1PX + DGAMPX(I,J,K,L)*GIGJ(I,J)
                  H1XP = H1XP + DGAMXP(I,J,K,L)*GIGJ(I,J)
C---              2nd term:
                  H2PP = H2PP + DGAMDP(I,J,K)*GIDGJP(I,J,L)
                  H2XX = H2XX + DGAMDX(I,J,K)*GIDGJX(I,J,L)
                  H2PX = H2PX + DGAMDX(I,J,K)*GIDGJP(I,J,L)
                  H2XP = H2XP + DGAMDP(I,J,K)*GIDGJX(I,J,L)
               ENDDO
            ENDDO
            DHDXX(K,L) = 0.5*H1XX + H2XX
            DHDXP(K,L) = 0.5*H1XP + H2XP
            DHDPX(K,L) = 0.5*H1PX + H2PX
            DHDPP(K,L) = 0.5*H1PP + H2PP
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C  Derivatives of 2x3 matrices Qx and PX w.r.t. traveltime 
C  along the ray, Cerveny equation (4.14.5)
C-----------------------------------------------------------------------

      DO K=1,2
         DO J=1,3
            QXDOT(J,K) = 0.0
            PXDOT(J,K) = 0.0
            DO I=1,3
               QXDOT(J,K) = QXDOT(J,K) + DHDXP(J,I)*QX(I,K)
     +                                 + DHDPP(J,I)*PX(I,K)
               PXDOT(J,K) = PXDOT(J,K) - DHDPX(J,I)*PX(I,K)
     +                                 - DHDXX(J,I)*QX(I,K)
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE WILL
C-----------------------------------------------------------------------
