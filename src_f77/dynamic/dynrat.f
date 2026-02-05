C************************************************************************
C
C SUBROUTINE DYNRAT
C
C PURPOSE: Perform dynamic raytracing of Q1x,P1x OR Q2x,P2x
C          for a known kinetic ray by the Runge-Kutta method.
C
C NOTE   : Geological model on grid (ELK) is REAL*4
C
C REFERENCES: 
C       1. Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures, 
C          chapters 2.2 and 3.6. Lecture notes, 
C          University of Trondheim, 1995.
C       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
C
C SUBROUTINES CALLED : DYNZRO DYNINT RKERR
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY   1999
C                      KETIL HOKSTAD SEPTEMBER 1999
C                      KETIL HOKSTAD FEBRUARY  2000
C
C************************************************************************

      SUBROUTINE DYNRAT(NRAYEL,QXRAY,PXRAY,KINIT,
     +                  TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                  ITH,IPH,MTH,MPH,MAXEL,T0,T1,KEVIN,KMODE,KDIR,
     +                  KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,IERR,JERR)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     T0,T1               ! Initial and max traveltime
      INTEGER    KINIT               ! Pane wave or point source init.
      INTEGER    KEVIN               ! How to solve Christoffel eq?
      INTEGER    KMODE(3)            ! Current wave mode in KMODE(1)
      INTEGER    KDIR                ! Initial diraction. (Down=+1/Up=-1)
      INTEGER    ITH,IPH             ! Current ray index
      INTEGER    MAXEL,MTH,MPH       ! Dimensions of ray data arrays.
      INTEGER    NRAYEL(MTH,MPH)          ! Number of rayelements
      REAL*8     TRAY (MAXEL,MTH,MPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,MTH,MPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,MTH,MPH)   ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,MTH,MPH)   ! Ray group velocity
      REAL*8     ETRAY(3,MAXEL,MTH,MPH)   ! Ray deriv. of slowness
      REAL*8     GNRAY(3,MAXEL,MTH,MPH)   ! Ray eigenvals. (no sqrt)
      REAL*8     GVRAY(3,3,MAXEL,MTH,MPH) ! Ray eigenvectors 
      INTEGER    KASINO              ! Anisotropic symmetry type
C###  NOTE: The elastic model is REAL*4:
      INTEGER    NX,NY,NZ            ! Size of elastic grid model
      INTEGER    NELK                ! No of independent elastic moduli
      REAL*4     ELK4(NX,NY,NZ,NELK) ! Density norm. moduli on a grid
      REAL*4     DXGRI4(3)           ! (x,y,z) steplength in moduli
      REAL*4     X0GRI4(3)           ! (x,y,z) coord. of ELK4(1,1,1,*)
      INTEGER    NPOLX,NPOLY,NPOLZ   ! Degree of interpolating polynomial
      INTEGER    NPXYZ               ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4     CA4(NPXYZ+1,3)      ! Precomputed array for interpolation
      REAL*4     DA4(NPXYZ+1,3)      ! Precomputed array for interpolation 

C---  External output variables:
      REAL*8     QXRAY(3,2,MAXEL,MTH,MPH) ! Matrix Qx in Cartesian coord.
      REAL*8     PXRAY(3,2,MAXEL,MTH,MPH) ! Matrix Px in Cartesian coord.
      INTEGER    IERR,JERR                ! Error flags

C---  Parameters:
      INCLUDE   '../include_files/runge_kutta.inc'
      INCLUDE   '../include_files/ray_control.inc'

C---  Internal variables:
      INTEGER   I,J,K,L,M            ! Counters
      REAL*8    HY(3,3)
      REAL*8    QY0(2,2),PY0(2,2)
      REAL*8    QX0(3,2),PX0(3,2)

C*************** DEBUGGING *************************
c$$$      WRITE(6,*) 'SUBROUTINE DYNRAT:'
c$$$      WRITE(6,*) '   + KMODE    = ',(KMODE(I),I=1,3)
c$$$      WRITE(6,*) '   + MPH, MTH = ',MPH, MTH 
c$$$      WRITE(6,*) '   + IPH, ITH = ',IPH, ITH 
c$$$      WRITE(6,*) '   + MAXEL    = ',MAXEL
c$$$      WRITE(6,*) '   + T0,T1    = ',T0,T1
C***************************************************

C-----------------------------------------------------------------------
C  Initialize
C-----------------------------------------------------------------------

      L = MIN(ITH,MTH)
      M = MIN(IPH,MPH)

c$$$      DO K=1,MAXEL
c$$$C---     Scalars:
c$$$C---     Vectors:
c$$$C---     Tensors:
c$$$         DO J=1,2
c$$$            DO I=1,3
c$$$               QXRAY (I,J,K,L,M) = 0.0 
c$$$               PXRAY (I,J,K,L,M) = 0.0 
c$$$            ENDDO
c$$$         ENDDO
c$$$      ENDDO

C-----------------------------------------------------------------------
C  Plane wave or point source initial conditions?
C-----------------------------------------------------------------------

      DO J=1,2
         DO I=1,2
            QY0(I,J) = 0.0
            PY0(I,J) = 0.0
         ENDDO
      ENDDO
      
      IF (KINIT.EQ.KPLANE) THEN
         QY0(1,1) = 1.0
         QY0(2,2) = 1.0
      ELSE
         PY0(1,1) = 1.0
         PY0(2,2) = 1.0
      ENDIF

C-----------------------------------------------------------------------
C  Compute initial conditions in cartesian coordinates
C-----------------------------------------------------------------------
      
c$$$      WRITE(6,*) '   + CALL DYNZRO :'

      CALL DYNZRO(QY0,PY0,XRAY (1,1,L,M),PRAY (1,1,L,M),
     +            GVRAY(1,1,1,L,M),KMODE,HY,QX0,PX0,2,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,IERR)
c$$$      IF(L.EQ.1) THEN
c$$$         WRITE(6,*) 'HY(I,1) = ',(HY(I,1),I=1,3)
c$$$         WRITE(6,*) 'HY(I,2) = ',(HY(I,2),I=1,3)
c$$$         WRITE(6,*) 'HY(I,3) = ',(HY(I,3),I=1,3)
c$$$         WRITE(6,*) 'DYNRAT INITIAL COND:'
c$$$         WRITE(6,*) '  * QX0(I,1) = ',(QX0(I,1),I=1,3)
c$$$         WRITE(6,*) '  * QX0(I,2) = ',(QX0(I,2),I=1,3)
c$$$         WRITE(6,*) '  * PX0(I,1) = ',(PX0(I,1),I=1,3)
c$$$         WRITE(6,*) '  * PX0(I,2) = ',(PX0(I,2),I=1,3)
c$$$      ENDIF


C-----------------------------------------------------------------------
C  Kinetic raytracing by Runge-Kutta integration 
C-----------------------------------------------------------------------

c$$$      WRITE(6,*) '   + CALL DYNINT:'

      CALL DYNINT(NRAYEL(L,M),TRAY(1,L,M),XRAY(1,1,L,M),
     +            PRAY(1,1,L,M),VGRAY(1,1,L,M),ETRAY(1,1,L,M),
     +            GNRAY(1,1,L,M),GVRAY(1,1,1,L,M),
     +            QXRAY(1,1,1,L,M),PXRAY(1,1,1,L,M),MAXEL,
     +            QX0,PX0,T0,T1,KEVIN,KMODE,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,JERR)

c$$$      IF (IERR.NE.0) CALL RKERR(6,'DYNINT',ITH,IPH,NRAYEL(L,M),JERR)

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE DYNRAT
C-----------------------------------------------------------------------



