C************************************************************************
C
C SUBROUTINE GAUSS2
C
C PURPOSE: Return CIJ for a test model with gaussian dependence
C          on (x,y,z)
C          
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 19918
C
C************************************************************************

      SUBROUTINE GAUSS2(CIJ,DCIJ,DDCIJ,X,NDERIV) 

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NDERIV             ! Highest order of deriv. (0/1/2)
      REAL*8     X(3)               ! Position to get AA and DADI

C---  External output variables:
      REAL*8     CIJ  (6,6    )     ! Voigt matrix
      REAL*8     DCIJ (6,6,3  )     ! 1st derivatives of Voigt matrix
      REAL*8     DDCIJ(6,6,3,3)     ! 2nd derivatives of Voigt matrix

C---  Parameters:
      REAL*8      C1,S1,XC
      REAL*8      RHO,VP0,VS0,EPS,DEL,GAM

C***  Gauss bell:
C      PARAMETER ( XC  =  300.00 ) ! original
C      PARAMETER ( XC  =  800.00 ) ! adi gauss_maslov
      PARAMETER ( XC  =  500.00 ) ! f90 debugging
      PARAMETER ( S1  =   50.00 )
      PARAMETER ( C1  =   -0.6  )  ! Gaussian focusing lens  
c$$$      PARAMETER ( C1  =    0.0  )  ! Homogeneous model

C***  Thomsen:
      PARAMETER ( RHO =    1.00 )
      PARAMETER ( VP0 = 1200.00 )
      PARAMETER ( VS0 =  600.00 )
      PARAMETER ( EPS =    0.20 )
      PARAMETER ( DEL =    0.10 )
      PARAMETER ( GAM =    0.05 )

C--   Internal variables:
      INTEGER    I,J,K,L,N
      REAL*8     GX(0:2),GY(0:2),GZ(0:2)
      REAL*8     FF,FI(3),FIJ(3,3)
      REAL*8     X0(3)
      REAL*8     RA,RC,RF,RL,RN,TMP
      REAL*8     CIJ0(6,6)
      REAL*8     SX,SY,SZ

C-----------------------------------------------------------------------
C  Compute Voigt matrix in background medium
C-----------------------------------------------------------------------

      DO J=1,6
         DO I=1,6
            CIJ0(I,J) = 0.0
         ENDDO
      ENDDO

      TMP =  1.0-(VS0/VP0)**2                           
      RA  = (1.0+2.0*EPS)*VP0**2                        
      RC  =  VP0**2                                     
      RF  =  VP0**2*SQRT(TMP*2.0*DEL + TMP*TMP) -VS0**2 
      RL  =  VS0**2                                     
      RN  = (1.0+2.0*GAM)*VS0**2                        

C---  Diagonal elements:
      CIJ0(1,1) = RA 
      CIJ0(2,2) = RA 
      CIJ0(3,3) = RC 
      CIJ0(4,4) = RL 
      CIJ0(5,5) = RL 
      CIJ0(6,6) = RN 

C---  Off diagonal elements:
      CIJ0(2,1) = RA-2*RN 
      CIJ0(1,2) = RA-2*RN 
      CIJ0(3,1) = RF 
      CIJ0(1,3) = RF 
      CIJ0(3,2) = RF 
      CIJ0(2,3) = RF 

C-----------------------------------------------------------------------
C  Compute 2nd degree Gaussian and derivatives w.r.t (x,y,z)
C-----------------------------------------------------------------------

c$$$      X0(1) = XC     ! original
c$$$      X0(2) = XC     ! original
c$$$      X0(1) = 0.0    ! adi gauss_maslov
c$$$      X0(2) = 0.0    ! adi gauss_maslov
      X0(1) = 2.0*XC ! f90 debugging
      X0(2) = 2.0*XC ! f90 debugging
      X0(3) = XC

      SX = 1.0d1*S1
      SY = 1.0d1*S1
      SZ = 1.0d1*S1

      N = 2
      CALL G1D(GX,N,X(1),X0(1),SX)
      CALL G1D(GY,N,X(2),X0(2),SY)
      CALL G1D(GZ,N,X(3),X0(3),SZ)

c$$$      WRITE(6,*) 'X0,X,GX = ',X0(1),X(1),GX(0),GX(1),GX(2)
c$$$      WRITE(6,*) 'Y0,Y,GY = ',X0(2),X(2),GY(0),GY(1),GY(2)
c$$$      WRITE(6,*) 'Z0,Z,GZ = ',X0(3),X(3),GZ(0),GZ(1),GZ(2)

      FF       = 1.0 + C1*GX(0)*GY(0)*GZ(0)
      FI(1)    =       C1*GX(1)*GY(0)*GZ(0)
      FI(2)    =       C1*GX(0)*GY(1)*GZ(0)
      FI(3)    =       C1*GX(0)*GY(0)*GZ(1)
      FIJ(1,1) =       C1*GX(2)*GY(0)*GZ(0)
      FIJ(2,2) =       C1*GX(0)*GY(2)*GZ(0)
      FIJ(3,3) =       C1*GX(0)*GY(0)*GZ(2)
      FIJ(1,2) =       C1*GX(1)*GY(1)*GZ(0)
      FIJ(1,3) =       C1*GX(1)*GY(0)*GZ(1)
      FIJ(2,3) =       C1*GX(0)*GY(1)*GZ(1)
      FIJ(2,1) =       FIJ(1,2)
      FIJ(3,1) =       FIJ(1,3)
      FIJ(3,2) =       FIJ(2,3)

C-----------------------------------------------------------------------
C  Compute Voigt matrix and derivatives w.r.t (x,y,z)
C-----------------------------------------------------------------------

      DO J=1,6
         DO I=1,6

            CIJ(I,J) = CIJ0(I,J)*FF

            DO K=1,3
               DCIJ (I,J,K)   = CIJ0(I,J)*FI (K)
            ENDDO

            DO L=1,3
               DO K=1,3
                  DDCIJ(I,J,K,L) = CIJ0(I,J)*FIJ(K,L)
               ENDDO
            ENDDO

         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE GAUSS2
C-----------------------------------------------------------------------

      SUBROUTINE G1D(G,N,X,X0,SIGMA)

C---  External: 
      INTEGER N
      REAL*8  G(0:N)
      REAL*8  X,X0
      REAL*8  SIGMA

C---  Local:
      REAL*8  TMP1,TMP2

C---  Gaussian and 1st and 2nd derivatives
      TMP1 = 1.0/(SIGMA*SIGMA)
      TMP2 = (X-X0)*TMP1
      G(0) = EXP(-(X-X0)*TMP2)
      G(1) = -2.0*TMP2*G(0)
      G(2) = -2.0*(TMP1 - 2.0*TMP2**2)*G(0)

      RETURN
      END





