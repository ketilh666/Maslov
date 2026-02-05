C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                          W T F X 2 D                            ****
C*****                                                             ******
C************************************************************************

	SUBROUTINE WTSEIS(LUP,CGREEN,CWRK1,CWRK2,RWRK,SCL,NT,NX,NY,NW,
     +                    IWLOCU,IWLOCO,IWHICO,IWHICU,ATT,JREC0)
 
        IMPLICIT  NONE
 
	INTEGER     LUP(3,3),JREC0
	INTEGER     NT,NX,NY
	INTEGER     IWLOCU,IWLOCO,IWHICO,IWHICU,NW 
 
	REAL        ATT
	REAL        RWRK(NT,NX) 
	REAL        SCL(NT)
 
	COMPLEX     CWRK1(NW),CWRK2(NX,IWLOCU:IWHICU) 
	COMPLEX     CGREEN(3,3,NX,NY,IWLOCU:IWHICU)

C******SUBROUTINE WTSEIS**************************************************
C
C PURPOSE : INVERSE FOURIER TRANSFORM OF DATA FROM (KX,OMEGA)-DOMAIN
C           AND OUTPUT TO DISK 
C
C ARGUMENTS :
C <NAME>   <DIMENSION>  <I/O> <TYPE> <EXPLANATION>
C
C  LUP                    I    INT    I/O UNIT NUMBER
C  NT                     I    INT    NUMBER OF SAMPLES PER TRACE
C  NX                     I    INT    NUMBER OF TRACES  
C  NW                     I    INT    NUMBER OF FREQUENCIES (2**N)
C  IWLOCU                 I    INT    INTEGER LOW CUT FREQUENCY
C  IWLOCO                 I    INT    INTEGER LOW CORNER FREQUENCY
C  IWHICO                 I    INT    INTEGER HIGH CORNER FREQUENCY
C  IWHICU                 I    INT    INTEGER HIGH CUT FREQUENCY
C  CGREEN  NX,IWLOCU:IWHICU  O    CMPLX   INPUT DATA FROM FILE
C  CWRK        NW         -    CMPLX  COMPLEX WORK ARRAY
C  RWRK      NT,NX        -    REAL   WORK ARRAY
C  ATT                    I    REAL   ATTENUATION IN TEMPORAL FFT, ATT>=1.0
C  SCL         NT         -    REAL   SCALE FACTORS FOR TEMPORAL FFT
C  CDOMAIN                I    CHAR   DOMAIN OF DATA ON FILE (TX/FX)
C
C SUBROUTINES CALLED :  GENSCL GENHAN CTAP2 FFTWT
C
C FUNCTIONS CALLED :  LUFOPN
C 
C PROGRAMMED :
C KETIL HOKSTAD SEPTEMBER 1995
C
C***********************************************************************

C--- Parameters: 
	INTEGER    LTAPWM 
	PARAMETER (LTAPWM=1000) 

C--- Internal variables: 
	INTEGER IW,MW,IT,IX,IY
	INTEGER I,J,JREC
	INTEGER LTAPLO,LTAPHI 
	INTEGER ISTAT
	REAL    TAPLO(LTAPWM),TAPHI(LTAPWM)
	REAL    SIGNI,SIGNC,SIGNE
 
C-----------------------------------------------------------------------
C    INITIALIZATION                             
C-----------------------------------------------------------------------

	MW = IWHICU-IWLOCU+1

	SIGNI = -1.0

C-----------------------------------------------------------------------	
C    PRECOMPUTE ARRAY OF SCALE FACTORS FOR TEMPORAL FFT
C-----------------------------------------------------------------------

	SIGNE = 1.0
	CALL GENSCL(SCL,NT,NW,ATT,SIGNE)

C-----------------------------------------------------------------------
C    FREQUENCY DOMAIN TAPERING (BANDPASS FILTER)                             
C-----------------------------------------------------------------------

  	SIGNC = -1.0
 	LTAPLO = IWLOCO-IWLOCU
 	LTAPHI = IWHICU-IWHICO
 	CALL GENHAN(TAPLO,LTAPLO,SIGNC)
 	CALL GENHAN(TAPHI,LTAPHI,SIGNC)

C-----------------------------------------------------------------------
C    LOOP OVER TENSOR INDICES
C-----------------------------------------------------------------------

	OPEN(44,FILE='KAST.seq',FORM='UNFORMATTED')

	JREC = JREC0

	DO J=1,3
	   DO I=1,3

	      DO IY=1,NY

		 DO IW=IWLOCU,IWHICU
		    DO IX=1,NX
		       CWRK2(IX,IW) = CGREEN(I,J,IX,IY,IW)
		    ENDDO
		 ENDDO

		 CALL CTAP2(CWRK2,NX,MW,NX,MW,TAPLO,LTAPLO,TAPHI,LTAPHI)

C-----------------------------------------------------------------------
C     FFT from complex frequency to time   
C-----------------------------------------------------------------------

		 CALL FFTWT(RWRK,NT,NX,CWRK2,NX,IWLOCU,IWHICU,
     +                      CWRK1,NW,SIGNI,SCL)

C-----------------------------------------------------------------------
C     Write data in TX-domain.                                          
C-----------------------------------------------------------------------

C*********** DEBUGGING ********************************
      		 IF(I.EQ.3.AND.J.EQ.3) THEN
		    DO IX=1,NX
		       WRITE(44) (RWRK(IT,IX),IT=1,NT)
		    ENDDO
		 ENDIF
C******************************************************

		 DO IX=1,NX
		    JREC = JREC0 + IX + (IY-1)*NX
		    WRITE(LUP(I,J), REC=JREC) (RWRK(IT,IX),IT=1,NT)
		 ENDDO

	      ENDDO
	   ENDDO
	ENDDO

	CLOSE(44)
	JREC0 = JREC0 + NX*NY

C-----------------------------------------------------------------------
	RETURN
	END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE WTSEIS                         
C-----------------------------------------------------------------------





