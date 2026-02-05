C************************************************************************
C
C SUBROUTINE IP_PAR
C
C PURPOSE: Return parameters in the include file interpol.inc
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD OCTOBER 1999
C
C************************************************************************

      SUBROUTINE IP_PAR(NAXSHE,NPOSHE,MSRCH1,MSRCH2,MSRCH3)

      IMPLICIT NONE

C---  External output variables:
      INTEGER  NAXSHE,NPOSHE
      INTEGER  MSRCH1,MSRCH2,MSRCH3

C---  Parameters:
      INCLUDE '../include_files/interpol.inc'

C---  Internal variables:

C-----------------------------------------------------------------------
C     Parameters in the include file interpol.inc
C-----------------------------------------------------------------------

C---  Max no of points in Shepard interpolation:
      NAXSHE = MAXSHE 
      NPOSHE = MPOSHE

C---  Subspace radius for nearest neighbor search:
      MSRCH1 = LSRCH1
      MSRCH2 = LSRCH2
      MSRCH3 = LSRCH3

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE IP_PAR
C-----------------------------------------------------------------------


