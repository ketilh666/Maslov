C************************************************************************
C
C SUBROUTINE MASDET
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
C PROGRAMMED         : Sverre Brandsberg-Dahl JANUARY 1999
C
C************************************************************************

      SUBROUTINE MASDET(NRAYEL,VGRAY,ETRAY,Q2RAY,P2RAY,MAXEL,
     +                  MTH,MPH,L,M,KFLP)

      IMPLICIT NONE

C---  External input variables::
      INTEGER  MAXEL                     ! Maximum number of ray elements
      INTEGER  MTH,MPH                   ! Number Maslov traces to compute
      INTEGER  L,M                       ! Index for current ray element
      INTEGER  NRAYEL(MTH,MPH)           ! Number of rayelements
      REAL*8   ETRAY(3,MAXEL,MTH,MPH)    ! Ray deriv. of slowness
      REAL*8   Q2RAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix Q2x (Cartesian)
      REAL*8   P2RAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix P2x (Cartesian)
      REAL*8   VGRAY(3,MAXEL,MTH,MPH)    ! Ray group velocity
    
C---  External output variables:
      INTEGER KFLIP              ! tot number of flips performed

C---  Internal variables:
      INTEGER  I,K               ! loop counter
      INTEGER  KFLP              ! ray-segment flip index
      REAL*8   WRKD(4),SA,SB,SC  ! work variables
      REAL*8   DETMAX            ! work variable
      REAL*8   DETH              ! work variable
      REAL*8   EPS

      PARAMETER (EPS=0.00001)


C---  Resettign the ray flip counter
      KFLIP = 0

C------------------------------------------------------------------------
C     Loop over ray segments and find the total flip index for the ray
C------------------------------------------------------------------------

c$$$      DO K=1,NRAYEL(L,M)
      DO K=MAXEL,MAXEL


C---     Resetting the ray-segment flip counter
         KFLP = 0

C------------------------------------------------------------------------
C        Compute the determinant from VGRAY and two columns 
C        permutated from Q2, P2
C------------------------------------------------------------------------


C---     Q2(.,1) and Q2(.,2) :
         SA = Q2RAY(2,2,K,L,M)*Q2RAY(3,1,K,L,M) -  
     +        Q2RAY(2,1,K,L,M)*Q2RAY(3,2,K,L,M)

         SB = Q2RAY(3,2,K,L,M)*Q2RAY(1,1,K,L,M) -  
     +        Q2RAY(3,1,K,L,M)*Q2RAY(1,2,K,L,M)
         
         SC = Q2RAY(1,2,K,L,M)*Q2RAY(2,1,K,L,M) -  
     +        Q2RAY(1,1,K,L,M)*Q2RAY(2,2,K,L,M)

         WRKD(1) = -VGRAY(1,K,L,M)*SA
     +             +VGRAY(2,K,L,M)*SB
     +             -VGRAY(3,K,L,M)*SC

C---        Compute the scaling factor h, eqn(30) in ref.1
         DETH = ABS((VGRAY(1,K,L,M)*VGRAY(2,K,L,M))/
     +              ETRAY(1,K,L,M)*ETRAY(2,K,L,M))
         WRKD(1) = WRKD(1)*DETH


C---     Test for the different determinants and pick the largest
         IF (WRKD(I).LT.EPS.AND.ETRAY(1,K,L,M).GT.0.0) THEN 

C---        P2(.,1) and Q2(.,2) :
            SA = Q2RAY(2,2,K,L,M)*P2RAY(3,1,K,L,M) -  
     +                 P2RAY(2,1,K,L,M)*Q2RAY(3,2,K,L,M)

            SB = Q2RAY(3,2,K,L,M)*P2RAY(1,1,K,L,M) -  
     +                 P2RAY(3,1,K,L,M)*Q2RAY(1,2,K,L,M)

            SC = Q2RAY(1,2,K,L,M)*P2RAY(2,1,K,L,M) -  
     +                 P2RAY(1,1,K,L,M)*Q2RAY(2,2,K,L,M)

            WRKD(2) = -VGRAY(1,K,L,M)*SA
     +                +VGRAY(2,K,L,M)*SB
     +                -VGRAY(3,K,L,M)*SC

C---        Compute the scaling factor h, eqn(30) in ref.1
            DETH = ABS(VGRAY(1,K,L,M)/ETRAY(1,K,L,M))
            WRKD(2) = WRKD(2)*DETH



C---        Q2(.,1) and P2(.,2) :
            SA = P2RAY(2,2,K,L,M)*Q2RAY(3,1,K,L,M) -  
     +                 Q2RAY(2,1,K,L,M)*P2RAY(3,2,K,L,M)
            
            SB = P2RAY(3,2,K,L,M)*Q2RAY(1,1,K,L,M) -  
     +                 Q2RAY(3,1,K,L,M)*P2RAY(1,2,K,L,M)
            
            SC = P2RAY(1,2,K,L,M)*Q2RAY(2,1,K,L,M) -  
     +                 Q2RAY(1,1,K,L,M)*P2RAY(2,2,K,L,M)
            
            WRKD(3) = -VGRAY(1,K,L,M)*SA
     +                +VGRAY(2,K,L,M)*SB
     +                -VGRAY(3,K,L,M)*SC

C---        Compute the scaling factor h, eqn(30) in ref.1
            DETH = ABS(VGRAY(2,K,L,M)/ETRAY(2,K,L,M))
            WRKD(3) = WRKD(3)*DETH
            
            

C---        P2(.,1) and P2(.,2) :
            SA = P2RAY(2,2,K,L,M)*P2RAY(3,1,K,L,M) -  
     +                 P2RAY(2,1,K,L,M)*P2RAY(3,2,K,L,M)

            SB = P2RAY(3,2,K,L,M)*P2RAY(1,1,K,L,M) -  
     +                 P2RAY(3,1,K,L,M)*P2RAY(1,2,K,L,M)
            
            SC = P2RAY(1,2,K,L,M)*P2RAY(2,1,K,L,M) -  
     +                 P2RAY(1,1,K,L,M)*P2RAY(2,2,K,L,M)


C---        Compute the scaling factor h, eqn(30) in ref.1
            DETH = ABS(VGRAY(2,K,L,M)*ETRAY(2,K,L,M))
            WRKD(4) = -VGRAY(1,K,L,M)*SA
     +                +VGRAY(2,K,L,M)*SB
     +                -VGRAY(3,K,L,M)*SC

C---------------------------------------------------------------------
C        Find the larges determinant and the phase flip index.
C        We have the following definition for the index KFLP
C        KFLP = 0  =>  KFLP_0    Regular GRA 
C        KFLP = 1  =>  KFLP_X    Maslov in the X-direction
C        KFLP = 2  =>  KFLP_Y    Maslov in the Y-direction
C        KFLP = 3  =>  KFLP_XY   Maslov in the XY-plane
C---------------------------------------------------------------------

            DETMAX = ABS(WRKD(1))
            KFLP = 0
            DO I=2,4
               IF (ABS(WRKD(I)).GT.DETMAX) THEN
                  DETMAX = ABS(WRKD(I))
                  KFLP = I-1
               ENDIF
            ENDDO

            KFLIP = KFLIP + KFLP
         ELSE
            DETMAX = ABS(WRKD(1))
            KFLIP = 0
         ENDIF


      ENDDO

      WRITE(6,*) 'MASDET: ',KFLIP,(1.0/SQRT(ABS(WRKD(K))),K=1,3)

C---  Test to make KFLIP modulo 3

      RETURN
      END
