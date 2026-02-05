C***********************************************************************
C INCLUDE FILE interpol.inc
C
C PURPOSE: Define parameters for polynomial interpolation.
C          
C PROGRAMMED : KETIL HOKSTAD SEPTEMBER 1999
C
C***********************************************************************

C---  Max no of points in Shepard interpolation:
      INTEGER     MAXSHE,MPOSHE
      PARAMETER ( MAXSHE =  10 ) ! Max no of points in Shepard interpol
      PARAMETER ( MPOSHE =   2 ) ! Power n of Euclidean L**n norm.
      

C---  Subspace radius for nearest neighbor search:
      INTEGER     LSRCH1,LSRCH2,LSRCH3
      PARAMETER ( LSRCH1 =   5 ) ! Search halflength #1 (IRAYEL)
      PARAMETER ( LSRCH2 =   5 ) ! Search halflength #2 (ITH)
      PARAMETER ( LSRCH3 =   5 ) ! Search halflength #3 (IPH)

C***********************************************************************
C   END OF INCLUDE FILE interpol.inc
C***********************************************************************



