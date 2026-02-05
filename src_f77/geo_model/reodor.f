C***********************************************************************
C
C SUBROUTINE REODOR
C
C PURPOSE: Get density normalized Voigt matrix and its derivatives
C          from a 3D grid.
C          
C SUBROUTINES CALLED : CARPRE CARFUN CARI3D
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C***********************************************************************

      SUBROUTINE REODOR(PIA4,DPIA4,DDPIA4,NDERIV,X4,KASINO,
     +                  ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,
     +                  CAF4,DCAF4,DDCAF4,FUN4,NPXYZ)

      IMPLICIT NONE

C---  External input variables:
C###  NOTE: The elastic model is REAL*4:
      REAL*4     X4(3)                ! Position to get AA and DADI
      INTEGER    KASINO               ! Anisotropic symmetry type
      INTEGER    NDERIV               ! Highest order of deriv. (0/1/2)
      INTEGER    NX,NY,NZ             ! Size of elastic grid model
      INTEGER    NELK                 ! No of independent elastic moduli
      REAL*4     ELK4(NX,NY,NZ,NELK)  ! Density norm. moduli on a grid
      REAL*4     DXGRI4(3)            ! (x,y,z) steplength in moduli
      REAL*4     X0GRI4(3)            ! (x,y,z) coord. of ELK(1,1,1,*)
      INTEGER    NPOLX,NPOLY,NPOLZ    ! Degree of interpolating polynomial
      INTEGER    NPXYZ                ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4     CA4   (NPXYZ+1,3)    ! Precomputed array for interpolation
      REAL*4     DA4   (NPXYZ+1,3)    ! Precomputed array for interpolation 
      REAL*4     CAF4  (NPXYZ+1,3)    ! Cardinal functions
      REAL*4     DCAF4 (NPXYZ+1,3)    ! 1st deriv. of Cardinal func.
      REAL*4     DDCAF4(NPXYZ+1,3)    ! 2nd deriv. of Cardinal func.
      REAL*4     FUN4  (NPOLX+1,NPOLY+1,NPOLZ+1,NELK) ! Function at nodes

C---  External output variables:
      REAL*4     PIA4  (    NELK)     ! Interpolated elastic coefficients
      REAL*4     DPIA4 (3,  NELK)     ! 1st derivatives of interp. coeff.
      REAL*4     DDPIA4(3,3,NELK)     ! 2nd derivatives of interp. coeff.

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Local variables:
      INTEGER    I,J,K,IX,IY,IZ,IELK
      INTEGER    IXLM,IYLM,IZLM
      INTEGER    LPOLX,LPOLY,LPOLZ
      REAL*4     XGRI4(3),HX4(3)

C-----------------------------------------------------------------------
C     Get nearest node and distance from position X
C-----------------------------------------------------------------------

c$$$      LPOLX    = NPOLX/2 + 1
c$$$      LPOLY    = NPOLY/2 + 1
c$$$      LPOLZ    = NPOLZ/2 + 1

      IXLM     = INT((X4(1)-X0GRI4(1))/DXGRI4(1)) + 1
      IYLM     = INT((X4(2)-X0GRI4(2))/DXGRI4(2)) + 1
      IZLM     = INT((X4(3)-X0GRI4(3))/DXGRI4(3)) + 1

      XGRI4(1) = X0GRI4(1) + REAL(IXLM-1)*DXGRI4(1)
      XGRI4(2) = X0GRI4(2) + REAL(IYLM-1)*DXGRI4(2)
      XGRI4(3) = X0GRI4(3) + REAL(IZLM-1)*DXGRI4(3)

      HX4(1)  = X4(1) - XGRI4(1)
      HX4(2)  = X4(2) - XGRI4(2)
      HX4(3)  = X4(3) - XGRI4(3)

C-----------------------------------------------------------------------
C     Precomputed arrays
C-----------------------------------------------------------------------

      CALL CARPRE(LPOLX,CA4(1,1),DA4(1,1),NPOLX,DXGRI4(1))
      CALL CARPRE(LPOLY,CA4(1,2),DA4(1,2),NPOLY,DXGRI4(2))
      CALL CARPRE(LPOLZ,CA4(1,3),DA4(1,3),NPOLZ,DXGRI4(3))

C-----------------------------------------------------------------------
C     Compute Cardinal functions
C-----------------------------------------------------------------------

      CALL CARFUN(CAF4(1,1),DCAF4(1,1),DDCAF4(1,1),HX4(1),
     +            CA4(1,1),DA4 (1,1),NPOLX,NDERIV)
      CALL CARFUN(CAF4(1,2),DCAF4(1,2),DDCAF4(1,2),HX4(2),
     +            CA4(1,2),DA4 (1,2),NPOLY,NDERIV)
      CALL CARFUN(CAF4(1,3),DCAF4(1,3),DDCAF4(1,3),HX4(3),
     +            CA4(1,3),DA4 (1,3),NPOLZ,NDERIV)

C-----------------------------------------------------------------------
C     Interpolate elastic coefficients 
C-----------------------------------------------------------------------
C      IF(IY.NE.1) WRITE(6,*) 'REODOR: NPOLY = ',NPOLY

      DO IELK=1,NELK
         DO K=1,NPOLZ+1
            IZ = K+IZLM-LPOLZ
            IZ = MAX(IZ,1)
            IZ = MIN(IZ,NZ)
            DO J=1,NPOLY+1
               IY = J+IYLM-LPOLY
               IY = MAX(IY,1)
               IY = MIN(IY,NY)
               DO I=1,NPOLX+1
                  IX = I+IXLM-LPOLX
                  IX = MAX(IX,1)
                  IX = MIN(IX,NX)
                  FUN4(I,J,K,IELK) = ELK4(IX,IY,IZ,IELK) 
               ENDDO
            ENDDO
         ENDDO
         CALL CARI3D(PIA4(IELK),DPIA4(1,IELK),DDPIA4(1,1,IELK),
     +               FUN4(1,1,1,IELK),NPOLX,NPOLY,NPOLZ,
     +               CAF4,DCAF4,DDCAF4,NPXYZ,NDERIV)
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE REODOR
C-----------------------------------------------------------------------

C***********************************************************************
C
C SUBROUTINE RE_OLD
C
C PURPOSE: Get density normalized Voigt matrix and its derivatives
C          from a 3D grid.
C          
C SUBROUTINES CALLED : GAUSS2 (For the moment)
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C***********************************************************************

      SUBROUTINE RE_OLD(CIJ,DCIJ,DDCIJ,NDERIV,X,KASINO, 
     +                  ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NDERIV              ! Highest order of deriv. (0/1/2)
      INTEGER    KASINO              ! Anisotropic symmetry type
      REAL*8     X(3)                ! Position to get AA and DADI
      INTEGER    NX,NY,NZ            ! Size of elastic grid model
C###  NOTE: The elastic model is REAL*4:
      INTEGER    NELK                ! No of independent elastic moduli
      REAL*4     ELK4(NX,NY,NZ,NELK) ! Density norm. moduli on a grid
      REAL*4     DXGRI4(3)           ! (x,y,z) steplength in moduli
      REAL*4     X0GRI4(3)           ! (x,y,z) coord. of ELK4(1,1,1,*)

C---  External output variables:
      REAL*8     CIJ  (6,6    )      ! Voigt matrix
      REAL*8     DCIJ (6,6,3  )      ! 1st derivatives of Voigt matrix
      REAL*8     DDCIJ(6,6,3,3)      ! 2nd derivatives of Voigt matrix

C---  Parameters:
      INCLUDE '../include_files/geo_model.inc'

C---  Local variables:
      INTEGER    I,J,K,L

C-----------------------------------------------------------------------
C   Compute Voigt matrix and derivatives at X
C-----------------------------------------------------------------------

      CALL GAUSS2(CIJ,DCIJ,DDCIJ,X,NDERIV)

C-----------------------------------------------------------------------
      END
C-----------------------------------------------------------------------
C     END OF SUBROUTINE RE_OLD
C-----------------------------------------------------------------------
