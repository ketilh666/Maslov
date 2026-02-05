C************************************************************************
C
C SUBROUTINE GRAGF
C
C PURPOSE: Compute the GRA Green's function in the frequency domain.
C          This is the limiting case of the Maslov Gree's function when
C          the Legendre transformed set is empty.
C
C REFERENCES: 
C       1. Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures, 
C          chapters 2.2 and 3.6. Lecture notes, 
C          University of Trondheim, 1995.
C       2. DeHoop and Brandsberg-Dahl, 1999: Maslov asymptotic
C          extension of Generalized Radon Transform in anisotropic
C          elastic media: a Least-Squares approach.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD FEBRUARY 1999
C
C************************************************************************

      SUBROUTINE GRAGF(CW,CGRA,TRAY,XRAY,PRAY,VGRAY,GVRAY,GSRAY,
     +                 Q2RAY,P2RAY,ITH,IPH,NTH,NPH,MAXEL,KMODE)

      IMPLICIT  NONE

C---  External input variables:
      INTEGER    KMODE(3)            ! Current wavemode in KMODE(1)
      INTEGER    ITH,IPH             ! Current central ray
      INTEGER    NTH,NPH,MAXEL       ! Number of initial phase angles
      REAL*8     TRAY (MAXEL,NTH,NPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,NTH,NPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,NTH,NPH)   ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,NTH,NPH)   ! Ray group velocity
      REAL*8     GVRAY(3,3,MAXEL,NTH,NPH) ! Ray eigenvectors 
      REAL*8     GSRAY(2,MAXEL,NTH,NPH)   ! Geometrical spreading
      REAL*8     Q2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix Q2x (Cartesian)
      REAL*8     P2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix P2x (Cartesian)
      COMPLEX    CW                  ! Complex angular frequency

C---  External output variables:
      COMPLEX    CGRA(3,3)           ! GRA Green's function 

C---  Parameters:
      INCLUDE '../include_files/math_const.inc'

C---  Internal variables:
      INTEGER    I,J,K,L,M,M1
      REAL       TGRA,BGRA
      REAL       RM(3,3),DETM
      COMPLEX    CARG,CAMP

C-----------------------------------------------------------------------
C  Compute the GRA GReen's function in the frequency domain
C-----------------------------------------------------------------------

      K     = MAXEL
      M1    = KMODE(1)

      L     = ITH
      M     = IPH

C---  Phase:
      TGRA = REAL(TRAY(K,ITH,IPH))
      CARG = CI*CW*CMPLX(TGRA)
               
C---  Amplitude Det Q2:
      DO I=1,3
         RM(I,1) = REAL(Q2RAY(I,1,K,L,M))
         RM(I,2) = REAL(Q2RAY(I,2,K,L,M))
         RM(I,3) = REAL(VGRAY(I,  K,L,M))
      ENDDO
      DETM = RM(1,1)*(RM(2,2)*RM(3,3)-RM(3,2)*RM(2,3)) -
     +       RM(1,2)*(RM(2,1)*RM(3,3)-RM(3,1)*RM(2,3)) +
     +       RM(1,3)*(RM(2,1)*RM(3,2)-RM(3,1)*RM(2,2)) 
      BGRA = 5.0e5/SQRT(ABS(DETM))
C      BGRA = 1.0


C      WRITE(6,*)' MASIX: AMPLITUDE GRA = ' , BGRA

C---  Scalar integrand:
      CAMP = BGRA*CEXP(CARG)

C---  Loop over tensor indices:
      DO J=1,3
         DO I=1,3
            CGRA(I,J)  = CAMP*
     +                   REAL(GVRAY(I,M1,K,L,M)*GVRAY(I,M1,1,L,M))
         ENDDO
      ENDDO


C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE GRAGF  
C-----------------------------------------------------------------------




