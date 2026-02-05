C***********************************************************************
C
C SUBROUTINE DRHOOK
C
C PURPOSE: Get density normalized Hooke's tensor a_klmn and its
C          spatial derivatives a_klmn,i and a_klmn,ij from a 3D grid.
C          Note: 3D grid is single presicion (REAL*4).
C          
C SUBROUTINES CALLED : REODOR FELGEN
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C***********************************************************************

      SUBROUTINE DRHOOK(AA,DADI,DADIJ,NDERIV,X,KASINO,
     +                  ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)

      IMPLICIT NONE

C---  External input variables:
      REAL*8   X(3)                  ! Position to get AA and DADI
      INTEGER  KASINO                ! Anisotropic symmetry type
      INTEGER  NDERIV                ! Higest order of deriv. (0/1/2)
C###  NOTE: The elastic model is REAL*4:
      INTEGER  NX,NY,NZ              ! Size of elastic grid model
      INTEGER  NELK                  ! No of independent elastic moduli
      REAL*4   ELK4(NX,NY,NZ,NELK)   ! Density norm. moduli on a grid
      REAL*4   DXGRI4(3)             ! (x,y,z) steplength in moduli
      REAL*4   X0GRI4(3)             ! (x,y,z) coord. of ELK4(1,1,1,*)
      INTEGER  NPOLX,NPOLY,NPOLZ     ! Degree of interpolating polynomial
      INTEGER  NPXYZ                 ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4   CA4(NPXYZ+1,3)        ! Precomputed array for interpolation
      REAL*4   DA4(NPXYZ+1,3)        ! Precomputed array for interpolation 

C---  External output variables:
      REAL*8   AA   (3,3,3,3    )    ! Density norm. moduli at (x,y,z)
      REAL*8   DADI (3,3,3,3,3  )    ! 1st deriv. of moduli w.r.t (x,y,z) 
      REAL*8   DADIJ(3,3,3,3,3,3)    ! 2nd deriv. of moduli w.r.t (x,y,z) 

C---  Parameters:
      include '../include_files/geo_model.inc'

C---  Internal variables:
      REAL*4   CAF4  ( 3*(MAXPOL+1)) ! Cardinal functions
      REAL*4   DCAF4 ( 3*(MAXPOL+1)) ! 1st deriv. of Cardinal func.
      REAL*4   DDCAF4( 3*(MAXPOL+1)) ! 2nd deriv. of Cardinal func.
      REAL*4   FUN4  (21*(MAXPOL+1)**3) ! Function at nodes
      REAL*4   PIA4  (    21)        ! Interpolated elastic moduli
      REAL*4   DPIA4 (3,  21)        ! 1st deriv. of interp. moduli
      REAL*4   DDPIA4(3,3,21)        ! 2nd deriv. of interp. moduli
      REAL*4   X4(3)                 ! Position to get AA and DADI
      INTEGER  I

      REAL*8   CIJ  (6,6    )        ! Voigt matrix
      REAL*8   DCIJ (6,6,3  )        ! 1st deriv. of Voigt matrix
      REAL*8   DDCIJ(6,6,3,3)        ! 2nd deriv. of Voigt matrix

      REAL*8   AAK   (3,3,3,3    )    ! Density norm. moduli at (x,y,z)
      REAL*8   DADIK (3,3,3,3,3  )    ! 1st deriv. of moduli w.r.t (x,y,z) 
      REAL*8   DADIJK(3,3,3,3,3,3)    ! 2nd deriv. of moduli w.r.t (x,y,z) 
      REAL*8   RC(5)
      REAL*8   SC(5)
      REAL*8   FR,FS
      PARAMETER (FR=1.0d0,FS=1.0d0)

C-----------------------------------------------------------------------
C  Get density normalized elastic moduli a_klmn (AA) and its  
C  derivatives a_klmn,i (DADI) and a_klmn,ij (DADIJ)  from 3D grid.
C  The conversion goes via the Voigt C_IJ matrix representation.
C-----------------------------------------------------------------------

C---  Convert Position X to REAL*4
      DO I=1,3
         X4(I) = REAL(X(I))
      ENDDO

c$$$      WRITE(6,*) '* DRHOOK: X4,Y4,Z4 = ',X4(1),X4(2),X4(3)
c$$$      WRITE(6,*) ' - NDERIV = ',NDERIV
c$$$      WRITE(6,*) ' - NX,NY,NZ,NELK = ',NX,NY,NZ,NELK
c$$$      WRITE(6,*) ' - DX,DY,DX      = ',DXGRI4(1),DXGRI4(2),DXGRI4(3)
c$$$      WRITE(6,*) ' - X0,Y0,Z0      = ',X0GRI4(1),X0GRI4(2),X0GRI4(3)
c$$$      WRITE(6,*) ' + ELK4(1,1,1,1) = ',ELK4(1,1,1,1)
c$$$      WRITE(6,*) ' + ELK4(1,1,1,2) = ',ELK4(1,1,1,2)
c$$$      WRITE(6,*) ' + ELK4(1,1,1,3) = ',ELK4(1,1,1,3)
c$$$      WRITE(6,*) ' + ELK4(1,1,1,4) = ',ELK4(1,1,1,4)
c$$$      WRITE(6,*) ' + ELK4(1,1,1,5) = ',ELK4(1,1,1,5)

C---  Get Voigt matrix and derivatives from grid:
      CALL REODOR(PIA4,DPIA4,DDPIA4,NDERIV,X4,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,
     +            CAF4,DCAF4,DDCAF4,FUN4,NPXYZ)

C---  Copy Voigt matrix to Hooke's tensor:
      CALL FELGEN(AA,DADI,DADIJ,NDERIV,KASINO,
     +            PIA4,DPIA4,DDPIA4,NELK)

C#################################################################
C     ANALYTICAL GAUSS2 MODEL
C        1. RE_OLD: Get Voigt matrix and derivatives
C        2. FE_OLD: Copy Voigt matrix to Hooke's tensor:
C#################################################################

c$$$      CALL RE_OLD(CIJ,DCIJ,DDCIJ,NDERIV,X,KASINO, 
c$$$     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4)
c$$$
c$$$      CALL FE_OLD(AA,DADI,DADIJ,CIJ,DCIJ,DDCIJ,NDERIV)

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE DRHOOK
C-----------------------------------------------------------------------




