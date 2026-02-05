C************************************************************************
C
C SUBROUTINE SHELLA
C
C PURPOSE: Sort an array of real number in ascending order
C          by Shell's method (diminishing incremental sort)  
C            
C REFERENCE: Numerical Receipes, Chapter 8.1
C            
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD MARCH 2000
C
C************************************************************************

      SUBROUTINE SHELLA(N,A,IND)

      IMPLICIT NONE

C---  External variables:
      INTEGER    N
      INTEGER    IND(N)   ! Index arrray
      REAL*4     A(N)     ! Numbers to be sorted


C---  Parameters:

C---  Local variables:
      INTEGER    I,J,INC
      INTEGER    L
      REAL*4     V

C-----------------------------------------------------------
C  Initiallize index array
C-----------------------------------------------------------

      DO I=1,N
         IND(I) = I
      ENDDO

C-----------------------------------------------------------
C  Sort in ascending order
C-----------------------------------------------------------

C---  Starting increment:
      INC = 1
 1    INC = 3*INC+1
      IF (INC.LE.N) GOTO 1

C---  Loop over partial sorts:
 2    CONTINUE
         INC = INC/3
         DO I=INC+1,N
            V = A(I)
            L = IND(I)
            J = I
 3          IF (A(J-INC).GT.V) THEN
               A(J)   = A(J-INC)
               IND(J) = IND(J-INC)
               J      = J - INC
               IF (J.LE.INC) GOTO 4
            GOTO 3
            ENDIF
 4          A(J)   = V
            IND(J) = L
         ENDDO
      IF (INC.GT.1) GOTO 2

C-----------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------
C   END OF SUBROUTINE SHELLA
C-----------------------------------------------------------



C************************************************************************
C
C SUBROUTINE SHELLD
C
C PURPOSE: Sort an array of real number in descending order
C          by Shell's method (diminishing incremental sort)  
C            
C REFERENCE: Numerical Receipes, Chapter 8.1
C            
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD MARCH 2000
C
C************************************************************************

      SUBROUTINE SHELLD(N,A,IND)

      IMPLICIT NONE

C---  External variables:
      INTEGER    N
      INTEGER    IND(N)   ! Index arrray
      REAL*4     A(N)     ! Numbers to be sorted


C---  Parameters:

C---  Local variables:
      INTEGER    I,J,INC
      INTEGER    L
      REAL*4     V

C-----------------------------------------------------------
C  Initiallize index array
C-----------------------------------------------------------

      DO I=1,N
         IND(I) = I
      ENDDO

C-----------------------------------------------------------
C  Sort in descending order
C-----------------------------------------------------------

C---  Starting increment:
      INC = 1
 1    INC = 3*INC+1
      IF (INC.LE.N) GOTO 1

C---  Loop over partial sorts:
 2    CONTINUE
         INC = INC/3
         DO I=INC+1,N
            V = A(I)
            L = IND(I)
            J = I
 3          IF (A(J-INC).LT.V) THEN
               A(J)   = A(J-INC)
               IND(J) = IND(J-INC)
               J      = J - INC
               IF (J.LE.INC) GOTO 4
            GOTO 3
            ENDIF
 4          A(J)   = V
            IND(J) = L
         ENDDO
      IF (INC.GT.1) GOTO 2

C-----------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------
C   END OF SUBROUTINE SHELLD
C-----------------------------------------------------------
