C************************************************************************
C
C SUBROUTINE RC_PAR
C
C PURPOSE: Return parameters in the include file ray_control.inc
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD OCTOBER 1999
C
C************************************************************************

      SUBROUTINE RC_PAR(L_KIN,L_DYN1,L_DYN2,L_DYN,L_QP,L_QS1,L_QS2,
     +                  LPREC,LFAST,LBRUT,L_UP,L_DN,LPOINT,LPLANE,
     +                  UOSH,FCART)

      IMPLICIT NONE

C---  External output variables:
      INTEGER  L_KIN,L_DYN1,L_DYN2,L_DYN
      INTEGER  L_QP,L_QS1,L_QS2
      INTEGER  LPREC,LFAST,LBRUT
      INTEGER  L_UP,L_DN
      INTEGER  LPOINT,LPLANE
      REAL*8   UOSH
      REAL*8   FCART(3,3)         

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'

C---  Internal variables:
      INTEGER  I,J

C-----------------------------------------------------------------------
C     Parameters in the include file ray_control.inc
C-----------------------------------------------------------------------

C---  Raytracing modes:
      L_KIN  = K_KIN      ! Kinetic
      L_DYN1 = K_DYN1     ! Plane wave   dynamic raytracing
      L_DYN2 = K_DYN2     ! Point source dynamic raytracing
      L_DYN  = K_DYN      ! Plane and point dynamic raytracing

C---  Wavemodes:
      L_QP   = K_QP       ! Quasi shear #1
      L_QS1  = K_QS1      ! Quasi shear #2
      L_QS2  = K_QS2      ! Quasi compressional
      
C---  How to solve the Chrsitoffel equation?
      LPREC  = KPREC      ! Precomputed polariz. vectors.
      LFAST  = KFAST      ! Use Cerveny equation (3.6.13)
      LBRUT  = KBRUT      ! Solve by Jacobi iteration
      
C---  Up and Down:
      L_UP   = K_UP
      L_DN   = K_DN
      
C---  Point source or plane wave dynamic raytracing:
      LPOINT = KPOINT
      LPLANE = KPLANE
      
C---  S-wave degeneracy:
      UOSH   = TOSH
      
C---  Cartesian basis vectors (trivial)
      DO J=1,3
         DO I=1,3
            FCART(I,J) = ECART(I,J)         
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE RC_PAR
C-----------------------------------------------------------------------


