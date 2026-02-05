C************************************************************************
C
C SUBROUTINE GOCRAY
C
C PURPOSE: Compute matrices QY and PY in ray centered coordinates
C          from derivatives of slowness and position (group velocity)
C          in cartesian coordinates and matrices QX and PX in 
C          cartesian coordinates
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

      SUBROUTINE GOCRAY(QY,PY,NY1,NY2,HY,QX,PX,NX1,NX2,X,P,XDOT,PDOT)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  NX1,NX2             ! Dimensions of QX and PX    
      REAL*8   QX(NX1,NX2)         ! Matrix Q in Cartesian coord.
      REAL*8   PX(NX1,NX2)         ! Matrix P in Cartesian coord.
      REAL*8   X(3),P(3)           ! Position and slowness in Cartesian 
      REAL*8   XDOT(3),PDOT(3)     ! Deriv. of pos and slowness in Cart.
      REAL*8   HY(3,3)             ! Ray centered to Cartesian transf.
      INTEGER  NY1,NY2             ! Dimensions of QY and PY    

C---  External output variables:
      REAL*8   QY(NY1,NY2)         ! Matrix Q in ray centered coord.
      REAL*8   PY(NY1,NY2)         ! Matrix P in ray centered coord.

C---  Internal variables:
      INTEGER  I,J,K
      REAL*8   QXWRK(3,3),PXWRK(3,3)

C-----------------------------------------------------------------------
C  Construct the 3x3 matrices QX and PX from 3x2 matrices and
C  Cerveny equation (4.14.29)
C-----------------------------------------------------------------------

C---  Column 1 and 2:
      DO J=1,2
         DO I=1,3
            QXWRK(I,J) = QX(I,J)
            PXWRK(I,J) = PX(I,J)
         ENDDO
      ENDDO

C---  Column 3, using equation (4.14.29):
      DO I=1,3
         QXWRK(I,3) = XDOT(I)
         PXWRK(I,3) = PDOT(I)
      ENDDO         

C---  Copy back to QX,QY
c$$$      DO J=1,NX2
c$$$         DO I=1,NX1
c$$$            QX(I,J) = QXWRK(I,J)
c$$$            PX(I,J) = PXWRK(I,J)
c$$$         ENDDO
c$$$      ENDDO

C-----------------------------------------------------------------------
C  Compute QY and PY, Cerveny equations (4.7.20) and (4.14.21)
C-----------------------------------------------------------------------

C---  Columns 1 and 2:
      DO J=1,NY2
         DO I=1,NY1
            QY(I,J) = 0.0
            PY(I,J) = 0.0
            DO K=1,3
               QY(I,J) = QY(I,J) + HY(K,I)*QXWRK(K,J)
               PY(I,J) = PY(I,J) + HY(K,I)*PXWRK(K,J)
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE GOCRAY
C-----------------------------------------------------------------------


