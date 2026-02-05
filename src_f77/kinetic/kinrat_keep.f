C************************************************************************
C
C SUBROUTINE KINRAT
C
C PURPOSE: Trace a kinematic ray with given initial phase 
C          direction by the Runge-Kutta method.
C
C NOTE   : Geological model on grid is REAL*4
C
C REFERENCES: 
C       1. Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures, 
C          chapters 2.2 and 3.6. Lecture notes, 
C          University of Trondheim, 1995.
C       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
C
C SUBROUTINES CALLED : KINZRO KININT RKERR
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD JANUARY   1999
C                      KETIL HOKSTAD SEPTEMBER 1999
C                      KETIL HOKSTAD FEBRUARY  2000
C
C************************************************************************

      SUBROUTINE KINRAT(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                  ITH,IPH,MTH,MPH,MAXEL,VNORM,X0,T0,T1,DTSAVE,
     +                  KEVIN,KMODE,KDIR,KASINO,ELK4,NX,NY,NZ,NELK,
     +                  DXGRI4,X0GRI4,NPOLX,NPOLY,NPOLZ,
     +                  CA4,DA4,NPXYZ,ACCUR,H0,HMIN,IERR,JERR)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     X0(3),VNORM(3)      ! Initial position and phase dir.
      REAL*8     T0,T1               ! Initial and max traveltime
      REAL*8     DTSAVE              ! Intervall for saving raypath
      INTEGER    KEVIN               ! How to solve Christoffel eq?
      INTEGER    KMODE(3)            ! Current wave mode in KMODE(1)
      INTEGER    KDIR                ! Initial diraction. (Down=+1/Up=-1)
      INTEGER    KASINO              ! Anisotropic symmetry type
      REAL*8     H0,HMIN             ! Initial and minimum steplength
      REAL*8     ACCUR               ! Required accuracy
      INTEGER    ITH,IPH             ! Current ray index
      INTEGER    MAXEL,MTH,MPH       ! Dimensions of ray data arrays.
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
      INTEGER    NRAYEL(MTH,MPH)          ! Number of rayelements
      REAL*8     TRAY (MAXEL,MTH,MPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,MTH,MPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,MTH,MPH)   ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,MTH,MPH)   ! Ray group velocity
      REAL*8     ETRAY(3,MAXEL,MTH,MPH)   ! Ray deriv. of slowness
      REAL*8     GNRAY(3,MAXEL,MTH,MPH)   ! Ray eigenvals. (no sqrt)
      REAL*8     GVRAY(3,3,MAXEL,MTH,MPH) ! Ray eigenvectors 
      INTEGER    IERR,JERR                ! Error flags

C---  Parameters:
      INCLUDE '../include_files/runge_kutta.inc'
      INCLUDE '../include_files/ray_control.inc'

C---  Internal variables:
      INTEGER   IERR                ! Error flag
      INTEGER   NGOD,NBAD           ! Runge-Kutta variables
      INTEGER   I,J,K,L,M,MRAYEL    ! Counters
      REAL*8    VPHASE              ! Phase velocity
      REAL*8    APHASE,UNORM(3)     ! Phase velocity
      REAL*8    P0(3)               ! Initial slowness
      REAL*8    GVEC(3,3),GN(3)     ! Initial eigen values/vectors

C-----------------------------------------------------------------------
C  Initialize
C-----------------------------------------------------------------------

      L = MIN(ITH,MTH)
      M = MIN(IPH,MPH)

      write(6,*) 'KINRAT: iph,ith,l,m = ',iph,ith,l,m

C-----------------------------------------------------------------------
C  Compute initial slowness for the current ray
C-----------------------------------------------------------------------
      
      CALL KINZRO(VNORM,KMODE,X0,P0,VPHASE,GN,GVEC,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,IERR)

cCUT      IF (IERR.NE.0) CALL RKERR(6,'KINZRO',ITH,IPH,0,IERR)

C-----------------------------------------------------------------------
C  Kinetic raytracing by Runge-Kutta integration 
C-----------------------------------------------------------------------

      CALL KININT(NRAYEL(L,M),TRAY(1,L,M),XRAY(1,1,L,M),
     +            PRAY(1,1,L,M),VGRAY(1,1,L,M),ETRAY(1,1,L,M),
     +            GNRAY(1,1,L,M),GVRAY(1,1,1,L,M),
     +            MAXEL,X0,P0,T0,T1,DTSAVE,KEVIN,KMODE,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,
     +            ACCUR,H0,HMIN,NGOD,NBAD,JERR)

cCUT      IF (IERR.NE.0) CALL RKERR(6,'KININT',ITH,IPH,NRAYEL(L,M),JERR)

C-----------------------------------------------------------------------
C  Check if the end point of the ray fulfills the eikonal equation
C-----------------------------------------------------------------------

      K = NRAYEL(L,M)

      APHASE = 0.0
      DO I=1,3
         APHASE = APHASE + PRAY(I,K,L,M)**2
      ENDDO
      APHASE = 1.0/SQRT(APHASE)

      DO I=1,3
         UNORM(I) = APHASE*PRAY(I,K,L,M)
      ENDDO

      WRITE(6,*) '   + CALL KINZRO (2nd):'
      CALL KINZRO(UNORM,KMODE,XRAY(1,K,L,M),
     +            P0,VPHASE,GN,GVEC,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,IERR)

      WRITE(6,*) '     - VPHASE = ',VPHASE
      WRITE(6,*) '     - APHASE = ',APHASE

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE KINRAT
C-----------------------------------------------------------------------







