      PROGRAM DEBUG
      IMPLICIT NONE

C---  Parameters from include files:
      INCLUDE '../include_files/ray_control.inc'
      INCLUDE '../include_files/io_pars.inc'
      INCLUDE '../include_files/geo_model.inc'
      INCLUDE '../include_files/math_const.inc'

C---  Parameters for allocation of memory
      REAL*8      D2R,PI8
      INTEGER     MDEP
      INTEGER     NFIL
      INTEGER     NX,NY,NZ,NELK
      INTEGER     NTH,NPH,MAXEL
      INTEGER     MTH,MPH
      INTEGER     NT,NW,MW
      PARAMETER ( MDEP=1 )
      PARAMETER ( NFIL=10 )
      PARAMETER ( PI8=3.141592654, D2R=PI8/180.0   )
      PARAMETER ( NX =201 , NY=201, NZ=201, NELK=5 )
      PARAMETER ( NPH     =   1 )
C      PARAMETER ( NTH     =  11 ) ! For making ray plots.
      PARAMETER ( NTH     =  121 )
      PARAMETER ( MPH     =   1 )
      PARAMETER ( MTH     = NTH )
      PARAMETER ( MAXEL   = 102 )
      PARAMETER ( NT=1001, NW=1024, MW=NW/2+1 )

C---  Arrays:
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

C###  NOTE: The elastic model is REAL*4:
      REAL*4     ELK4(NX,NY,NZ,NELK)      ! Density norm. moduli on a grid
      REAL*4     DXGRI4(3),X0GRI4(3)
      INTEGER    NPOLX,NPOLY,NPOLZ        ! Degree of interpolating polynomial
      INTEGER    NPXYZ                    ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4     CA4(MAXPOL+1,3)          ! Precomputed array for interpolation
      REAL*4     DA4(MAXPOL+1,3)          ! Precomputed array for interpolation 
C###  Temp variables for making the grid:
      REAL*8     X8(3)
      REAL*8     CIJ  (6,6    )     ! Voigt matrix
      REAL*8     DCIJ (6,6,3  )     ! 1st derivatives of Voigt matrix
      REAL*8     DDCIJ(6,6,3,3)     ! 2nd derivatives of Voigt matrix

C###  NOTE: Variables for Maslov integration is REAL*4 and COMPLEX*4
      REAL*4     ATT,DT,DW
      REAL*4     FLOCU,FLOCO,FHICO,FHICU
      INTEGER    IWLOCU,IWLOCO,IWHICO,IWHICU
      REAL*4     RWRK(NT,MTH)
      REAL*4     SCL(NW)
      COMPLEX    CWRK1(NW),CWRK2(MTH,MW)
      COMPLEX    WARR(NW)
      COMPLEX    CGREEN(3,3,MTH,MPH,MW)

C---  Scalars:
      INTEGER    I,J,K,ISHOT      ! Loop counters
      INTEGER    IX,IY,IZ         ! Loop counters
      INTEGER    IREC0,JREC0      ! Direct access I/O record counter
      INTEGER    KASINO
      INTEGER    KEVIN
      INTEGER    KSCHEM
      INTEGER    KDIR             ! Initial direction. (Down=+1/Up=-1)
      INTEGER    LUF(NFIL),LUG(3,3) ! File unit numbers
      REAL*8     X0(3)            ! Initial position  of the ray
      REAL*8     T0,T1            ! Initial and max traveltime
      REAL*8     DTSAVE           ! Intervall for saving raypath
      REAL*8     PH1,DPH          ! Initial polar phase angle  (radians)
      REAL*8     TH1,DTH          ! Initial phase angle with z (radians)
      REAL*8     H0,HMIN          ! Initial and minimum steplength
      REAL*8     ACCUR            ! Required accuracy

      CHARACTER*80  CNAME(NFIL)   ! Filenames
      CHARACTER*80  GNAME(3,3)    ! Filenames

C---  New parameters to test binning
      INTEGER MAXINB,NXBMAX,NYBMAX     ! Dimension of binning table
      PARAMETER (MAXINB=10,NXBMAX=10*NTH,NYBMAX=10*NPH)
      INTEGER NPTAB(NXBMAX,NYBMAX)     ! Number of rays in each bin
      INTEGER JPTAB(2,MAXINB,NXBMAX*NYBMAX) ! Rays in each bins

C-----------------------------------------------------------------------
C   JOB PARAMETERS
C-----------------------------------------------------------------------

C---  Source position:
      X0(1)  =   300.0
      X0(2)  =   300.0
      X0(3)  =     0.0

C---  Min and Max traveltime:
      T0     =     0.0
      T1     =     1.0

C---  Parameters controlig raytracing:
      KDIR   = K_DN  
      KSCHEM = K_DYN2
      KEVIN  = KBRUT
      KASINO = K_TIV

C---  Phase angles (D2R is degrees to radians coefficient):
      PH1    =  D2R*  0.0
      DPH    =  D2R*  0.0
c$$$      TH1    =  D2R*-25.0    ! For making ray plots
c$$$      DTH    =  D2R*  5.0    ! For making ray plots
      TH1    =  D2R*-30.5
      DTH    =  D2R*  0.5

C---  Runge-Kutta parameters:
      DTSAVE =  (T1-T0)/REAL(MAXEL-1)
      ACCUR  =  1.0d-3
      H0     =  2.0d-2
      HMIN   =  1.0d-6

C---  Fourier parameters
      DT    = 0.004
      ATT   =   1.0
      FLOCU =   3.0
      FLOCO =   6.0
      FHICO =  50.0
      FHICU =  80.0

C-----------------------------------------------------------------------
C   FILENAMES
C-----------------------------------------------------------------------

      CNAME( 1)  = 'ERRLOG.ascii'
      CNAME( 2)  = 'LOGFIL.ascii'
      CNAME( 3)  = 'NRAYEL.ascii'
      CNAME( 4)  = 'RAYDATA.dir'
      CNAME( 5)  = 'KAST5.dir'
      CNAME( 6)  = 'KAST6.dir'
      CNAME( 7)  = 'RAY_TI.dir'
      CNAME( 8)  = 'RAY_XZ.dir'
      CNAME( 9)  = 'RAY_YZ.dir'
      CNAME(10)  = 'RAY_XY.dir'

      GNAME(1,1) = 'GREEN_XX.dir'
      GNAME(1,2) = 'GREEN_XY.dir'
      GNAME(1,3) = 'GREEN_XZ.dir'
      GNAME(2,1) = 'GREEN_YX.dir'
      GNAME(2,2) = 'GREEN_YY.dir'
      GNAME(2,3) = 'GREEN_YZ.dir'
      GNAME(3,1) = 'GREEN_ZX.dir'
      GNAME(3,2) = 'GREEN_ZY.dir'
      GNAME(3,3) = 'GREEN_ZZ.dir'

C-----------------------------------------------------------------------
C   COMPUTE MODEL ON GRID
C-----------------------------------------------------------------------

      NPOLX = 5
      NPOLY = 5
      NPOLZ = 5
      NPXYZ = MAX(NPOLX,NPOLY,NPOLZ)

C---  DX and X0 for the grid
      DO I=1,3
         X0GRI4(I) = 300.0 - 1000.0
         DXGRI4(I) =  10.0
      ENDDO

      DO IZ=1,NX
         DO IY=1,NY
            DO IX=1,NX
               X8(1) = DREAL(X0GRI4(1)+REAL(IX-1)*DXGRI4(1))
               X8(2) = DREAL(X0GRI4(2)+REAL(IY-1)*DXGRI4(2))
               X8(3) = DREAL(X0GRI4(3)+REAL(IZ-1)*DXGRI4(3))
               CALL GAUSS2(CIJ,DCIJ,DDCIJ,X8,0)
               ELK4(IX,IY,IZ,1) = REAL(CIJ(1,1))
               ELK4(IX,IY,IZ,2) = REAL(CIJ(3,3))
               ELK4(IX,IY,IZ,3) = REAL(CIJ(3,1))
               ELK4(IX,IY,IZ,4) = REAL(CIJ(4,4))
               ELK4(IX,IY,IZ,5) = REAL(CIJ(6,6))
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C   OPEN I/O FILES
C-----------------------------------------------------------------------

C---  Assign file unit numbers:
c$$$      LUF(1) = 6
c$$$      LUF(2) = 6
      DO I=1,NFIL
         LUF(I) = 10+I
      ENDDO

      DO J=1,3
         DO I=1,3
            LUG(I,J) = 30 + I +(J-1)*3
         ENDDO
      ENDDO

         IF (LUF(1).GT.10) OPEN(LUF(1),FILE=CNAME(I),FORM='FORMATTED')
         IF (LUF(2).GT.10) OPEN(LUF(2),FILE=CNAME(2),FORM='FORMATTED')
         IF (LUF(3).GT.10) OPEN(LUF(3),FILE=CNAME(3),FORM='FORMATTED')

         OPEN(LUF( 4),FILE=CNAME( 4),FORM='UNFORMATTED',
     +                ACCESS='DIRECT',RECL=MDEP*NIO1)
         OPEN(LUF( 5),FILE=CNAME( 5),FORM='UNFORMATTED',
     +                ACCESS='DIRECT',RECL=MDEP*NIO1)
         OPEN(LUF( 6),FILE=CNAME( 6),FORM='UNFORMATTED',
     +                ACCESS='DIRECT',RECL=MDEP*NIO1)

         OPEN(LUF( 7),FILE=CNAME( 7),FORM='UNFORMATTED',
     +                ACCESS='DIRECT',RECL=MDEP*NIO2)
         OPEN(LUF( 8),FILE=CNAME( 8),FORM='UNFORMATTED',
     +                ACCESS='DIRECT',RECL=MDEP*NIO2)
         OPEN(LUF( 9),FILE=CNAME( 9),FORM='UNFORMATTED',
     +                ACCESS='DIRECT',RECL=MDEP*NIO2)
         OPEN(LUF(10),FILE=CNAME(10),FORM='UNFORMATTED',
     +                ACCESS='DIRECT',RECL=MDEP*NIO2)

C***  Write offsets with RECL=1
c$$$      OPEN(LUF(10),FILE=CNAME(I),FORM='UNFORMATTED',
c$$$     +            ACCESS='DIRECT',RECL=MDEP)

      DO J=1,3
         DO I=1,3
            OPEN(LUG(I,J),FILE=GNAME(I,J), FORM='UNFORMATTED',
     +                    ACCESS='DIRECT',RECL=MDEP*NT)
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C   Convert to integer frequencies
C-----------------------------------------------------------------------

      IWLOCU = 1 + NINT(FLOCU*DT*REAL(NW))
      IWLOCO = 1 + NINT(FLOCO*DT*REAL(NW))
      IWHICO = 1 + NINT(FHICO*DT*REAL(NW))
      IWHICU = 1 + NINT(FHICU*DT*REAL(NW))

C-----------------------------------------------------------------------
C
C   TEST RAYTRACER: LOOP OVER WAVEMODES qS1, qS2, qP
C
C-----------------------------------------------------------------------

      JREC0 = 0
      IREC0 = 0
      ISHOT = 1

      CALL MASLOV(WARR,NW,CGREEN,MTH,MPH,IWLOCU,IWLOCO,
     +            IWHICO,IWHICU,DT,ATT,CWRK1,CWRK2,RWRK,
     +            SCL,NT,NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,
     +            GNRAY,GVRAY,GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,
     +            KSCHEM,MAXEL,NTH,NPH,PH1,DPH,TH1,DTH,
     +            ISHOT,X0,T0,T1,DTSAVE,KEVIN,KDIR,
     +            KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,
     +            ACCUR,H0,HMIN,LUF,NFIL,LUG,IREC0,JREC0,
     +            NPTAB,JPTAB,NXBMAX,NYBMAX,MAXINB)


C-----------------------------------------------------------------------
C   CLOSE I/O FILES
C-----------------------------------------------------------------------

      DO I=1,NFIL
         IF(LUF(I).GT.10) CLOSE(LUF(I))
      ENDDO

      DO J=1,3
         DO I=1,3
            CLOSE(LUG(I,J))
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      END 
C-----------------------------------------------------------------------
C    END OF PROGRAM DEBUG
C-----------------------------------------------------------------------




















