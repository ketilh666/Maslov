C************************************************************************
C
C SUBROUTINE BFAVRE
C
C PURPOSE: Compute a simple approximation to geometrical spreading
C          based on quantities from kinetic raytracing only.
C
C REFERENCES: 
C          Hokstad, K., 1999: Geometrical spreading in a transverse 
C          isotropic medium with vertical symmetry axis. 
C          Brett Favre is the QB of Green Bay Packers.
C          Superbowl looser 1998.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY  1998
C
C************************************************************************

      SUBROUTINE BFAVRE(NRAYEL,GSRAY,TRAY,XRAY,PRAY,
     +                  ITH,IPH,MTH,MPH,MAXEL)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    ITH,IPH,MTH,MPH,MAXEL
      INTEGER    NRAYEL(MTH,MPH)          ! Number of rayelements
      REAL*8     TRAY (MAXEL,MTH,MPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,MTH,MPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,MTH,MPH)   ! Ray slowness

C---  External output variables:
      REAL*8     GSRAY(2,MAXEL,MTH,MPH)   ! Ray geometrical spreading

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'
      REAL       STHMIN
      PARAMETER (STHMIN=0.01d0)

C---  Internal variables:
      INTEGER    I,J,K,L,M
      REAL*8     PR(3),PS(3),YR(3)   ! Slowness and offset vectors
      REAL*8     PRH,YRH             ! Horizontal slowness and offset
      REAL*8     VPHS,VPHR           ! Phase velocity at source and rec.
      REAL*8     WRK1,WRK2

C-----------------------------------------------------------------------
C  Initialize
C-----------------------------------------------------------------------

      L = MIN(ITH,MTH)
      M = MIN(IPH,MPH)

C-----------------------------------------------------------------------
C  Compute brute approximation to geometrical spreading along the ray
C   * Magnitude   in GSRAY(1,K,L,M)
C   * Phase angle in GSRAY(2,K,L,M) is set to zero
C-----------------------------------------------------------------------

C---  Slowness and phase velocity at the source:
      VPHS = 0.0
      DO I=1,3
         PS(I) = PRAY(I,1,L,M)
         VPHS  = VPHS + PS(I)**2
      ENDDO
      VPHS = 1.0/SQRT(VPHS)

C---  Relative geometrical spreading along the ray:
      DO K=1,NRAYEL(L,M)

         VPHR = 0.0
         DO I=1,3
            PR(I) = PRAY(I,K,L,M)
            VPHR  = VPHR + PR(I)**2
         ENDDO
         VPHR = 1.0/SQRT(VPHR)

         WRK1 = 1.0/VPHS
         WRK2 = TRAY(K,L,M)*VPHR**2

c$$$         GSRAY(1,K,L,M) = WRK1*WRK2
         GSRAY(1,K,L,M) = TRAY(K,L,M)
         GSRAY(2,K,L,M) = 0.0d0

      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE BFAVRE
C-----------------------------------------------------------------------




