C************************************************************************
C
C SUBROUTINE RAIUNO
C
C PURPOSE: Trace geometrical rays for a set of selected initial
C          phase angles by the Runge-Kutta method.
C          Here are some GUIDELINES for setting the 
C          Runge-Kutta control parameters:
C          * ACCUR  : Max relative error that is tolerated. This
C                     parameter is used to adjust the step size. A
C                     reasonable value is ACCUR=0.001.
C          * H1     : The initial trial steplength used.  
C                     Usually H1=0.01 will do the job.
C          * HMIN   : The minimum acceptabel step size. May be
C                     set equal to zero. HMIN=0.01*H1 is OK.
C          * DTSAVE : Time intervall for storing raypath. Do not
C                     set it to small if you want to use the data 
C                     for futher computations. DTSAVE=0.0 saves 
C                     everything.
C
C REFERENCES: 
C       1. Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures, 
C          chapters 2.2 and 3.6. Lecture notes, 
C          University of Trondheim, 1995.
C       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
C
C SUBROUTINES CALLED : KINRAT DYNRAT JELWAY BFAVRE WTHDR WTRAY
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD JANUARY   1999
C                      KETIL HOKSTAD FEBRUARY  1999
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE RAIUNO(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,
     +                  GVRAY,GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,
     +                  KSCHEM,MAXEL,NTH,NPH,PH1,DPH,TH1,DTH,
     +                  ISHOT,X0,T0,T1,DTSAVE,KEVIN,KMODE,KDIR,
     +                  KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,
     +                  ACCUR,H0,HMIN,LUF,NFIL,JREC0,KINDX)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    MAXEL                ! Max no of rayelements
      INTEGER    NTH,NPH              ! Number of initial phase angles
      REAL*8     PH1,DPH              ! Polar phase angle       (Radians)
      REAL*8     TH1,DTH              ! Phase angle with z-axis (Radians)
      REAL*8     X0(3)                ! Initial position
      REAL*8     T0,T1                ! Initial and max traveltime
      REAL*8     DTSAVE               ! Intervall for saving raypath
      INTEGER    KEVIN                ! How to solve Christoffel eq?
      INTEGER    KMODE(3)             ! Current wave mode in KMODE(1)
      INTEGER    KDIR                 ! Initial direction. (Down=+1/Up=-1)
      REAL*8     H0,HMIN              ! Initial and minimum steplength
      REAL*8     ACCUR                ! Required accuracy
      INTEGER    ISHOT                ! Current shot position number
      INTEGER    KSCHEM               ! Kinetic, dynamic or both
      INTEGER    NFIL,LUF(NFIL)       ! I/O unit numbers
      INTEGER    JREC0                ! Last record written to disk
      INTEGER    KINDX(MAXEL,NTH,NPH) ! The KMAH index along the ray segments
      INTEGER    KASINO               ! Anisotropic symmetry type
C###  NOTE: The elastic model is REAL*4:
      INTEGER    NX,NY,NZ             ! Size of elastic grid model
      INTEGER    NELK                 ! No of independent elastic moduli
      REAL*4     ELK4(NX,NY,NZ,NELK)  ! Density norm. moduli on a grid
      REAL*4     DXGRI4(3)            ! (x,y,z) steplength in moduli
      REAL*4     X0GRI4(3)            ! (x,y,z) coord. of ELK4(1,1,1,*)
      INTEGER    NPOLX,NPOLY,NPOLZ    ! Degree of interpolating polynomial
      INTEGER    NPXYZ                ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4     CA4(NPXYZ+1,3)       ! Precomputed array for interpolation
      REAL*4     DA4(NPXYZ+1,3)       ! Precomputed array for interpolation 

C---  External output variables:
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
      INCLUDE '../include_files/runge_kutta.inc'
      INCLUDE '../include_files/ray_control.inc'

C---  Internal variables:
      LOGICAL    LKIN,LDYN1,LDYN2
      INTEGER    ITH1,IPH1          ! Loop counters
      INTEGER    ITH,IPH            ! Loop counters
      REAL*8     PH,TH              ! Phase angles (polar/z-axis)
      REAL*8     VNORM(3)           ! Initial phase direction
      INTEGER    LUERR,LULOG,LUNEL  ! I/O unit numbers.
      INTEGER    LURAY,LUDYN        ! I/O unit numbers.
      INTEGER    LUGBM,LUMAS        ! I/O unit numbers.
      INTEGER    LURXZ,LURYZ,LURXY  ! I/O unit numbers.
      INTEGER    I,J,K,L,M

C------------------------------------------------------------
C  Unpack I/O Unit numbers
C------------------------------------------------------------

      LUERR = LUF( 1)
      LULOG = LUF( 2)
      LUNEL = LUF( 3)
      LURAY = LUF( 4)
      LUDYN = LUF( 5) ! Not currently used
      LUGBM = LUF( 6)
      LUMAS = LUF( 7)
      LURXZ = LUF( 8)
      LURYZ = LUF( 9)
      LURXY = LUF(10)

C------------------------------------------------------------
C  Dynamic raytracing mode
C------------------------------------------------------------

      LKIN  = .TRUE.
      LDYN1 = (KSCHEM.EQ.K_DYN1 .OR. KSCHEM.EQ.K_DYN)
      LDYN2 = (KSCHEM.EQ.K_DYN2 .OR. KSCHEM.EQ.K_DYN)

C      LDYN1 = .FALSE.
C      LDYN2 = .FALSE.
C----------------------------------------------
C  Write header to ascii file
C----------------------------------------------

      CALL WTHDR(LUNEL,ISHOT,KMODE,NTH,NPH)

C*************** DEBUGGING *************************
      WRITE(LULOG,*) 'SUBROUTINE RAIUNO:'
      WRITE(LULOG,*) ' * KMODE    = ',(KMODE(I),I=1,3)
      WRITE(LULOG,*) ' * NPH, NTH = ',NPH, NTH 
      WRITE(LULOG,*) ' * MAXEL    = ',MAXEL
      WRITE(LULOG,*) ' * TH1,DTH  = ',TH1,DTH
      WRITE(LULOG,*) ' * PH1,DPH  = ',PH1,DPH
      WRITE(LULOG,*) ' * T0,T1    = ',T0,T1
      WRITE(LULOG,*) ' * X0_i     = ',(X0(I),I=1,3)
      WRITE(LULOG,*) ' * DTSAVE   = ',DTSAVE
      WRITE(LULOG,*) ' * ACCUR    = ',ACCUR
      WRITE(LULOG,*) ' * NX,NY,NZ = ',NX,NY,NZ
      WRITE(LULOG,*) ' * NELK     = ',NELK
C***************************************************

C-----------------------------------------------------------------------
C
C  LOOP OVER INITIAL PHASE DIRECTIONS:
C   * PH = Polar angle in the (X,Y)-plane
C   * TH = Angle with the z-axis 
C  C$DOACROSS : 
C   * Power compiler directive for paralell execution on SGI
C   * Variables on the LOCAL() list are duplicated on all CPUs.
C
C-----------------------------------------------------------------------

      WRITE(6,*) 'RAYTRACING:'
         
      DO IPH = 1,NPH
CcutC$       DOACROSS LOCAL(ITH,PH,TH,VNORM),MP_SCHEDTYPE=DYNAMIC,CHUNK=1
         DO ITH= 1,NTH

C            WRITE(6,*) '   ITH = ', ITH

C---------------------------------------------------------------------
C  Kinematic raytracing
C---------------------------------------------------------------------
            
C---        Initial phase direction:
            PH = PH1 + REAL(IPH-1)*DPH
            TH = TH1 + REAL(ITH-1)*DTH
            VNORM(1) = SIN(TH)*COS(PH)
            VNORM(2) = SIN(TH)*SIN(PH)
            VNORM(3) = COS(TH)*REAL(KDIR)

C---        Trace the ray:
            CALL KINRAT(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                  ITH,IPH,NTH,NPH,MAXEL,VNORM,X0,T0,T1,DTSAVE,
     +                  KEVIN,KMODE,KDIR,KASINO,ELK4,NX,NY,NZ,NELK,
     +                  DXGRI4,X0GRI4,NPOLX,NPOLY,NPOLZ,
     +                  CA4,DA4,NPXYZ,ACCUR,H0,HMIN,LUERR)

C---------------------------------------------------------------------
C  Dynamic raytracing
C---------------------------------------------------------------------

C---        Plane wave initial conditions:
            IF (LDYN1) THEN
               CALL DYNRAT(NRAYEL,Q1RAY,P1RAY,KPLANE,
     +                     TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                     ITH,IPH,NTH,NPH,MAXEL,T0,T1,KEVIN,KMODE,
     +                     KDIR,KASINO,ELK4,NX,NY,NZ,NELK,
     +                     DXGRI4,X0GRI4,NPOLX,NPOLY,NPOLZ,
     +                     CA4,DA4,NPXYZ,LUERR)
            ENDIF

C---        Point source initial conditions:
            IF (LDYN2) THEN
               CALL DYNRAT(NRAYEL,Q2RAY,P2RAY,KPOINT,
     +                     TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                     ITH,IPH,NTH,NPH,MAXEL,T0,T1,KEVIN,KMODE,
     +                     KDIR,KASINO,ELK4,NX,NY,NZ,NELK,
     +                     DXGRI4,X0GRI4,NPOLX,NPOLY,NPOLZ,
     +                     CA4,DA4,NPXYZ,LUERR)
            ENDIF

C---------------------------------------------------------------------
C  Geometrical spreading along the ray
C---------------------------------------------------------------------

            IF (LDYN2) THEN
               CALL JELWAY(NRAYEL,GSRAY,TRAY,XRAY,PRAY,VGRAY,
     +                     ETRAY,GVRAY,Q2RAY,P2RAY,ITH,IPH,
     +                     NTH,NPH,MAXEL,KINDX)
            ELSE
               CALL BFAVRE(NRAYEL,GSRAY,TRAY,XRAY,PRAY,
     +                     ITH,IPH,NTH,NPH,MAXEL)
            ENDIF

         ENDDO
      ENDDO

C------------------------------------------------------------
C  Write results to disk
C------------------------------------------------------------

      WRITE(6,*) 'WRITE TO DISK'

      IPH1 = 1
      ITH1 = 1

      CALL WTRAY(KMODE,ITH1,IPH1,NTH,NPH,MAXEL,NRAYEL,TRAY,
     +           XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +           GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,JREC0,
     +           LUNEL,LURAY,LURXZ,LURYZ,LURXY)


C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE RAIUNO
C-----------------------------------------------------------------------





