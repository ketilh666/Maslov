C************************************************************************
C
C SUBROUTINE MASDIREC
C
C PURPOSE: Compute the determinant of matrix M (eqn.(56) in Ref.2)
C          for all possible realizations of the set I and then select 
C          largest one.
C          The calculation is performed using the dynamic raytracing 
C          quantities Q2 qnd P2 (see Ref.1)
C          
C
C REFERENCES: 
C       1. Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures, 
C          chapters 4. Lecture notes, University of Trondheim, 
C          1995.
C
C       2. de Hoop, M. and Brandsberg-Dahl, S., 1999: Maslov....
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : Sverre Brandsberg-Dahl JUNE 1999
C
C************************************************************************

      SUBROUTINE MASDIREC(NRAYEL,VGRAY,ETRAY,Q2RAY,P2RAY,MAXEL,
     +                  MTH,MPH,L,M,KMAH,KFLIP)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  MAXEL                     ! Maximum number of ray elements
      INTEGER  MTH,MPH                   ! Number Maslov traces to compute
      INTEGER  L,M                       ! Index for current ray element
      INTEGER  NRAYEL(MTH,MPH)           ! Number of rayelements
      INTEGER  KMAH(MTH,MPH)             ! KMAH index array
      REAL*8   ETRAY(3,MAXEL,MTH,MPH)    ! Ray deriv. of slowness
      REAL*8   Q2RAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix Q2x (Cartesian)
      REAL*8   P2RAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix P2x (Cartesian)
      REAL*8   VGRAY(3,MAXEL,MTH,MPH)    ! Ray group velocity

C---  External output variables:
      INTEGER  KFLIP

C---  Internal variables:
      INTEGER  K
      REAL*8   WRKD(2),SA,SB,SC  ! work variables
      REAL*8   DETH              ! work variable

C---  Use the interpolated values stored in the last element
      K = MAXEL

C---  Resetting the ray flip direction
      KFLIP = 1


C------------------------------------------------------------------------
C        Compute the determinant from VGRAY and two columns 
C        permutated from Q2, P2
C------------------------------------------------------------------------


C---  P2(.,1) and Q2(.,2) :
      SA = Q2RAY(2,2,K,L,M)*P2RAY(3,1,K,L,M) -  
     +           P2RAY(2,1,K,L,M)*Q2RAY(3,2,K,L,M)

      SB = Q2RAY(3,2,K,L,M)*P2RAY(1,1,K,L,M) -  
     +           P2RAY(3,1,K,L,M)*Q2RAY(1,2,K,L,M)

      SC = Q2RAY(1,2,K,L,M)*P2RAY(2,1,K,L,M) -  
     +           P2RAY(1,1,K,L,M)*Q2RAY(2,2,K,L,M)

      WRKD(1) = -VGRAY(1,K,L,M)*SA
     +          +VGRAY(2,K,L,M)*SB
     +          -VGRAY(3,K,L,M)*SC


C---  Compute the scaling factor h, eqn(30) in ref.1
C      DETH = ABS( VGRAY(1,K,L,M) / ETRAY(1,K,L,M) )
      WRKD(1) = ABS( WRKD(1) ) ! *DETH



C---  Q2(.,1) and P2(.,2) :
      SA = P2RAY(2,2,K,L,M)*Q2RAY(3,1,K,L,M) -  
     +           Q2RAY(2,1,K,L,M)*P2RAY(3,2,K,L,M)
            
      SB = P2RAY(3,2,K,L,M)*Q2RAY(1,1,K,L,M) -  
     +           Q2RAY(3,1,K,L,M)*P2RAY(1,2,K,L,M)
            
      SC = P2RAY(1,2,K,L,M)*Q2RAY(2,1,K,L,M) -  
     +           Q2RAY(1,1,K,L,M)*P2RAY(2,2,K,L,M)
            
      WRKD(2) = -VGRAY(1,K,L,M)*SA
     +          +VGRAY(2,K,L,M)*SB
     +          -VGRAY(3,K,L,M)*SC

C---  Compute the scaling factor h, eqn(30) in ref.1
C      DETH = ABS( VGRAY(2,K,L,M) / ETRAY(2,K,L,M) )
      WRKD(2) = ABS( WRKD(2) ) ! *DETH


C---------------------------------------------------------------------
C     Find the larges determinant and the phase flip index.
C     We have the following definition for the index KFLIP
C     KFLIP = 1  =>  KFLIP_X    Maslov in the X-direction
C     KFLIP = 2  =>  KFLIP_Y    Maslov in the Y-direction
C---------------------------------------------------------------------

      IF (WRKD(1).GT.WRKD(2)) THEN
         KFLIP = 1
      ELSE
         KFLIP = 2
      ENDIF

C      WRITE(6,*) ' MASDIREC: KFLIP = ',KFLIP

      RETURN
      END
