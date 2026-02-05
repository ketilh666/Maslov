
C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                         F T F O R K                            *****
C*****                                                             ******
C************************************************************************
C
	SUBROUTINE FTFORK(NT,WRK1,SIGNI)
C
	INTEGER NT
        REAL    SIGNI
        COMPLEX WRK1(NT)
C
C
C******SUBROUTINE FTFORK*************************************************
C
C PURPOSE : FAST FOURIER TRANSFORM KERNEL SUBROUTINE. 
C           THE SUBROUTINE CALCULATES THE SUM  
C
C                        J=LX
C              WRK1(I) = SUM( WRK1(J)*EXP(2*PI*SIGNI*(J-1)*(I-1)/NT) )
C                        J=1
C                                                   FOR I = 1,2,...,LX
C
C           NOTE :  THE FACTOR OF 1/SQRT(NT) (OR 1/NT) IS NOT TAKEN INTO 
C           ACCOUNT IN SUBROUTINE FTFORK.
C
C           REFERENCE:
C              J.F. CLAERBOUT (1985):
C              IMAGING THE EARTH'S INTERIOR, P. 70.
C
C
C ARGUMENTS :
C <NAME>   <DIMENSION>  <I/O> <TYPE> <EXPLANATION>
C
C  WRK1        NT         O   CMPLX   1D DATA ARAY TO BE TRANSFORMED
C  NT                     I    INT    NUMBER OF SAMPLES, NT=2**N.
C  SIGNI                  I    REAL   SIGN OF IMAGINARY UNIT
C
C SUBROUTINES CALLED :  NONE
C
C
C FUNCTIONS CALLED : NONE
C 
C PROGRAMMED :
C IKU RFSU PROJECT
C KETIL HOKSTAD JULY 1992
C
C***********************************************************************
C ---------------------------------------------------------------------
        INTEGER I,J,K,M,ISTEP
        REAL PI
	COMPLEX  CT,CW,CARG,CI
C ---------------------------------------------------------------------        
C	PI=3.141592654
	PI=3.141592653589793238
	CI=(0.0,1.0)
C ---------------------------------------------------------------------
C	
	J=1
	K=1
C
	DO 10 I=1,NT
	   IF (I .LE. J) THEN
	      CT=WRK1(J)
	      WRK1(J) =WRK1(I)
	      WRK1(I)=CT
	   END IF
	   M=NT/2
C          
1          IF (J .GT. M ) THEN
	      J=J-M
	      M=M/2
              IF (M .GT. 0) THEN
                 GOTO 1
              ENDIF
           END IF
	   J=J+M
10      CONTINUE
C
3       CONTINUE
	   ISTEP = 2*K
	   DO 30 M=1,K
	      CARG=CI*PI*SIGNI*(M-1)/K
	      CW=CEXP(CARG)	      
	      DO 20 I=M,NT,ISTEP
	         CT=CW*WRK1(I+K)
	         WRK1(I+K)=WRK1(I)-CT
	         WRK1(I)=WRK1(I)+CT
20            CONTINUE
30	   CONTINUE 
	   K=ISTEP
        IF (K .LT. NT) THEN
	   GOTO 3
        END IF
C ---------------------------------------------------------------------
        RETURN
        END        
C ---------------------------------------------------------------------
C ------------     END OF SUBROUTINE  FTFORK    -----------------------
C ---------------------------------------------------------------------

