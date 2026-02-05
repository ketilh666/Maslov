C************************************************************************
C
C SUBROUTINE FELGEN
C
C PURPOSE: Get density normalized Hooke's tensor a_jklm and its
C          spatial derivatives a_jklm,i and a_jklm,ij from a 
C          Voigt matrix and its derivatives.
C          
C          The link between the indices in the Hooke (c_ijkl) 
C          Hooke (c_ijkl) Wand the Voigt (C_IJ) representations 
C          for a general  anisotropic medium is:
C
C              Voigt        Hooke
C                1    <=>    11
C                2    <=>    22
C                3    <=>    33
C                4    <=>   32=23
C                5    <=>   31=13
C                6    <=>   21=12
C     
C          I looked up this receipe in
C          Thomsen, L., 1986: Weak elastic anisotropy,
C          Geophysics, Vol 51, pp 1954-1966 (1986).
C           
C
C SUBROUTINES CALLED : MV_TIV MV_ISO MHOOKE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE FELGEN(AA,DADI,DADIJ,NDERIV,KASINO,
     +                  PIA4,DPIA4,DDPIA4,NELK)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  KASINO             ! Anisotropic symmetry type
      INTEGER  NDERIV             ! Highest order of deriv. (0/1/2)
C###  NOTE: The elastic model is REAL*4:
      INTEGER  NELK               ! No of independent elastic moduli
      REAL*4   PIA4  (    NELK)   ! Interpolated elastic coefficients
      REAL*4   DPIA4 (3,  NELK)   ! 1st derivatives of interp. coeff.
      REAL*4   DDPIA4(3,3,NELK)   ! 2nd derivatives of interp. coeff.

C---  External output variables:
      REAL*8   AA   (3,3,3,3    ) ! Density norm. moduli at (x,y,z)
      REAL*8   DADI (3,3,3,3,3  ) ! 1st deriv. of moduli w.r.t (x,y,z) 
      REAL*8   DADIJ(3,3,3,3,3,3) ! 2nd deriv. of moduli w.r.t (x,y,z) 

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
C      INTEGER  IVOI,JVOI,IELK
C      INTEGER  I,J,K,L,M,N
      REAL*8   CIJ  (6,6    )     ! Voigt matrix
      REAL*8   DCIJ (6,6,3  )     ! 1st derivatives of Voigt matrix
      REAL*8   DDCIJ(6,6,3,3)     ! 2nd derivatives of Voigt matrix

C-----------------------------------------------------------------------
C  Make the Voigt matrix
C  So far only TIV and isotropy is implemented.
C-----------------------------------------------------------------------

      IF(KASINO .EQ. K_TIV) THEN
C---     TIV model:
         CALL MV_TIV(CIJ,DCIJ,DDCIJ,PIA4,DPIA4,DDPIA4,NELK)

C$$$     IF(KASINO .EQ. K_TIH) THEN
C---     TIH model:
C$$$     IF(KASINO .EQ. K_TIG) THEN
C---     General TI model:
C$$$     IF(KASINO .EQ. K_ORG) THEN
C---     General orthorombic model:

      ELSE
C---     Isotropic model:
         CALL MV_ISO(CIJ,DCIJ,DDCIJ,PIA4,DPIA4,DDPIA4,NELK)
      ENDIF

C-----------------------------------------------------------------------
C  Make the Hookes tensor
C-----------------------------------------------------------------------

      CALL MHOOKE(AA,DADI,DADIJ,CIJ,DCIJ,DDCIJ)

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE FELGEN
C-----------------------------------------------------------------------


C************************************************************************
C
C SUBROUTINE FE_OLD
C
C PURPOSE: Get density normalized Hooke's tensor a_jklm and its
C          spatial derivatives a_jklm,i and a_jklm,ij from a 
C          Voigt matrix and its derivatives.
C          
C          The link between the indices in the Hooke (c_ijkl) 
C          Hooke (c_ijkl) Wand the Voigt (C_IJ) representations 
C          for a general  anisotropic medium is:
C
C              Voigt        Hooke
C                1    <=>    11
C                2    <=>    22
C                3    <=>    33
C                4    <=>   32=23
C                5    <=>   31=13
C                6    <=>   21=12
C     
C          I looked up this receipe in
C          Thomsen, L., 1986: Weak elastic anisotropy,
C          Geophysics, Vol 51, pp 1954-1966 (1986).
C           
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE FE_OLD(AA,DADI,DADIJ,CIJ,DCIJ,DDCIJ,NDERIV)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NDERIV             ! Highest order of deriv. (0/1/2)
      REAL*8     CIJ  (6,6    )     ! Voigt matrix
      REAL*8     DCIJ (6,6,3  )     ! 1st derivatives of Voigt matrix
      REAL*8     DDCIJ(6,6,3,3)     ! 2nd derivatives of Voigt matrix

C---  External output variables:
      REAL*8     AA   (3,3,3,3    ) ! Density norm. moduli at (x,y,z)
      REAL*8     DADI (3,3,3,3,3  ) ! 1st deriv. of moduli w.r.t (x,y,z) 
      REAL*8     DADIJ(3,3,3,3,3,3) ! 2nd deriv. of moduli w.r.t (x,y,z) 

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      INTEGER    IVOI,JVOI
      INTEGER    I,J,K,L,M,N

C-----------------------------------------------------------------------
C  Fill in Hookes tensor and derivatives
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
C   END OF SUBROUTINE FE_OLD
C-----------------------------------------------------------------------


