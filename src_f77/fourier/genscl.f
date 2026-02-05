C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                         G E N S C L                            *****
C*****                                                             ******
C************************************************************************
 
        SUBROUTINE GENSCL(SCL,NT,NW,ATT,SIGNE)
 
 	IMPLICIT NONE
 
	INTEGER NT,NW
	REAL    SCL(NT)
	REAL    ATT
	REAL    SIGNE
 
C******SUBROUTINE GENHAN*************************************************
C
C PURPOSE : COMPUTE SCALE ARRAY FOR FFT TO/FROM COMPLEX FREQUWNCY
C
C
C ARGUMENTS :
C <NAME>   <DIMENSION>  <I/O> <TYPE> <EXPLANATION>
C
C
C SUBROUTINES CALLED :  NONE
C
C FUNCTIONS CALLED : NONE
C 
C PROGRAMMED :
C KETIL HOKSTAD FEBRUARY 1995
C
C************************************************************************

	INTEGER IT
        REAL    PI,TAU   
	PARAMETER(PI=3.141592653589793238)
 
C-----------------------------------------------------------------------	
C    PRECOMPUTE ARRAY OF SCALE FACTORS
C-----------------------------------------------------------------------

        TAU=ALOG(ATT)/(REAL(NW))
	DO IT=1,NT
 	   SCL(IT)=EXP(SIGNE*REAL(IT-1)*TAU)
	ENDDO
 
C-----------------------------------------------------------------------
	RETURN
	END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE GENSCL      
C-----------------------------------------------------------------------
