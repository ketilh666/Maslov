C************************************************************************
C
C SUBROUTINE GM_PAR
C
C PURPOSE: Return parameters in the include file geo_model.inc
C
C MODEL ARRAY: NELK = No of elastic  moduli
C
C  * ISOTROPIC MEDIUM : NELK=2
C      IELK = 1       : LAM or VP  
C      IELK = 2       : MHU or VS  
C      IELK = NELK+1  : RHO
C
C  * TIV MEDIUM       : NELK=5
C      IELK = 1       : A   or VP0
C      IELK = 2       : C   or EPS
C      IELK = 3       : F   or DEL
C      IELK = 4       : L   or VS0
C      IELK = 5       : N   or GAM
C      IELK = NELK+1  : RHO
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD OCTOBER 1999
C
C************************************************************************

      SUBROUTINE GM_PAR( L_ISO,L_TIV,L_TIH,L_TIG,L_ORG,JNDV2H,NAXPOL)

      IMPLICIT NONE

C---  External output variables:
      INTEGER  L_ISO,L_TIV,L_TIH,L_TIG,L_ORG
      INTEGER  NAXPOL
      INTEGER  JNDV2H(2,6)

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      INTEGER  I,J

C-----------------------------------------------------------------------
C     Parameters in the include file geo_model.inc
C-----------------------------------------------------------------------

      L_ISO = K_ISO  ! Isotropic
      L_TIV = K_TIV  ! TI vertical symmetry axis
      L_TIH = K_TIH  ! TI horizontal symmetry axis
      L_TIG = K_TIG  ! TI general symmetry axis
      L_ORG = K_ORG  ! Ortorhombic general

C---  Index tables:
      DO J=1,6
         DO I=1,2
            JNDV2H(I,J) = INDV2H(I,J)
         ENDDO
      ENDDO

C---  Polynomial interpolation:
      NAXPOL = MAXPOL

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE GM_PAR
C-----------------------------------------------------------------------


