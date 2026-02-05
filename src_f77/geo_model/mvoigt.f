C************************************************************************
C
C SUBROUTINE MV_TIV
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

      SUBROUTINE MV_TIV(CIJ,DCIJ,DDCIJ,PIA4,DPIA4,DDPIA4,NELK)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NDERIV             ! Highest order of deriv. (0/1/2)
C###  NOTE: The elastic model is REAL*4:
      INTEGER    NELK               ! No of independent elastic moduli
      REAL*4     PIA4  (    NELK)   ! Interpolated elastic coefficients
      REAL*4     DPIA4 (3,  NELK)   ! 1st derivatives of interp. coeff.
      REAL*4     DDPIA4(3,3,NELK)   ! 2nd derivatives of interp. coeff.

C---  External output variables:
      REAL*8     CIJ  (6,6    )     ! Voigt matrix
      REAL*8     DCIJ (6,6,3  )     ! 1st derivatives of Voigt matrix
      REAL*8     DDCIJ(6,6,3,3)     ! 2nd derivatives of Voigt matrix

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      INTEGER    I,J,IELK
      REAL*8     PIA  (    21)      ! Interpolated elastic coefficients
      REAL*8     DPIA (3,  21)      ! 1st derivatives of interp. coeff.
      REAL*8     DDPIA(3,3,21)      ! 2nd derivatives of interp. coeff.

C-----------------------------------------------------------------------
C     Convert to REAL*8
C-----------------------------------------------------------------------

c$$$      DO IELK=1,NELK
c$$$         PIA(IELK) = DREAL(PIA4(IELK))
c$$$         DO J=1,3
c$$$            DPIA(J,IELK) = DREAL(DPIA4(J,IELK))
c$$$            DO I=1,3
c$$$               DDPIA(I,J,IELK) = DREAL(DDPIA4(I,J,IELK))
c$$$            ENDDO
c$$$         ENDDO
c$$$      ENDDO

      DO IELK=1,NELK
         PIA(IELK) = (PIA4(IELK))
         DO J=1,3
            DPIA(J,IELK) = (DPIA4(J,IELK))
            DO I=1,3
               DDPIA(I,J,IELK) = (DDPIA4(I,J,IELK))
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C     Fill in the upper triangel of the Voigt matrix
C-----------------------------------------------------------------------

C---  Voigt matrix:
      CIJ(1,1) = PIA(1)             

      CIJ(1,2) = PIA(1) - 2.0*PIA(5)
      CIJ(2,2) = PIA(1)             

      CIJ(1,3) = PIA(3)             
      CIJ(2,3) = PIA(3)             
      CIJ(3,3) = PIA(2)             

      CIJ(1,4) = 0.0
      CIJ(2,4) = 0.0
      CIJ(3,4) = 0.0
      CIJ(4,4) = PIA(4)             

      CIJ(1,5) = 0.0
      CIJ(2,5) = 0.0
      CIJ(3,5) = 0.0
      CIJ(4,5) = 0.0
      CIJ(5,5) = PIA(4)             

      CIJ(1,6) = 0.0
      CIJ(2,6) = 0.0
      CIJ(3,6) = 0.0
      CIJ(4,6) = 0.0
      CIJ(5,6) = 0.0
      CIJ(6,6) = PIA(5)             

      DO J=1,3

C---     1st derivatives:
         DCIJ(1,1,J) = DPIA(J,1)                

         DCIJ(1,2,J) = DPIA(J,1) - 2.0*DPIA(J,5)
         DCIJ(2,2,J) = DPIA(J,1)                

         DCIJ(1,3,J) = DPIA(J,3)                
         DCIJ(2,3,J) = DPIA(J,3)                
         DCIJ(3,3,J) = DPIA(J,2)                

         DCIJ(1,4,J) = 0.0
         DCIJ(2,4,J) = 0.0
         DCIJ(3,4,J) = 0.0
         DCIJ(4,4,J) = DPIA(J,4)                

         DCIJ(1,5,J) = 0.0
         DCIJ(2,5,J) = 0.0
         DCIJ(3,5,J) = 0.0
         DCIJ(4,5,J) = 0.0
         DCIJ(5,5,J) = DPIA(J,4)                

         DCIJ(1,6,J) = 0.0
         DCIJ(2,6,J) = 0.0
         DCIJ(3,6,J) = 0.0
         DCIJ(4,6,J) = 0.0
         DCIJ(5,6,J) = 0.0
         DCIJ(6,6,J) = DPIA(J,5)                

         DO I=1,3

C---        2nd derivatives:
            DDCIJ(1,1,I,J) = DDPIA(I,J,1)                   

            DDCIJ(1,2,I,J) = DDPIA(I,J,1) - 2.0*DDPIA(I,J,5)
            DDCIJ(2,2,I,J) = DDPIA(I,J,1)                   

            DDCIJ(1,3,I,J) = DDPIA(I,J,3)                   
            DDCIJ(2,3,I,J) = DDPIA(I,J,3)                   
            DDCIJ(3,3,I,J) = DDPIA(I,J,2)                   

            DDCIJ(1,4,I,J) = 0.0
            DDCIJ(2,4,I,J) = 0.0
            DDCIJ(3,4,I,J) = 0.0
            DDCIJ(4,4,I,J) = DDPIA(I,J,4)                   

            DDCIJ(1,5,I,J) = 0.0
            DDCIJ(2,5,I,J) = 0.0
            DDCIJ(3,5,I,J) = 0.0
            DDCIJ(4,5,I,J) = 0.0
            DDCIJ(5,5,I,J) = DDPIA(I,J,4)                   

            DDCIJ(1,6,I,J) = 0.0
            DDCIJ(2,6,I,J) = 0.0
            DDCIJ(3,6,I,J) = 0.0
            DDCIJ(4,6,I,J) = 0.0
            DDCIJ(5,6,I,J) = 0.0
            DDCIJ(6,6,I,J) = DDPIA(I,J,5)                   

         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE MV_TIV
C-----------------------------------------------------------------------


C************************************************************************
C
C SUBROUTINE MV_ISO
C
C PURPOSE: Fill in the entries of the Voigt matrix
C          in an isotropic medium
C
C  * TIV MEDIUM       : NELK=2
C      IELK = 1       : LAM
C      IELK = 2       : MHU
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE MV_ISO(CIJ,DCIJ,DDCIJ,PIA4,DPIA4,DDPIA4,NELK)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NDERIV             ! Highest order of deriv. (0/1/2)
C###  NOTE: The elastic model is REAL*4:
      INTEGER    NELK               ! No of independent elastic moduli
      REAL*4     PIA4  (    NELK)   ! Interpolated elastic coefficients
      REAL*4     DPIA4 (3,  NELK)   ! 1st derivatives of interp. coeff.
      REAL*4     DDPIA4(3,3,NELK)   ! 2nd derivatives of interp. coeff.

C---  External output variables:
      REAL*8     CIJ  (6,6    )     ! Voigt matrix
      REAL*8     DCIJ (6,6,3  )     ! 1st derivatives of Voigt matrix
      REAL*8     DDCIJ(6,6,3,3)     ! 2nd derivatives of Voigt matrix

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Internal variables:
      INTEGER    I,J,IELK
      REAL*8     PIA  (    21)      ! Interpolated elastic coefficients
      REAL*8     DPIA (3,  21)      ! 1st derivatives of interp. coeff.
      REAL*8     DDPIA(3,3,21)      ! 2nd derivatives of interp. coeff.

C-----------------------------------------------------------------------
C     Convert to REAL*8
C-----------------------------------------------------------------------

c$$$      DO IELK=1,NELK
c$$$         PIA(IELK) = DREAL(PIA4(IELK))
c$$$         DO J=1,3
c$$$            DPIA(J,IELK) = DREAL(DPIA4(J,IELK))
c$$$            DO I=1,3
c$$$               DDPIA(I,J,IELK) = DREAL(DDPIA4(I,J,IELK))
c$$$            ENDDO
c$$$         ENDDO
c$$$      ENDDO

      DO IELK=1,NELK
         PIA(IELK) = (PIA4(IELK))
         DO J=1,3
            DPIA(J,IELK) = (DPIA4(J,IELK))
            DO I=1,3
               DDPIA(I,J,IELK) = (DDPIA4(I,J,IELK))
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C     Fill in the upper triangel of the Voigt matrix
C-----------------------------------------------------------------------

C---  Voigt matrix:
      CIJ(1,1) = PIA(1) + 2.0*PIA(2)            

      CIJ(1,2) = PIA(1) 
      CIJ(2,2) = PIA(1) + 2.0*PIA(2)            

      CIJ(1,3) = PIA(1)             
      CIJ(2,3) = PIA(1)             
      CIJ(3,3) = PIA(1) + 2.0*PIA(2)            

      CIJ(1,4) = 0.0
      CIJ(2,4) = 0.0
      CIJ(3,4) = 0.0
      CIJ(4,4) = PIA(2)             

      CIJ(1,5) = 0.0
      CIJ(2,5) = 0.0
      CIJ(3,5) = 0.0
      CIJ(4,5) = 0.0
      CIJ(5,5) = PIA(2)             

      CIJ(1,6) = 0.0
      CIJ(2,6) = 0.0
      CIJ(3,6) = 0.0
      CIJ(4,6) = 0.0
      CIJ(5,6) = 0.0
      CIJ(6,6) = PIA(2)             

      DO J=1,3

C---     1st derivatives:
         DCIJ(1,1,J) = DPIA(J,1) + 2.0*DPIA(J,2)               

         DCIJ(1,2,J) = DPIA(J,1) 
         DCIJ(2,2,J) = DPIA(J,1) + 2.0*DPIA(J,2)               

         DCIJ(1,3,J) = DPIA(J,1)                
         DCIJ(2,3,J) = DPIA(J,1)                
         DCIJ(3,3,J) = DPIA(J,1) + 2.0*DPIA(J,2)               

         DCIJ(1,4,J) = 0.0
         DCIJ(2,4,J) = 0.0
         DCIJ(3,4,J) = 0.0
         DCIJ(4,4,J) = DPIA(J,2)                

         DCIJ(1,5,J) = 0.0
         DCIJ(2,5,J) = 0.0
         DCIJ(3,5,J) = 0.0
         DCIJ(4,5,J) = 0.0
         DCIJ(5,5,J) = DPIA(J,2)                

         DCIJ(1,6,J) = 0.0
         DCIJ(2,6,J) = 0.0
         DCIJ(3,6,J) = 0.0
         DCIJ(4,6,J) = 0.0
         DCIJ(5,6,J) = 0.0
         DCIJ(6,6,J) = DPIA(J,2)                

         DO I=1,3

C---        2nd derivatives:
            DDCIJ(1,1,I,J) = DDPIA(I,J,1) + 2.0*DDPIA(I,J,2)                  

            DDCIJ(1,2,I,J) = DDPIA(I,J,1) 
            DDCIJ(2,2,I,J) = DDPIA(I,J,1) + 2.0*DDPIA(I,J,2)                  

            DDCIJ(1,3,I,J) = DDPIA(I,J,1)                   
            DDCIJ(2,3,I,J) = DDPIA(I,J,1)                   
            DDCIJ(3,3,I,J) = DDPIA(I,J,1) + 2.0*DDPIA(I,J,2)                  

            DDCIJ(1,4,I,J) = 0.0
            DDCIJ(2,4,I,J) = 0.0
            DDCIJ(3,4,I,J) = 0.0
            DDCIJ(4,4,I,J) = DDPIA(I,J,2)                   

            DDCIJ(1,5,I,J) = 0.0
            DDCIJ(2,5,I,J) = 0.0
            DDCIJ(3,5,I,J) = 0.0
            DDCIJ(4,5,I,J) = 0.0
            DDCIJ(5,5,I,J) = DDPIA(I,J,2)                   

            DDCIJ(1,6,I,J) = 0.0
            DDCIJ(2,6,I,J) = 0.0
            DDCIJ(3,6,I,J) = 0.0
            DDCIJ(4,6,I,J) = 0.0
            DDCIJ(5,6,I,J) = 0.0
            DDCIJ(6,6,I,J) = DDPIA(I,J,2)                   

         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE MV_ISO
C-----------------------------------------------------------------------


























