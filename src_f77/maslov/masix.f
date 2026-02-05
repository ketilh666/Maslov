C************************************************************************
C
C SUBROUTINE MASIX
C
C PURPOSE: Compute the 2D Maslov integral in the horizontal 
C          X-direction, I={1}
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
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY  1999
C MODIFIED           : SVERRE BRANDSBERG_DAHL JANUARY 1999
C
C************************************************************************

      SUBROUTINE MASIX(CW,CMI,TRAY,XRAY,PRAY,VGRAY,GVRAY,Q2RAY,P2RAY,
     +                 ITH,IPH,NTH,NPH,MAXEL,KMODE,DPBIN,NPTAB,JPTAB,
     +                 NXBIN,NYBIN,MAXINB,IXB1,IXB2,IYB1)

      IMPLICIT  NONE

C---  External input variables:
	
      INTEGER    IXB1,IXB2           ! First and last bin in x-dir
      INTEGER    IYB1                ! Index for the y-dir
      INTEGER    NXBIN               ! Number of x-bins
      INTEGER    NYBIN               ! =1 
      INTEGER    MAXINB              ! Max number of rays in a bin        
      INTEGER    NPTAB(NXBIN,NYBIN)  ! Number of rays in each bin
      INTEGER    JPTAB(2,MAXINB,NXBIN,NYBIN) ! Rays in each bins
      INTEGER    KMODE(3)            ! Current wavemode in KMODE(1)
      INTEGER    ITH,IPH             ! Current central ray
      INTEGER    NTH,NPH,MAXEL       ! Number of initial phase angles
      REAL*4     DPBIN(2)            ! Slowness bin size
      REAL*8     TRAY (MAXEL,NTH,NPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,NTH,NPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,NTH,NPH)   ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,NTH,NPH)   ! Ray group velocity
      REAL*8     GVRAY(3,3,MAXEL,NTH,NPH) ! Ray eigenvectors 
      REAL*8     Q2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix Q2x (Cartesian)
      REAL*8     P2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix P2x (Cartesian)
      COMPLEX    CW                  ! Complex angular frequency

C---  External output variables:
      COMPLEX    CMI(3,3)

C---  Parameters:
      INCLUDE '../include_files/math_const.inc'

C---  Internal variables:
      INTEGER    I,J,K,L,M,M1
      INTEGER    IXB,IYB,JP,NP
      REAL       TMAS,BMAS
      REAL       T1,X1,P1,DS
      REAL*8     RM(3,3),DETM
      COMPLEX    CARG,CAMP,CAIJ


C--- Taper
      INTEGER LTAP
      PARAMETER (LTAP=11)
      REAL*4  RTAP(LTAP),WGT

C---------------------------------------------
C Compute taper array
C---------------------------------------------

      DO I=1,LTAP
         RTAP(I) = 0.5*(1.0-COS(REAL(I)*PI/REAL(LTAP)))
      ENDDO

C-----------------------------------------------------------------------
C  Compute the Maslov integral for the current frequency
C   * Loop over output locations L,M
C-----------------------------------------------------------------------

      DO J=1,3
         DO I=1,3
            CMI(I,J) = CMPLX(0.0)
         ENDDO
      ENDDO

      K     = MAXEL
      M1    = KMODE(1)
      IYB   = IYB1  ! Only a line integral, hence fixed y

c$$$      WRITE(6,*) 'MASIX: IYB,IXB1,IXB2 = ',IYB,IXB1,IXB2

C---  Loop over horizontal slowness bins:
      DO IXB=IXB1,IXB2

         IF (IXB.LE.LTAP) THEN
            WGT = RTAP(IXB)
         ELSEIF(IXB2-IXB+1.LT.LTAP) THEN
            WGT = RTAP(IXB2-IXB+1)
         ELSE
            WGT = 1.0
         ENDIF


C---     Slowness surface element for current bin:
         NP = MAX(1,NPTAB(IXB,IYB))
         DS = DPBIN(1)*DPBIN(2)/REAL(NP)

C---     Loop over rays in current slowness bin:
         DO JP=1,NPTAB(IXB,IYB)
               
C---        Get indices from slowness bin table:
            L = JPTAB(1,JP,IXB,IYB)
            M = JPTAB(2,JP,IXB,IYB)

C---        Maslov Phase:
            T1 = REAL(TRAY(K,L,M))
            X1 = REAL(XRAY(1,K,ITH,IPH)-XRAY(1,K,L,M)) 
            P1 = REAL(PRAY(1,K,L,M))
            TMAS = T1 + P1*X1
            CARG = CI*(CW*CMPLX(TMAS) + 0.5*2*PI*(CW/ABS(CW)))

C---        Maslov amplitude:
            DO I=1,3
               RM(I,1) = P2RAY(I,1,K,L,M)
               RM(I,2) = Q2RAY(I,2,K,L,M)
               RM(I,3) = VGRAY(I,  K,L,M)
            ENDDO
            DETM = RM(1,1)*(RM(2,2)*RM(3,3)-RM(3,2)*RM(2,3)) -
     +           RM(1,2)*(RM(2,1)*RM(3,3)-RM(3,1)*RM(2,3)) +
     +           RM(1,3)*(RM(2,1)*RM(3,2)-RM(3,1)*RM(2,2)) 
            BMAS = REAL(1000/SQRT(ABS(DETM)))
C            BMAS = 1.0/REAL(TRAY(K,L,M))

C            WRITE(6,*)' MASIX: AMPLITUDE XXXX = ' , BMAS
            
C---        Scalar integrand:
            CAMP = WGT*BMAS*CEXP(CARG)

C---        Loop over tensor indices:
            DO J=1,3
               DO I=1,3
                  CAIJ = CAMP*
     +                 REAL(GVRAY(I,M1,K,L,M)*GVRAY(I,M1,1,L,M))
                  CMI(I,J) = CMI(I,J) + CAIJ*DS
               ENDDO
            ENDDO

         ENDDO
         
      ENDDO

C---  Scaling of Green's function, eqn.(25) in ref.2
      DO J=1,3
         DO I=1,3
            CMI(I,J) = CSQRT(0.5*CI*CW/PI)*CMI(I,J)
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE MASI2  
C-----------------------------------------------------------------------












