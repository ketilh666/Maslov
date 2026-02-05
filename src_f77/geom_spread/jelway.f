C************************************************************************
C
C SUBROUTINE JELWAY
C
C PURPOSE: Compute the geometrical spreading by dynamic raytracing
C          
C
C REFERENCES: 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures, 
C          chapters 4. Lecture notes, University of Trondheim, 
C          1995.
C          John Elway is the QB of Denver Broncos.
C          Superbowl champ 1997+1998.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD          JANUARY 1999
C                      SVERRE BRANDSBERG-DAHL JUNE    1999
C
C************************************************************************

      SUBROUTINE JELWAY(NRAYEL,GSRAY,TRAY,XRAY,PRAY,VGRAY,ETRAY,
     +                  GVRAY,QXRAY,PXRAY,ITH,IPH,MTH,MPH,MAXEL,KINDX)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    ITH,IPH,MTH,MPH,MAXEL
      INTEGER    NRAYEL(MTH,MPH)          ! Number of rayelements
      REAL*8     TRAY (MAXEL,MTH,MPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,MTH,MPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,MTH,MPH)   ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,MTH,MPH)   ! Ray group velocity
      REAL*8     ETRAY(3,MAXEL,MTH,MPH)   ! Ray deriv. of slowness
      REAL*8     GVRAY(3,3,MAXEL,MTH,MPH) ! Ray eigenvectors 
      REAL*8     QXRAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix Qx (Cartesian)
      REAL*8     PXRAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix Px (Cartesian)

C---  External output variables:
      REAL*8     GSRAY(2,MAXEL,MTH,MPH)   ! Complex geom spreading
      INTEGER    KINDX(MAXEL,MTH,MPH)     ! The KMAH index along the ray segments

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'

C---  Internal variables:
      INTEGER    I,J,K,L,M,IND,IND_OLD
      COMPLEX    GDIV
      REAL*8     DETQ,WRK1,WRK2
      REAL*8     QY(2,2),PY(2,2),HY(3,3)

      REAL*8     VG,QX(3,3) ! dummy variables used in the determinant
      REAL*8     X,Z,T,R,EF,VP          ! For debugging

C-----------------------------------------------------------------------
C  Initialize
C-----------------------------------------------------------------------

      L = MIN(ITH,MTH)
      M = MIN(IPH,MPH)

      DO K=1,MAXEL
         KINDX(K,L,M) = 0
      ENDDO

C-----------------------------------------------------------------------
C  Compute complex geometrical spreading along the ray
C   * Magnitude   in GSRAY(1,K,L,M)
C   * Phase angle in GSRAY(2,K,L,M)
C-----------------------------------------------------------------------

C---  Debugging printout
C      WRITE(6,*) 'JELWAY: L,M = ',L,M

C---  Initialization of indices
      IND     = 0
      IND_OLD = 0

C---  Relative geometrical spreading along the ray:

      DO K=1,NRAYEL(L,M)

         CALL HYMAT(HY,GVRAY(1,1,K,L,M),ECART)
         CALL GOCRAY(QY,PY,2,2,HY,QXRAY(1,1,K,L,M),
     +               PXRAY(1,1,K,L,M),3,2,
     +               XRAY(1,K,L,M),PRAY(1,K,L,M),
     +               VGRAY(1,K,L,M),ETRAY(1,K,L,M))


         DO I=1,3
            VG = VG+VGRAY(I,K,L,M)**2
         ENDDO
         VG = 1.0/SQRT(VG)


         DO I=1,3
            QX(I,1) = QXRAY(I,1,K,L,M)
            QX(I,2) = QXRAY(I,2,K,L,M)
            QX(I,3) = VGRAY(I,K,L,M)*VG
         ENDDO


         DETQ  = QX(1,1)*(QX(2,2)*QX(3,3)-QX(3,2)*QX(2,3)) -
     +           QX(1,2)*(QX(2,1)*QX(3,3)-QX(3,1)*QX(2,3)) +
     +           QX(1,3)*(QX(2,1)*QX(3,2)-QX(3,1)*QX(2,2)) 

         WRK1 = SQRT(ABS(DETQ))



C---  Debugging printout
C      WRITE(6,*) 'JELWAY: DETQ = ',WRK1


C---     Create the KMAH index along the ray. The index is MODULO 4 !!!!!!


         IF (ABS(DETQ).GT.1.0) THEN
            IND = INT( DETQ / ABS(DETQ) )
         ELSE
            IND = -1
         ENDIF


         IF (INT(IND+IND_OLD).EQ.0) THEN
            KINDX(K,L,M) = 1
         ELSE
            KINDX(K,L,M) = 0
         ENDIF

         IND_OLD=IND

c$$$         GDIV = CSQRT(CMPLX(DETQ))
c$$$         WRK2 = REAL(GDIV)

         WRK2 = 0.0
         GSRAY(1,K,L,M) = WRK1
         GSRAY(2,K,L,M) = ACOS(WRK2/WRK1)

      ENDDO

 1    FORMAT(A,I4,2F8.1,I4,4F8.4)


C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE JELWAY
C-----------------------------------------------------------------------




