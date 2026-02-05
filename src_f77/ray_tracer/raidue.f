C************************************************************************
C
C SUBROUTINE RAIDUE
C
C PURPOSE: 
C
C REFERENCES: 
C
C SUBROUTINES CALLED : SHENN8 SHEFU8 SHEI38
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE RAIDUE(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,
     +                  GVRAY,GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,
     +                  KSCHEM,MAXEL,NTH,NPH,NSHE,LUF,NFIL)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NSHE                 ! Max no of rayelements
      INTEGER    MAXEL                ! Max no of rayelements
      INTEGER    NTH,NPH              ! Number of initial phase angles
      INTEGER    KSCHEM               ! Kinetic, dynamic or both
      INTEGER    NFIL,LUF(NFIL)       ! I/O unit numbers

C---  External input and output variables:
      INTEGER    NRAYEL(NTH,NPH)          ! Number of rayelements
      REAL*8     TRAY (MAXEL,NTH,NPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,NTH,NPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,NTH,NPH)   ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,NTH,NPH)   ! Ray group velocity
      REAL*8     ETRAY(3,MAXEL,NTH,NPH)   ! Ray deriv. of slowness
      REAL*8     GSRAY(2,MAXEL,NTH,NPH)   ! Complex geom spreading
      REAL*8     GNRAY(3,MAXEL,NTH,NPH)   ! Ray eigenvals. (no sqrt)
      REAL*8     GVRAY(3,3,MAXEL,NTH,NPH) ! Ray eigenvectors 
      REAL*8     Q1RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix Q1x (Cartesian)
      REAL*8     P1RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix P1x (Cartesian)
      REAL*8     Q2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix Q2x (Cartesian)
      REAL*8     P2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix P2x (Cartesian)

C---  Parameters:
      INCLUDE '../include_files/io_pars.inc'
      INCLUDE '../include_files/runge_kutta.inc'
      INCLUDE '../include_files/ray_control.inc'
      INCLUDE '../include_files/interpol.inc'

C---  Internal variables:
      LOGICAL    LKIN,LDYN1,LDYN2
      LOGICAL    LENTRE
      INTEGER    LURXZ,LURYZ,LURXY  ! I/O unit numbers.
      INTEGER    IX,IY,I,J,K
      INTEGER    JTH,JPH
      INTEGER    NNTAB(3,MAXSHE)
      REAL*8     XNOD(3,MAXSHE)
      REAL*8     SHEW(MAXSHE)
      REAL*8     FUN1(1,MAXSHE),FUN2(2,MAXSHE),FUN3(3,MAXSHE)
      REAL*8     SIP(3)
      REAL*8     X0(3),DX(3),XINT(3)
      REAL*4     RYZ(2)

C------------------------------------------------------------
C  Unpack I/O Unit numbers
C------------------------------------------------------------

      LURYZ  = LUF(7)

C------------------------------------------------------------
C  Dynamic raytracing mode
C------------------------------------------------------------

      LKIN  = .TRUE.
      LDYN1 = (KSCHEM.EQ.K_DYN1 .OR. KSCHEM.EQ.K_DYN)
      LDYN2 = (KSCHEM.EQ.K_DYN2 .OR. KSCHEM.EQ.K_DYN)

C      LDYN1 = .FALSE.
C      LDYN2 = .FALSE.

C-----------------------------------------------------------------------
C
C     LOOP OVER OUTPUT POSITIONS 
C 
C-----------------------------------------------------------------------

      WRITE(6,*) 'RAY INTERPOLATION'
         
      X0(1) = -200.0
      X0(2) =  300.0
      X0(3) =  650.0

      DX(1) = 1000.0d0/DREAL(NTH-1)
      DX(2) =    0.0
      DX(3) =    0.0

C*************** DEBUGGING *************************
      WRITE(6,*) 'SUBROUTINE RAIDUE:'
      WRITE(6,*) ' * NPH, NTH = ',NPH, NTH 
      WRITE(6,*) ' * MAXEL    = ',MAXEL
      WRITE(6,*) ' * DX       = ',DX(1)
C***************************************************

      IY = 1
      DO IX=1,NTH

         XINT(1) = X0(1) + DREAL(IX-1)*DX(1)
         XINT(2) = X0(2)
         XINT(3) = X0(3)

C-----------------------------------------------------------------------
C        Find nearest neighbors
C-----------------------------------------------------------------------

         IF (I .EQ. 1) THEN
            LENTRE = .TRUE.
         ELSE
            LENTRE = .TRUE.
         ENDIF

         CALL SHENN8(NNTAB,NSHE,XINT,XRAY,NRAYEL,
     +               MAXEL,NTH,NPH,LENTRE)

         DO J=1,NSHE
            K   = NNTAB(1,J)
            JTH = NNTAB(2,J)
            JPH = NNTAB(3,J)
            XNOD(1,J) = XRAY(1,K,JTH,JPH)
            XNOD(2,J) = XRAY(2,K,JTH,JPH)
            XNOD(3,J) = XRAY(3,K,JTH,JPH)
         ENDDO

C-----------------------------------------------------------------------
C        Compute Shepard weight functions
C-----------------------------------------------------------------------

         CALL SHEFU8(SHEW,NSHE,XNOD,XINT)

C-----------------------------------------------------------------------
C        Interpolate traveltimes
C-----------------------------------------------------------------------

         DO J=1,NSHE
            K   = NNTAB(1,J)
            JTH = NNTAB(2,J)
            JPH = NNTAB(3,J)
            FUN1(1,J) = TRAY(K,JTH,JPH)
         ENDDO

         CALL SHEI38(SIP,1,FUN1,SHEW,NSHE)

         TRAY(MAXEL,IX,IY) = SIP(1)

         WRITE(6,*) 'IX,XINT=',IX,XINT(1)
         DO J=1,NSHE
            K   = NNTAB(1,J)
            JTH = NNTAB(2,J)
            JPH = NNTAB(3,J)
            WRITE(6,1) ' * J,K,ITH,IPH,X,Z=',
     +                 J,K,JTH,JPH,XNOD(1,J),XNOD(2,J),XNOD(3,J),
     +                 XINT(1),SIP(1)
         ENDDO            
 1       FORMAT(A,4I5,5F10.3)
C-----------------------------------------------------------------------
C        Write to disk
C-----------------------------------------------------------------------

         RYZ(1) = REAL(TRAY(MAXEL,IX,IY))
         RYZ(2) = REAL(XRAY(1,MAXEL,IX,IY))-300.0
         WRITE(LURYZ,REC=IX) (RYZ(I),I=1,NIO2)

      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE RAIDUE
C-----------------------------------------------------------------------





