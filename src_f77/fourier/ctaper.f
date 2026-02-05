C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                         C T A P 1                              *****
C*****                                                             ******
C************************************************************************
 
        SUBROUTINE CTAP1(CF,NKDIM,NWDIM,NK,NW,TAP1,LTAP1,TAP2,LTAP2)
 
 	IMPLICIT NONE
 
	INTEGER NKDIM,NWDIM               
	INTEGER NK,NW               
	INTEGER LTAP1               ! Upper Taper length
	INTEGER LTAP2               ! Lower Taper length
	REAL    TAP1(LTAP1)         ! Precomputed Upper taper
	REAL    TAP2(LTAP2)         ! Precomputed Lower taper
	COMPLEX CF(NKDIM,NWDIM)     ! Complex array to be tapered
 
C******SUBROUTINE CTAP1 *************************************************
C
C PURPOSE : TAPER BOTH ENDS OF A COMPLEX 2D ARRAY IN THE DIRECTION OF THE
C           FIRST INDEX
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
	INTEGER IK,IW
 
C-----------------------------------------------------------------------
C    TAPER ARRAY                                                    
C-----------------------------------------------------------------------

	DO 1000 IW=1,NW 

C--- Taper upper part of the array:

	   DO 100 IK=1,LTAP1
	      CF(IK,IW)      = TAP1(IK)*CF(IK,IW)
100        CONTINUE 

C--- Taper lower part of the array:

	   DO 200 IK=1,LTAP2
	      CF(NK-IK+1,IW) = TAP2(IK)*CF(NK-IK+1,IW) 
200        CONTINUE 

1000    CONTINUE
 
C-----------------------------------------------------------------------
	RETURN
	END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE CTAP1       
C-----------------------------------------------------------------------


C************************************************************************
C*****                                                             ******
C***  I  K  U    S  E  I  S  M  I  C    S  U  B  R  O  U  T  I  N  E ****
C*                                                                     **
C***                         C T A P 2                              *****
C*****                                                             ******
C************************************************************************
 
        SUBROUTINE CTAP2(CF,NKDIM,NWDIM,NK,NW,TAP1,LTAP1,TAP2,LTAP2)
 
 	IMPLICIT NONE
 
	INTEGER NKDIM,NWDIM            
	INTEGER NK,NW                
	INTEGER LTAP1               ! Left Taper length
	INTEGER LTAP2               ! Right Taper length
	REAL    TAP1(LTAP1)         ! Precomputed Left taper
	REAL    TAP2(LTAP2)         ! Precomputed Right taper
	COMPLEX CF(NKDIM,NWDIM)     ! Complex array to be tapered
 
C******SUBROUTINE CTAP2 *************************************************
C
C PURPOSE : TAPER BOTH ENDS OF A COMPLEX 2D ARRAY IN THE DIRECTION OF THE
C           SECOND INDEX
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

	INTEGER IK,IW
 
C-----------------------------------------------------------------------
C    TAPER ARRAY                                                   
C-----------------------------------------------------------------------

C--- Taper upper part of the array:

	DO 1000 IW=1,LTAP1 
	   DO 100 IK=1,NK
	      CF(IK,IW)      = TAP1(IW)*CF(IK,IW) 
100        CONTINUE 
1000    CONTINUE

C--- Taper lower part of the array:

	DO 2000 IW=1,LTAP2
	   DO 200 IK=1,NK
	      CF(IK,NW-IW+1) = TAP2(IW)*CF(IK,NW-IW+1)
200        CONTINUE 
2000    CONTINUE
 
C-----------------------------------------------------------------------
	RETURN
	END
C-----------------------------------------------------------------------
C    END OF SUBROUTINE CTAP2       
C-----------------------------------------------------------------------

