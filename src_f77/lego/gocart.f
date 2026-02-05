C************************************************************************
C
C SUBROUTINE GOCART
C
C PURPOSE: Compute the matrices Px and Qx in cartesian coordinates
C          from derivatives of slowness and position (group velocity) 
C          in cartesian coordinates and 2x2 matrices Py and Qy in 
C          ray centered coordinates. If NY1=NY2=3, the 3rd row and 
C          column of PY and QY are returned as well.
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

      SUBROUTINE GOCART(QX,PX,NX1,NX2,X,P,XDOT,PDOT,HY,QY,PY,NY1,NY2)

      IMPLICIT NONE

C---  External  input variables:
      INTEGER  NX1,NX2             ! Dimensions of QX and PX    
      REAL*8   X(3),P(3)           ! Position and slowness in Cartesian 
      REAL*8   XDOT(3),PDOT(3)     ! Deriv. of pos and slowness in Cart.
      REAL*8   HY(3,3)             ! Ray centered to Cartesian transf.
      INTEGER  NY1,NY2             ! Dimensions of QY and PY    
      REAL*8   QY(NY1,NY2)         ! Matrix Q in ray centered coord.
      REAL*8   PY(NY1,NY2)         ! Matrix P in ray centered coord.

C---  External  input variables:
      REAL*8   QX(NX1,NX2)         ! Matrix Q in Cartesian coord.
      REAL*8   PX(NX1,NX2)         ! Matrix P in Cartesian coord.

C---  Internal variables:
      INTEGER  I,J,K
      REAL*8   QYWRK(3,3),PYWRK(3,3)
      REAL*8   VGRY(3),ETAY(3)

C-----------------------------------------------------------------------
C  Construct the 3x3 matrices QY and PY from 2x2 matrices and
C  Cerveny equations (4.7.21) and (4.7.26) and (4.14.30)
C-----------------------------------------------------------------------

C--- Convert XDOT, PDOT from cartesian to ray centered, eq. (4.7.21):
      DO J=1,3
         VGRY(J) = 0.0
         ETAY(J) = 0.0
         DO I=1,3
            VGRY(J) = VGRY(J) + HY(I,J)*XDOT(I)
            ETAY(J) = ETAY(J) + HY(I,J)*PDOT(I)
         ENDDO
      ENDDO

C---  Copy upper left 2x2 submatrix to 3x3 worK arrays:
      DO K=1,2
         DO J=1,2
            QYWRK(J,K) = QY(J,K)
            PYWRK(J,K) = PY(J,K)
         ENDDO
      ENDDO

C---  3rd row, columns 1 and 2 from equation (4.7.26):
      QYWRK(3,1) = 0.0
      QYWRK(3,2) = 0.0
      DO J=1,2
         PYWRK(3,J) = 0.0
         DO I=1,2
            PYWRK(3,J) =  PYWRK(3,J) +
     +                   (ETAY(I)*QY(I,J)-VGRY(I)*PY(I,J))/VGRY(3) 
         ENDDO
      ENDDO

C---  3rd column of QY and PY using equation (4.14.30):
      DO I=1,3
         QYWRK(I,3) = VGRY(I)
         PYWRK(I,3) = ETAY(I)
      ENDDO

C---  Copy back to QY,PY:
c$$$      DO J=1,NY2
c$$$         DO I=1,NY1
c$$$            QY(I,J) = QYWRK(I,J)
c$$$            PY(I,J) = PYWRK(I,J)
c$$$         ENDDO
c$$$      ENDDO

C-----------------------------------------------------------------------
C  Compute QX and PX, Cerveny equations (4.14.29) and (4.14.31)
C-----------------------------------------------------------------------

C---  Columns 1 and 2:
      DO J=1,2
         DO I=1,NX1
            QX(I,J) = 0.0
            PX(I,J) = 0.0
            DO K=1,3
               QX(I,J) = QX(I,J) + HY(I,K)*QYWRK(K,J)
               PX(I,J) = PX(I,J) + HY(I,K)*PYWRK(K,J)
            ENDDO
         ENDDO
      ENDDO

C---  Copy the 3rd column from XDOT and PDOT:
      IF (NX2.EQ.3) THEN
         DO I=1,NX1
            QX(I,NX2) = XDOT(I)
            PX(I,NX2) = PDOT(I)
         ENDDO
      ENDIF

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE GOCART
C-----------------------------------------------------------------------


