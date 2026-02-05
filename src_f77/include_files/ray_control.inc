C***********************************************************************
C INCLUDE FILE raycontrol.inc
C
C PURPOSE: Define parameters controlling the solution of the
C          ray tracing equations.
C          
C          
C
C PROGRAMMED : KETIL HOKSTAD DECEMBER 1998
C
C***********************************************************************

C---  Raytracing modes:
      INTEGER     K_KIN,K_DYN1,K_DYN2,K_DYN,K_GBM,K_MAS
      PARAMETER ( K_KIN  = 1 )      ! Kinetic 
      PARAMETER ( K_DYN1 = 2 )      ! Plane wave   dynamic
      PARAMETER ( K_DYN2 = 3 )      ! Point source dynamic
      PARAMETER ( K_DYN  = 4 )      ! Plane and point dynamic 
      PARAMETER ( K_GBM  = 5 )      ! Gaussian beam raytracing
      PARAMETER ( K_MAS  = 6 )      ! Maslov raytracing

C---  Wavemodes:
      INTEGER     K_QP,K_QS1,K_QS2
      PARAMETER ( K_QS1 = 1 )      ! Quasi shear #1
      PARAMETER ( K_QS2 = 2 )      ! Quasi shear #2
      PARAMETER ( K_QP  = 3 )      ! Quasi compressional 

C---  How to solve the Chrsitoffel equation?
      INTEGER     KPREC,KFAST,KBRUT
      PARAMETER ( KPREC = 1 )      ! Precomputed polariz. vectors.
      PARAMETER ( KFAST = 2 )      ! Use Cerveny equation (3.6.13)
      PARAMETER ( KBRUT = 3 )      ! Solve by Jacobi iteration

C---  Up and Down:
      INTEGER     K_UP, K_DN
      PARAMETER ( K_DN  =  1 )
      PARAMETER ( K_UP  = -1 )

C---  Point source or plane wave dynamic raytracing:
      INTEGER     KPOINT, KPLANE
      PARAMETER ( KPLANE = 1 )
      PARAMETER ( KPOINT = 2 )

C---  S-wave degeneracy:
      REAL*8      TOSH
      PARAMETER ( TOSH = 1.0d-6 )  ! Test par for S-wave degeneracy.

C---  Cartesian basis vectors (trivial)
      REAL*8     ECART(3,3)         
      DATA       ECART /  1.0d0, 0.0d0, 0.0d0,
     +                    0.0d0, 1.0d0, 0.0d0,
     +                    0.0d0, 0.0d0, 1.0d0   /

C***********************************************************************
C   END OF INCLUDE FILE raycontrol.inc
C***********************************************************************



