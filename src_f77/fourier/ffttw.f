C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                         F F T T W                              *****
C*****                                                             ******
C************************************************************************
 
	SUBROUTINE FFTTW(RF,NT,NX,CF,NK,IWLO,IWHI,ZWRK,NW,SIGNI,SCL)
 
	IMPLICIT NONE
 
	INTEGER  NT                   ! Number of real samples per trace 
	INTEGER  NX                   ! Number of real traces
	INTEGER  NK                   ! First dimension of complex array 	
	INTEGER  IWLO,IWHI            ! Integer High cut and Low cut freq
	INTEGER  NW                   ! Number of complex frequencies
	REAL     RF(NT,NX)            ! Real input array to be transformed 	
	REAL     SIGNI                ! Sign of imaginary unit in FFT 
	REAL     SCL(NT)              ! Scale array for fft to complex freq
	COMPLEX  CF(NK,IWLO:IWHI)     ! Complex output array in freq domain
	COMPLEX  ZWRK(NW)             ! Complex work array  (Not used)
 
C******SUBROUTINE FFTTW *************************************************
C
C PURPOSE : FORWARD FFT FROM TIME TO COMPLEX FREQUENCY 
C
C
C SUBROUTINES CALLED :  FTFORK
C
C
C FUNCTIONS CALLED : NONE
C 
C PROGRAMMED :
C KETIL HOKSTAD MARCH 1995
C
C************************************************************************
 
	INTEGER IT,IW,IX,NWMAX
	PARAMETER(NWMAX=16384)
	COMPLEX CWRK(NWMAX)

C------------------------------------------------------------------------	
C    JUST TESTING
C------------------------------------------------------------------------
 
	IF(NW .GT. NWMAX) STOP
 
C-----------------------------------------------------------------------	
C    FFT FROM TIME TO COMPLEX FREQUENCY
C-----------------------------------------------------------------------
 
C$      DOACROSS LOCAL(IX,IW,IT,CWRK)
	DO 2000 IX = 1,NX

	   DO 100 IT = 1,NT
	      CWRK(IT) = SCL(IT)*CMPLX(RF(IT,IX))
100        CONTINUE

	   DO 200 IT = NT+1,NW
	      CWRK(IT) = CMPLX(0.0)
200        CONTINUE

           CALL FTFORK(NW,CWRK(1),SIGNI)

	   DO 300 IW = IWLO,IWHI
	      CF(IX,IW) = CWRK(IW)
300        CONTINUE

2000    CONTINUE
 
	DO 4000 IW = IWLO,IWHI
	   DO 400 IX=NX+1,NK
	      CF(IX,IW) = CMPLX(0.0)
400        CONTINUE
4000    CONTINUE
 
C------------------------------------------------------------------------	
	RETURN
	END
C------------------------------------------------------------------------	
C    END OF SUBROUTINE FFTTW 
C------------------------------------------------------------------------	


C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                         F F T W T                              *****
C*****                                                             ******
C************************************************************************
 
	SUBROUTINE FFTWT(RF,NT,NX,CF,NK,IWLO,IWHI,ZWRK,NW,SIGNI,SCL)
 
	IMPLICIT NONE
 
	INTEGER  NT                   ! Number of real samples per trace 
	INTEGER  NX                   ! Number of real traces
	INTEGER  NK                   ! First dimension of complex array 
	INTEGER  IWLO,IWHI            ! Integer High cut and Low cut freq
	INTEGER  NW                   ! Number of complex frequencies
	REAL     RF(NT,NX)            ! Real transformed output array 	
	REAL     SIGNI                ! Sign of imaginary unit in FFT 
	REAL     SCL(NT)              ! Scale array for FFT from complex freq
	COMPLEX  CF(NK,IWLO:IWHI)     ! Complex input array in freq domain
	COMPLEX  ZWRK(NW)             ! Complex work array  (Not used)
 
C******SUBROUTINE FFTWT *************************************************
C
C PURPOSE : INVERSE 2D FFT FROM COMPLEX FREQUENCY TO TIME DOMAIN 
C
C
C SUBROUTINES CALLED :  FTFORK  
C
C
C FUNCTIONS CALLED : NONE
C 
C PROGRAMMED :
C KETIL HOKSTAD MARCH 1995
C
C************************************************************************
 
	INTEGER IT,IW,IX,NWMAX
	PARAMETER(NWMAX=16384)
	COMPLEX CWRK(NWMAX)

C------------------------------------------------------------------------	
C    JUST TESTING
C------------------------------------------------------------------------
 
	IF(NW .GT. NWMAX) STOP
 
C------------------------------------------------------------------------	
C    FFT FROM TIME TO COMPLEX FREQUENCY
C------------------------------------------------------------------------
 
C$      DOACROSS LOCAL(IX,IW,IT,CWRK)
	DO 2000 IX = 1,NX 
  
	   DO 100 IW = 1,IWLO-1 
	      CWRK(IW) = CMPLX(0.0)
100        CONTINUE
	   DO 200 IW = IWLO,IWHI
	      CWRK(IW) = CF(IX,IW)
200        CONTINUE
	   DO 300 IW = IWHI+1,NW/2+1
	      CWRK(IW) = CMPLX(0.0)
300        CONTINUE

C--- Fill in with complex conjugates:

	   DO 400 IW = NW/2+2,NW
	      CWRK(IW) = CONJG(CWRK(NW-IW+2))
400        CONTINUE

 	   CALL FTFORK(NW,CWRK(1),SIGNI)

	   DO 500 IT=1,NT
 	      RF(IT,IX) = SCL(IT)*CWRK(IT)/REAL(NW) 
500        CONTINUE

2000    CONTINUE
 
C------------------------------------------------------------------------	
	RETURN
	END
C------------------------------------------------------------------------	
C    END OF SUBROUTINE FFTWT 
C------------------------------------------------------------------------	

