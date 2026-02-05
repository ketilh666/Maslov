C************************************************************************
C
C SUBROUTINE SHEFU8
C
C PURPOSE: Compute weight functions for 3D Shepard interpolation. 
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

      SUBROUTINE SHEFU8(SHEW,NSHE,XNOD,XINT)

      IMPLICIT NONE

C---  External output variables:
      REAL*8  SHEW(  NSHE)      ! Shepard weight (cardinal) functions

C---  External input variables:
      INTEGER NSHE              ! No of points used in interpolation
      INTEGER MPOSHE            ! Power of Euclidean norm (>1)
      REAL*8  XNOD(3,NSHE)      ! (x,y,z) components of the nodes  
      REAL*8  XINT(3     )      ! Interpolation output point

C---  Parameters:
      INCLUDE '../include_files/interpol.inc'

C---  Internal variables:
      INTEGER J,K
      REAL*8  SUM
      REAL*8  PX1,PX2,PX3
      REAL*8  RWRK(MAXSHE),PWRK(MAXSHE)

C-----------------------------------------------------------------------
C     Precompute frequently used quantities,
C     Kincaid and Cheney, Chap. 6.10, eq. (24)
C-----------------------------------------------------------------------

c$$$      WRITE(6,1) '$ SHEFU8: NSHE = ',NSHE
c$$$      WRITE(6,1) '          MPOSHE = ',MPOSHE

C---  Euclidean norm (L**MPOSHE):
      DO K=1,NSHE
         PX1 = ( XINT(1) - XNOD(1,K) )**MPOSHE
         PX2 = ( XINT(2) - XNOD(2,K) )**MPOSHE
         PX3 = ( XINT(3) - XNOD(3,K) )**MPOSHE
         RWRK(K) = PX1 + PX2 + PX3
      ENDDO

c$$$      WRITE(6,2) '   XINT = ',XINT(1),XINT(2),XINT(3)
c$$$      DO K=1,NSHE
c$$$         WRITE(6,2) '   XNOD = ',XNOD(1,K),XNOD(2,K),XNOD(3,K)
c$$$      ENDDO
c$$$      WRITE(6,2) '   RWRK = ',RWRK(1),RWRK(2),RWRK(3)
      


C---  Products:
      DO K=1,NSHE
         PWRK(K) = 1.0d0
         DO J=1,NSHE
            IF (J.NE.K) THEN
               PWRK(K) = PWRK(K)*RWRK(J) 
            ENDIF
         ENDDO
      ENDDO

c$$$      WRITE(6,*) '   PWRK = ',PWRK(1),PWRK(2),PWRK(3)
C-----------------------------------------------------------------------
C     Compute Shepard weights, Kincaid and Cheney, Chap. 6.10, eq. (24)
C-----------------------------------------------------------------------

      DO K=1,NSHE
         SUM = 0.0
         DO J=1,NSHE
            SUM = SUM + PWRK(J)
         ENDDO
         SHEW(K) = PWRK(K)/SUM
      ENDDO

      SUM = 0.0
      DO K=1,NSHE
         SUM = SUM+SHEW(K)
      ENDDO
      
c$$$      WRITE(6,*) '   WGHTS  = ',SHEW(1),SHEW(2),SHEW(3)
c$$$      WRITE(6,*) '   SUM W  = ',SUM
 1    FORMAT(A,I6)
 2    FORMAT(A,3F10.3)
 3    FORMAT(A,I4,3F10.3)
 4    FORMAT(A,F10.5)


C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE SHEFU8
C-----------------------------------------------------------------------


