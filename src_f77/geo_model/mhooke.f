C************************************************************************
C
C SUBROUTINE MHOOKE
C
C PURPOSE: Fill in the entries of the Voigt matrix
C          in a TIV medium
C
C  * TIV MEDIUM       : NELK=5
C      IELK = 1       : A
C      IELK = 2       : C
C      IELK = 3       : F
C      IELK = 4       : L
C      IELK = 5       : N
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE MHOOKE(AA,DADI,DADIJ,CIJ,DCIJ,DDCIJ)

      IMPLICIT NONE

C---  External input variables:
      REAL*8   CIJ  (6,6    )     ! Voigt matrix
      REAL*8   DCIJ (6,6,3  )     ! 1st derivatives of Voigt matrix
      REAL*8   DDCIJ(6,6,3,3)     ! 2nd derivatives of Voigt matrix

C---  External output variables:
      REAL*8   AA   (3,3,3,3    ) ! Density norm. moduli at (x,y,z)
      REAL*8   DADI (3,3,3,3,3  ) ! 1st deriv. of moduli w.r.t (x,y,z) 
      REAL*8   DADIJ(3,3,3,3,3,3) ! 2nd deriv. of moduli w.r.t (x,y,z) 

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      INTEGER  IVOI,JVOI,I,J,K,L,M,N 

C-----------------------------------------------------------------------
C  Fill in entries of the Hookes tensor and derivatives
C   * Indices IVOI,JVOI are Voigt indices
C   * Indices K,L,M,N are Hooke's tensor indices
C   * Index I denotes differentiation w.r.t x_i
C-----------------------------------------------------------------------

      DO JVOI=1,6
         DO IVOI=1,JVOI

C---        Get Hooke indices:
            K = INDV2H(1,IVOI)
            L = INDV2H(2,IVOI)
            M = INDV2H(1,JVOI)
            N = INDV2H(2,JVOI)

C---        Fill in density normalized moduli a_klmn:
            AA(K,L,M,N) = CIJ(IVOI,JVOI)
            AA(L,K,M,N) = CIJ(IVOI,JVOI)
            AA(K,L,N,M) = CIJ(IVOI,JVOI)
            AA(L,K,N,M) = CIJ(IVOI,JVOI)
            AA(M,N,K,L) = CIJ(IVOI,JVOI)
            AA(M,N,L,K) = CIJ(IVOI,JVOI)
            AA(N,M,K,L) = CIJ(IVOI,JVOI)
            AA(N,M,L,K) = CIJ(IVOI,JVOI)
            
C---        Fill in 1st derivatives of density norm. moduli a_klmn,i:
            DO I=1,3
               DADI(K,L,M,N,I) = DCIJ(IVOI,JVOI,I)
               DADI(L,K,M,N,I) = DCIJ(IVOI,JVOI,I)
               DADI(K,L,N,M,I) = DCIJ(IVOI,JVOI,I)
               DADI(L,K,N,M,I) = DCIJ(IVOI,JVOI,I)
               DADI(M,N,K,L,I) = DCIJ(IVOI,JVOI,I)
               DADI(M,N,L,K,I) = DCIJ(IVOI,JVOI,I)
               DADI(N,M,K,L,I) = DCIJ(IVOI,JVOI,I)
               DADI(N,M,L,K,I) = DCIJ(IVOI,JVOI,I)
            ENDDO

C---        Fill in 2nd derivatives of density norm. moduli a_klmn,ij:
            DO J=1,3
               DO I=1,3
                  DADIJ(K,L,M,N,I,J) = DDCIJ(IVOI,JVOI,I,J)
                  DADIJ(L,K,M,N,I,J) = DDCIJ(IVOI,JVOI,I,J)
                  DADIJ(K,L,N,M,I,J) = DDCIJ(IVOI,JVOI,I,J)
                  DADIJ(L,K,N,M,I,J) = DDCIJ(IVOI,JVOI,I,J)
                  DADIJ(M,N,K,L,I,J) = DDCIJ(IVOI,JVOI,I,J)
                  DADIJ(M,N,L,K,I,J) = DDCIJ(IVOI,JVOI,I,J)
                  DADIJ(N,M,K,L,I,J) = DDCIJ(IVOI,JVOI,I,J)
                  DADIJ(N,M,L,K,I,J) = DDCIJ(IVOI,JVOI,I,J)
               ENDDO
            ENDDO

         ENDDO
      ENDDO


C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE MHOOKE
C-----------------------------------------------------------------------









