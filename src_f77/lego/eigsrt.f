C************************************************************************
C
C SUBROUTINE EIGSRT
C
C PURPOSE: Sort in eigenvalues and eigenvectors computed by
C          Jacobi iteration in descending order (w.r.t eigenvalues).
C
C REFERENCE: Numerical Receipes, Chapter 11.1 
C            Modified to sort in acending order instead of 
C            decending.   
C            
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : CARL SPENCER, SCHLUMBERGER CAMBRIDGE RESEARCH
C MODIFIED           : KETIL HOKSTAD DECEMBER 1998
C MODIFIED           : TO ENSURE CONTINUITY OF EIGENVECTORS A NEW TEST 
C                      WAS ADDED AT THE END OF THE SORTING ROUTINE. THIS 
C                      WILL FORCE THE qSV POLARIZATION TO BE ALWAYS RE 
C                      LATIVE TO THE NEGATIVE Z-AXIS (UP)
C                      SVERRE BRANDSBER-DAHL, JANUARY 1999
C
C************************************************************************

      SUBROUTINE EIGSRT(D,V,N,NP)

      IMPLICIT NONE

C---  External variables:
      INTEGER    N,NP
      REAL*8     D(NP),V(NP,NP)

C---  Local variables:
      INTEGER    I,J,K
      REAL*8     P

C-----------------------------------------------------------
C  Sort in ascending order
C-----------------------------------------------------------

      DO I=1,N-1

         K=I
         P=D(I)
         
C---     Test on eigenvalue:
         DO J=I+1,N
            IF (D(J).LE.P) THEN
               K=J
               P=D(J)
            ENDIF
         ENDDO
         
C---     Permutation:
         IF (K.NE.I) THEN
            D(K)=D(I)
            D(I)=P
            DO J=1,N
               P=V(J,I)
               V(J,I)=V(J,K)
               V(J,K)=P
            ENDDO
         ENDIF
         
      ENDDO

C-----------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------
C   END OF SUBROUTINE EIGSRT
C-----------------------------------------------------------



