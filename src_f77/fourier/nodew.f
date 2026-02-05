C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                         N O D E W                              *****
C*****                                                             ******
C************************************************************************
 
        SUBROUTINE NODEW(WARR,NT,DT,ATT)
 
	IMPLICIT NONE
 
        INTEGER NT                 ! I   NO. TIMESAMPLES
        REAL DT                    ! I   SAMPLING INTERVAL
        REAL ATT                   ! I   ATTENUATION
        COMPLEX WARR(NT)           ! O   FREQUENCY ARRAY
 
C******SUBROUTINE NODEW *************************************************
C
C PURPOSE : GENERATE COMPLEX FREQUENCY ARRAY FOR POSITIVE ANGULAR 
C           IN THE INTERVAL {0,..,OMEGA_NYQ}. 
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
C KETIL HOKSTAD MARCH 1994
C
C************************************************************************

        INTEGER I 
        REAL PI,DW,TAU
	PARAMETER(PI=3.141592653589793238)
 
C------------------------------------------------------------------

        DW=2.0*PI/(DT*REAL(NT))
        TAU=ALOG(ATT)/(DT*REAL(NT))

        DO 100 I=1,NT/2+1
           WARR(I)=CMPLX(REAL(I-1)*DW,TAU)
100     CONTINUE
 
C------------------------------------------------------------------
        RETURN
        END
C------------------------------------------------------------------
C     END OF SUBROUTINE NODEW  
C------------------------------------------------------------------




