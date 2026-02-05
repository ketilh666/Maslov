C************************************************************************
C
C SUBROUTINE MASINT
C
C PURPOSE: Compute the 3D Maslov integral. Depending on the value
C          of the optimal amplitude determinant (det M) the subroutine
C          compute the Maslov Green's funtion in the freuqncy
C          domain by performing a Legendre transform of 2,1 or 0
C          cartesian coordinates. The 0-case is equivalent to
C          the standradr GRA Grenn's function.
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
C       3. Numerical Receipes in Fortran, chapters 4.5 and 4.6
C
C SUBROUTINES CALLED : MASI2 MASIX MASIY GRAGF MASDIREC
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD FEBRUARY 1999
C MODIFIED           : SVERRE BRANDSBERG_DAHL FEBRUARY 1999   
C
C************************************************************************

      SUBROUTINE MASINT(CW,CGREEN,MTH,MPH,NRAYEL,TRAY,XRAY,PRAY,
     +                  VGRAY,ETRAY,GNRAY,GVRAY,GSRAY,Q2RAY,P2RAY,
     +                  MAXEL,NTH,NPH,PH1,DPH,TH1,DTH,KMODE,
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
      REAL*8     TRAY (MAXEL,NTH,NPH)      ! Ray traveltime at depth Z
      INTEGER    NRAYEL(NTH,NPH)           ! Number of rayelements
      INTEGER    KMAH(MTH,MPH)             ! KMAH index array
      REAL*8     XRAY (3,MAXEL,NTH,NPH)    ! Ray positions
      REAL*8     PRAY (3,MAXEL,NTH,NPH)    ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,NTH,NPH)    ! Ray group velocity
      REAL*8     ETRAY(3,MAXEL,NTH,NPH)    ! Ray deriv. of slowness
      REAL*8     GNRAY(3,MAXEL,NTH,NPH)    ! Ray eigenvals. (no sqrt)
      REAL*8     GVRAY(3,3,MAXEL,NTH,NPH)  ! Ray eigenvectors 
      REAL*8     GSRAY(2,MAXEL,NTH,NPH)    ! Complex geom spreading
      REAL*8     Q2RAY(3,2,MAXEL,NTH,NPH)  ! 3x2 matrix Q2x (Cartesian)
      REAL*8     P2RAY(3,2,MAXEL,NTH,NPH)  ! 3x2 matrix P2x (Cartesian)
      REAL*8     PH1,DPH             ! Polar phase angle       (Radians)
      REAL*8     TH1,DTH             ! Phase angle with z-axis (Radians)
      COMPLEX    CW                  ! Current complex angular frequency

C---  External output variables:
      COMPLEX    CGREEN(3,3,MTH,MPH) 

C---  Parameters:
      INCLUDE   '../include_files/math_const.inc'
      INCLUDE   '../include_files/maslovpar.inc'

C---  Internal variables:
      INTEGER    IPH,ITH,I,J,K,L,M
      INTEGER    KFLIP
      INTEGER    IXB1,IXB2,IYB1,IYB2,IXBC,IYBC
      COMPLEX    CMI(3,3)

      INTEGER    ITEST
      DATA       ITEST/1/
      SAVE       ITEST

C-----------------------------------------------------------------------
C  Compute the Maslov integral for the current frequency
C   * Loop over output locations L,M
C-----------------------------------------------------------------------

      K = MAXEL
      KFLIP = 0

      DO IPH=1,MPH
         DO ITH=1,MTH 


C---------------------------------------------------------------------
C           CALL SOMETHING TO GET THE MASLOV FLIP INDEX:
C---------------------------------------------------------------------

            IF ((KMAH(ITH,IPH).EQ.1).OR.(KMAH(ITH,IPH).EQ.2)) THEN
               CALL MASDIREC(NRAYEL,VGRAY,ETRAY,Q2RAY,P2RAY,
     +                       MAXEL,MTH,MPH,ITH,IPH,KMAH,KFLIP)

            ELSE IF (KMAH(ITH,IPH).EQ.3) THEN
               KFLIP = 3
            ELSE
               KFLIP = 0
            ENDIF


C--- Debugging: To make things GRA set KFLIP=0
C            KFLIP = 0
C            WRITE(6,*)' MASINT: KFLIP = ',KFLIP


C---------------------------------------------------------------------
C
C        We have the following definition for the index KFLIP
C        KFLIP = 0  =>  KFLP_0    Regular GRA 
C        KFLIP = 1  =>  KFLP_X    Maslov in the X-direction
C        KFLIP = 2  =>  KFLP_Y    Maslov in the Y-direction
C        KFLIP = 3  =>  KFLP_XY   Maslov in the XY-plane
C
C---------------------------------------------------------------------

            IF  (KFLIP .EQ. 3) THEN
C---           Flip x- and y-components:
               IXB1 = 1
               IXB2 = NXBIN
               IYB1 = 1
               IYB2 = NYBIN
               CALL MASI2(CW,CMI,TRAY,XRAY,PRAY,
     +                    VGRAY,GVRAY,Q2RAY,P2RAY,ITH,IPH,
     +                    MTH,MPH,MAXEL,KMODE,DPBIN,NPTAB,JPTAB,
     +                    NXBIN,NYBIN,MAXINB,IXB1,IXB2,IYB1,IYB2)

            ELSE IF (KFLIP .EQ. 1) THEN
C---           Flip x-component:
               IXBC = 1 + NINT((PRAY(1,K,ITH,IPH)-P0BIN(1))/DPBIN(1))
               IYBC = 1 + NINT((PRAY(2,K,ITH,IPH)-P0BIN(2))/DPBIN(2))
               IXB1 = MAX(1,IXBC-NXBIN/4)
               IXB2 = MIN(NXBIN,IXBC+NXBIN/4)
               CALL MASIX(CW,CMI,TRAY,XRAY,PRAY,VGRAY,GVRAY,
     +                    Q2RAY,P2RAY,ITH,IPH,NTH,NPH,MAXEL,
     +                    KMODE,DPBIN,NPTAB,JPTAB,NXBIN,NYBIN,
     +                    MAXINB,IXB1,IXB2,IYBC)

            ELSE IF (KFLIP .EQ. 2) THEN
C---           Flip y-component:
               IXBC = 1 + NINT((PRAY(1,K,ITH,IPH)-P0BIN(1))/DPBIN(1))
               IYB1 = 1
               IYB2 = NYBIN
               CALL MASIY(CW,CMI,TRAY,XRAY,PRAY,VGRAY,GVRAY,
     +                    Q2RAY,P2RAY,ITH,IPH,NTH,NPH,MAXEL,
     +                    KMODE,DPBIN,NPTAB,JPTAB,NXBIN,NYBIN,
     +                    MAXINB,IYB1,IYB2,IXBC)

            ELSE
C---           GRA Green's function: 
               CALL GRAGF(CW,CMI,TRAY,XRAY,PRAY,
     +                    VGRAY,GVRAY,GSRAY,Q2RAY,P2RAY,
     +                    ITH,IPH,NTH,NPH,MAXEL,KMODE)
            ENDIF

C---        Add current mode to frequency domain seismogram:
            DO J=1,3
               DO I=1,3
                  CGREEN(I,J,ITH,IPH) = CGREEN(I,J,ITH,IPH) + CMI(I,J)
c$$$                  CGREEN(I,J,ITH,IPH) = CMI(I,J)
               ENDDO
            ENDDO

         ENDDO
      ENDDO

      ITEST = 2

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE MASINT  
C-----------------------------------------------------------------------

