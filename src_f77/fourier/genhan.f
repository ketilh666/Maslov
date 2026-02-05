C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                         G E N H A N                            *****
C*****                                                             ******
C************************************************************************
 
        SUBROUTINE GENHAN(TAP,LTAP,SIGNC)
 
 	IMPLICIT NONE
 
	INTEGER LTAP
	REAL    TAP(LTAP)
	REAL    SIGNC
 
C******SUBROUTINE GENHAN*************************************************
C
C PURPOSE : COMPUTE HANNING TAPER.
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

	INTEGER I
        REAL    PI  
	PARAMETER(PI=3.141592653589793238)
 
C-----------------------------------------------------------------------
C    COMPUTE HANNING TAPER                                          
C-----------------------------------------------------------------------

	DO I=1,LTAP 
	   TAP(I)=0.5*( 1.0 + SIGNC*COS( PI*REAL(I)/REAL(LTAP+1) ) )
	ENDDO
 
C-----------------------------------------------------------------------
	RETURN
	END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE GENHAN      
C-----------------------------------------------------------------------

C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                        G E N T A P K                            ****
C*****                                                             ******
C************************************************************************

       SUBROUTINE GENTAPK(TAPK,LTAPK)

       INTEGER  LTAPK
       REAL     TAPK(LTAPK,LTAPK)

       
C****** SUBROUTINE GENTAPK ***********************************************
C
C PURPOSE : COMPUTE FK-DOMAIN TAPER
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

        INTEGER I,IMAX
        REAL    PI  
        PARAMETER(PI=3.141592653589793238)

C-----------------------------------------------------------------------
C    PRECOMPUTE FK-DOMAIN TAPER ARRAY
C-----------------------------------------------------------------------

	DO IMAX=1,LTAPK
           DO I=1,IMAX
              TAPK(I,IMAX) = 0.5*( 1.0 + COS(REAL(I)*PI/REAL(IMAX+1)) )
	   ENDDO
	   DO I=IMAX+1,LTAPK
	      TAPK(I,IMAX) = 0.0
	   ENDDO
	ENDDO

C-----------------------------------------------------------------------
        RETURN
        END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE GENTAPK
C-----------------------------------------------------------------------
