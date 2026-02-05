C************************************************************************
C
C SUBROUTINE MASLOV
C
C PURPOSE: Compute the 3D Maslov Green's funtion. in the
C
C REFERENCES: 
C       1. Kendall and Thomson, 1993: Maslov ray summation, pseudo-caustics,
C          Lagrangian equivalence and transient seismic waveforms:
C          Geophys J. Int. Vol 113, pp 186-214.
C       2. DeHoop and Brandsberg-Dahl, 1999: Maslov asymptotic
C          extension of Generalized Radon Transform in anisotropic
C          elastic media: a Least-Squares approach.
C       3. Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures, 
C          chapters 2.2 and 3.6. Lecture notes, 
C          University of Trondheim, 1995.
C
C SUBROUTINES CALLED : NODEW RAIUNO INTERP 
C                      BINDIM BINNIT FREMAS WTSEIS
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD FEBRUARY  1999
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE MASLOV(WARR,NW,CGREEN,MTH,MPH,IWLOCU,IWLOCO,
     +                  IWHICO,IWHICU,DT,ATT,CWRK1,CWRK2,RWRK,
     +                  SCL,NT,NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,
     +                  GNRAY,GVRAY,GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,
     +                  KSCHEM,MAXEL,NTH,NPH,PH1,DPH,TH1,DTH,
     +                  ISHOT,X0,T0,T1,DTSAVE,KEVIN,KDIR,
     +                  KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,
     +                  ACCUR,H0,HMIN,LUF,NFIL,LUG,IREC0,JREC0,
     +                  NPTAB,JPTAB,NXBMAX,NYBMAX,MAXINB)

      IMPLICIT NONE

C---  Geological model:
C###  NOTE: The elastic model is REAL*4:
      INTEGER KASINO                   ! Anisotropic symmetry type
      INTEGER NX,NY,NZ                 ! Size of elastic grid model
      INTEGER NELK                     ! No of independent elastic moduli
      REAL*4  ELK4(NX,NY,NZ,NELK)      ! Density norm. moduli on a grid
      REAL*4  DXGRI4(3)                ! (x,y,z) steplength in moduli
      REAL*4  X0GRI4(3)                ! (x,y,z) coord. of ELK4(1,1,1,*)
      INTEGER NPOLX,NPOLY,NPOLZ        ! Degree of interpolating polynomial
      INTEGER NPXYZ                    ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4  CA4(NPXYZ+1,3)           ! Precomputed array for interpolation
      REAL*4  DA4(NPXYZ+1,3)           ! Precomputed array for interpolation 

C---  Kinematic and dynamic raytracing:
      INTEGER ISHOT
      INTEGER NTH,NPH,MAXEL            ! No of rays and ray elements
      INTEGER NRAYEL(NTH,NPH)          ! Number of rayelements
      INTEGER KEVIN
      INTEGER KSCHEM
      INTEGER KDIR                     ! Initial direction. (D=+1/U=-1)
      REAL*8  X0(3)                    ! Initial position  of the ray
      REAL*8  T0,T1                    ! Initial and max traveltime
      REAL*8  PH1,DPH                  ! Init. polar phase angle  (rad)
      REAL*8  TH1,DTH                  ! Init. phase angle with z (rad)
      REAL*8  TRAY (MAXEL,NTH,NPH)     ! Ray traveltime
      REAL*8  XRAY (3,MAXEL,NTH,NPH)   ! Ray positions
      REAL*8  PRAY (3,MAXEL,NTH,NPH)   ! Ray slowness
      REAL*8  VGRAY(3,MAXEL,NTH,NPH)   ! Ray group velocity
      REAL*8  ETRAY(3,MAXEL,NTH,NPH)   ! Ray deriv. of slowness
      REAL*8  GSRAY(2,MAXEL,NTH,NPH)   ! Complex geom spreading
      REAL*8  GNRAY(3,MAXEL,NTH,NPH)   ! Ray eigenvals. (no sqrt)
      REAL*8  GVRAY(3,3,MAXEL,NTH,NPH) ! Ray eigenvectors 
      REAL*8  Q1RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix Q1x (Cartesian)
      REAL*8  P1RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix P1x (Cartesian)
      REAL*8  Q2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix Q2x (Cartesian)
      REAL*8  P2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix P2x (Cartesian)

C---  Runge-Kutta control:
      REAL*8  DTSAVE                   ! Intervall for saving raypath
      REAL*8  H0,HMIN                  ! Initial and minimum steplen.
      REAL*8  ACCUR                    ! Required accuracy

C---  Ray binning:
      INTEGER MAXINB,NXBMAX,NYBMAX     ! Dimension of binning table
      INTEGER NPTAB(NXBMAX,NYBMAX)     ! Number of rays in each bin
      INTEGER JPTAB(2,MAXINB,NXBMAX*NYBMAX) ! Rays in each bins

C---  Variables for Maslov integration and FFT:
C###  NOTE: Variables for Maslov integration is REAL*4 and COMPLEX*4
      INTEGER NT,NW
      INTEGER IWLOCU,IWLOCO            ! Lo cut and lo corner freq.
      INTEGER IWHICO,IWHICU            ! Hi cut and hi corner freq.
      INTEGER MTH,MPH                  ! Number of Maslov traces
      INTEGER KMAH(MTH,MPH)            ! KMAH index array
      REAL*4  DT                       ! Sampling of sesimograms
      REAL*4  ATT                      ! Attenuation in FFT
      REAL*4  RWRK(NT,NTH)             ! Seismogram I/O work array
      REAL*4  SCL(NW)                  ! Scale factors for complex freq.
      COMPLEX WARR(NW)                 ! Complex frequency array
      COMPLEX CWRK1(NW),CWRK2(MTH,IWLOCU:IWHICU) ! FFT Work arrays
      COMPLEX CGREEN(3,3,MTH,MPH,IWLOCU:IWHICU)  ! Maslow Greeens func.

C---  Direct acces I/O:
      INTEGER IREC0,JREC0              ! Direct access I/O record counter
      INTEGER NFIL,LUF(NFIL)           ! Ray data file unit numbers
      INTEGER LUG(3,3)                 ! Greens tensor file unit numbers

C---  Local variables:
      INTEGER NSHE
      INTEGER I,J,L,M,IW               ! Loop counters
      INTEGER KMODE1                   ! Wave mode (1=qS1,2=qS2,3=qP)
      INTEGER KMODE(3)                 ! Current wave mode in KMODE(1)
      INTEGER NXBIN,NYBIN              ! Number of bin cells
      INTEGER NZERO                    ! Number of bins with zero rays
      INTEGER KINDX(MAXEL,NTH,NPH)     ! Ray flip index
      REAL*4  P0BIN(2)                 ! Origin of the bin grid
      REAL*4  DPBIN(2)                 ! Cell size in x- and y-direction

C---  Parameters from include files:
      INCLUDE '../include_files/ray_control.inc'
      INCLUDE '../include_files/io_pars.inc'
      INCLUDE '../include_files/geo_model.inc'
      INCLUDE '../include_files/math_const.inc'

      WRITE(6,*) '####### MASLOV:'
      WRITE(6,*) ' + NTH,NPH  = ',NTH,NPH
      WRITE(6,*) ' + MTH,MPH  = ',MTH,MPH
      WRITE(6,*) ' + ISHOT    = ',ISHOT
      WRITE(6,*) ' + IWLOCU   = ',IWLOCU
      WRITE(6,*) ' + IWLOCO   = ',IWLOCO
      WRITE(6,*) ' + IWHICO   = ',IWHICO
      WRITE(6,*) ' + IWHICU   = ',IWHICU
      WRITE(6,*) ' + NT,NW    = ',NT,NW
      WRITE(6,*) ' + MAXINB   = ',MAXINB
      WRITE(6,*) ' + NX,NY,NZ = ',NX,NY,NZ
      WRITE(6,*) ' + NELK     = ',NELK

C-----------------------------------------------------------------------
C   Initialize frequency domain Maslov Green's function
C-----------------------------------------------------------------------

      DO IW=IWLOCU,IWHICU
         DO M=1,MPH
            DO L=1,MTH
               DO J=1,3
                  DO I=1,3
                     CGREEN(I,J,L,M,IW) = CMPLX(0.0)
                  ENDDO
               ENDDO
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C   Complex frequency array
C-----------------------------------------------------------------------

      CALL NODEW(WARR,NW,DT,ATT)

C-----------------------------------------------------------------------
C   LOOP OVER WAVEMODES qS1, qS2, qP
C-----------------------------------------------------------------------

      DO KMODE1=3,3


C------------------------------------------------------------
C  Wave modes for a complete basis of eigenvectors of the 
C  Christoffel tensor.
C   * KMODE(1) = Current wave mode
C   * KMODE(2) = 2nd wave mode
C   * KMODE(3) = 3rd wave mode
C------------------------------------------------------------

         KMODE(1) = KMODE1
         IF     (KMODE1.EQ.K_QS1) THEN
            KMODE(2) = K_QS2
            KMODE(3) = K_QP
         ELSEIF (KMODE1.EQ.K_QS2) THEN
            KMODE(2) = K_QP
            KMODE(3) = K_QS1
         ELSEIF (KMODE1.EQ.K_QP ) THEN
            KMODE(2) = K_QS1
            KMODE(3) = K_QS2
         ENDIF

C------------------------------------------------------------
C  Standard kinetic and dynamic raytracing
C------------------------------------------------------------

         CALL RAIUNO(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,
     +               GVRAY,GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,
     +               KSCHEM,MAXEL,NTH,NPH,PH1,DPH,TH1,DTH,
     +               ISHOT,X0,T0,T1,DTSAVE,KEVIN,KMODE,KDIR,
     +               KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +               NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,
     +               ACCUR,H0,HMIN,LUF,NFIL,JREC0,KINDX)

c$$$         NSHE = 4
c$$$         CALL RAIDUE(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,
c$$$     +               GVRAY,GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,
c$$$     +               KSCHEM,MAXEL,NTH,NPH,NSHE,LUF,NFIL)


C--- DEBUGGING : RETURN WITHOUT DOING MASLOV
C*****************************************************
         RETURN
C*****************************************************





C------------------------------------------------------------
C  Interpolation to constant depth
C------------------------------------------------------------


         DO I=1,NTH
            DO J=1,NPH
               KMAH(I,J)=0
            ENDDO
         ENDDO


         CALL INTERP(KMODE,NTH,NPH,MAXEL,NRAYEL,KINDX,TRAY,XRAY,
     +               PRAY,VGRAY,GSRAY,GVRAY,Q2RAY,P2RAY,KMAH)



C------------------------------------------------------------
C  Binning in the slowness domain
C------------------------------------------------------------

         DPBIN(1) = 1.0e-5
         DPBIN(2) = 1.0e-5

         CALL BINDIM(NXBIN,NYBIN,DPBIN,P0BIN,PRAY,NTH,NPH,MAXEL)


         WRITE(6,*) ' BINNING: MAXINB = ',MAXINB
         WRITE(6,*) '          NXBIN  = ',NXBIN
         WRITE(6,*) '          NYBIN  = ',NYBIN


         CALL BINNIT(NPTAB,JPTAB,NXBIN,NYBIN,MAXINB,
     +               DPBIN,P0BIN,PRAY,NTH,NPH,MAXEL,NZERO)
         
C------------------------------------------------------------
C  Compute Maslov Greens function in the frequency domain
C------------------------------------------------------------


         CALL FREMAS(WARR,NW,CGREEN,MTH,MPH,IWLOCU,IWHICU,NRAYEL,TRAY,
     +               XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,GSRAY,Q2RAY,
     +               P2RAY,MAXEL,NTH,NPH,PH1,DPH,TH1,DTH,KMODE,
     +               P0BIN,DPBIN,NPTAB,JPTAB,NXBIN,NYBIN,MAXINB,KMAH)



      ENDDO

C------------------------------------------------------------
C  Inverse FFT from angular frequency to time 
C  Output to disk
C------------------------------------------------------------


      CALL WTSEIS(LUG,CGREEN,CWRK1,CWRK2,RWRK,SCL,NT,MTH,MPH,NW,
     +            IWLOCU,IWLOCO,IWHICO,IWHICU,ATT,IREC0)

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE MASLOV
C-----------------------------------------------------------------------




















