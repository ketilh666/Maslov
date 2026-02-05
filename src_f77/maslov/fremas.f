C************************************************************************
C
C SUBROUTINE FREMAS
C
C PURPOSE: Compute the 3D Maslov Green's funtion in the
C          angular frequancy domain.
C          This routine is designed for paralell execution
C          on shared memory computers.
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
C SUBROUTINES CALLED : MASINT
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD FEBRUARY 1999
C
C************************************************************************

      SUBROUTINE FREMAS(WARR,NW,CGREEN,MTH,MPH,IWLO,IWHI,NRAYEL,TRAY,
     +                  XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,GSRAY,Q2RAY,
     +                  P2RAY,MAXEL,NTH,NPH,PH1,DPH,TH1,DTH,KMODE,
     +                  P0BIN,DPBIN,NPTAB,JPTAB,NXBIN,NYBIN,MAXINB,KMAH)

      IMPLICIT  NONE

C---  External input variables:
      INTEGER    NXBIN,NYBIN         ! Number of bin cells
      INTEGER    MAXINB              ! Max number of rays in a bin        
      INTEGER    NPTAB(NXBIN,NYBIN)  ! Number of rays in each bin
      INTEGER    JPTAB(2,MAXINB,NXBIN,NYBIN) ! Rays in each bins
      INTEGER    KMODE(3)            ! Current wave mode in KMODE(1)
      INTEGER    NTH,NPH             ! No of rays traced
      INTEGER    MTH,MPH             ! Number Maslov traces to compute
      INTEGER    MAXEL               ! Max no of rayelements
      REAL*4     P0BIN(2),DPBIN(2)   ! Slowness origin and bin size
      INTEGER    NRAYEL(NTH,NPH)          ! Number of rayelements
      INTEGER    KMAH(MTH,MPH)             ! KMAH index array
      REAL*8     TRAY (MAXEL,NTH,NPH)      ! Ray traveltime at depth Z
      REAL*8     XRAY (3,MAXEL,NTH,NPH)    ! Ray positions
      REAL*8     PRAY (3,MAXEL,NTH,NPH)    ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,NTH,NPH)    ! Ray group velocity
      REAL*8     ETRAY(3,MAXEL,NTH,NPH)    ! Ray deriv. of slowness
      REAL*8     GNRAY(3,MAXEL,NTH,NPH)    ! Ray eigenvals. (no sqrt)
      REAL*8     GVRAY(3,3,MAXEL,NTH,NPH)  ! Ray eigenvectors 
      REAL*8     GSRAY(2,MAXEL,NTH,NPH)   ! Complex geom spreading
      REAL*8     Q2RAY(3,2,MAXEL,NTH,NPH)  ! 3x2 matrix Q2x (Cartesian)
      REAL*8     P2RAY(3,2,MAXEL,NTH,NPH)  ! 3x2 matrix P2x (Cartesian)
      REAL*8     PH1,DPH             ! Polar phase angle       (Radians)
      REAL*8     TH1,DTH             ! Phase angle with z-axis (Radians)
      INTEGER    NW,IWLO,IWHI
      COMPLEX    WARR(NW)            ! Complex angular frequency array

C---  External output variables:
      COMPLEX    CGREEN(3,3,MTH,MPH,IWLO:IWHI) 

C---  Parameters:
      INCLUDE   '../include_files/math_const.inc'
      INCLUDE   '../include_files/maslovpar.inc'

C---  Internal variables:
      INTEGER    IW

C-----------------------------------------------------------------------
C  LOOP OVER COMPLEX ANGUALAR FREQUANCIES IWLO:IWHI
C  This subroutine is designed for paralell execution on
C  shared memory computers.
C-----------------------------------------------------------------------




C$    DOACROSS LOCAL(IW)
      DO IW = IWLO,IWHI

C         WRITE(6,*) 'IW,DPBIN = ',IW,DPBIN(1),DPBIN(2)

         CALL MASINT(WARR(IW),CGREEN(1,1,1,1,IW),MTH,MPH,NRAYEL,TRAY,
     +               XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,GSRAY,Q2RAY,
     +               P2RAY,MAXEL,NTH,NPH,PH1,DPH,TH1,DTH,KMODE,
     +               P0BIN,DPBIN,NPTAB,JPTAB,NXBIN,NYBIN,MAXINB,KMAH)
      ENDDO


C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE FREMAS  
C-----------------------------------------------------------------------

