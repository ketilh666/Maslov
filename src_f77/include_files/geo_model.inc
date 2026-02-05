
C***********************************************************************
C INCLUDE FILE geo_model.inc
C
C PURPOSE: Define parameters for discrete anisotropic geological model 
C          used in Runge-Kutta integration of raytracing equations.
C
C MODEL ARRAY: NELK = No of elastic  moduli
C
C  * ISOTROPIC MEDIUM : NELK=2
C      IELK = 1       : LAM or VP  
C      IELK = 2       : MHU or VS  
C
C  * TIV MEDIUM       : NELK=5
C      IELK = 1       : C11 = A   or VP0
C      IELK = 2       : C33 = C   or VS0
C      IELK = 3       : C13 = F   or DEL
C      IELK = 4       : C44 = L   or EPS
C      IELK = 5       : C55 = N   or GAM
C
C PROGRAMMED : KETIL HOKSTAD DECEMBER 1998
C              KETIL HOKSTAD AUGUST   1999
C
C***********************************************************************

      INTEGER     K_ISO, K_TIV, K_TIH, K_TIG, K_ORV, K_ORG
      PARAMETER ( K_ISO =  2 )  ! Isotropic
      PARAMETER ( K_TIV =  5 )  ! TI vertical symmetry axis
      PARAMETER ( K_TIH =  6 )  ! TI horizontal symmetry axis
      PARAMETER ( K_TIG =  7 )  ! TI general symmetry axis
      PARAMETER ( K_ORV =  9 )  ! Ortorhombic vertical symmetry axis
      PARAMETER ( K_ORG = 11 )  ! Ortorhombic general

C---  Index tables:
      INTEGER    INDV2H(2,6)    ! Table linking Hooke and Voigt indices
      DATA       INDV2H / 1,1,2,2,3,3,2,3,1,3,1,2 /

C---  Polynomial interpolation:
      INTEGER     MAXPOL
      PARAMETER ( MAXPOL =  7 ) ! Max degree of interpolating polynomial

C***********************************************************************
C   END OF INCLUDE FILE geo_model.inc
C***********************************************************************










