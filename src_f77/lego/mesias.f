C************************************************************************
C
C SUBROUTINE MESIAS
C
C PURPOSE: Compute outer product g_i g_j of polarization vectors.
C          The outer product can be computed in two different ways:
C          1. If KEVIN=KFAST g_i g_j = D_ij/D is computed using
C          Cervenys equations (3.6.12). 
C          2. If KEVIN=KBRUT, the polarization vectors must be given
C          as input, and the computation of the outer product is 
C          trivial.
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C                      KETIL HOKSTAD JANUARY  1999
C
C************************************************************************

      SUBROUTINE MESIAS(GIGJ,TRD,GVEC,GN,GAM,KEVIN,KMODE,NMODE,LDEGEN)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  NMODE           ! Number of modes to compute
      INTEGER  KEVIN           ! How to solve Christoffel equation?
      INTEGER  KMODE(3)        ! Wavemodes. Current mode is in kmode(1).
      REAL*8   GAM(3,3)        ! Christoffel tensor
      REAL*8   GN(3)           ! Eigenvalues  of the Christoffel tensor
      REAL*8   GVEC(3,3)       ! Eigenvectors of the Christoffel tensor
      LOGICAL  LDEGEN          ! Degenerate eigenvalues for qS1 and qS2?

C---  External output variables:
      REAL*8   GIGJ(3,3,3)     ! Product of polariz. vectors DIJ/TRD
      REAL*8   TRD(3)          ! Trace of cofactor matrix

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'

C---  Internal variables:
      INTEGER  I,J,K,M
      REAL*8   DIJ(3,3,3)
      REAL*8   GM

C-----------------------------------------------------------------------
C  Compute outer product of polarization vectors using  Cerveny 
C  equation (3.6.13). This equation breakes down when the qS1 and qS2
C  eigen values of the Christoffel equation are (numerically) equal, 
C  see Cerveny p. 140.
C-----------------------------------------------------------------------

      DO K=1,3
         TRD(K) = 1.0
      ENDDO

      IF (KEVIN.EQ.KFAST) THEN

C---     Cofactors:
         DO K=1,NMODE
            M  = KMODE(K)
            GM = GN(M)
            DIJ(1,1,M) = (GAM(2,2)-GM)*(GAM(3,3)-GM)-GAM(2,3)*GAM(2,3)
            DIJ(2,2,M) = (GAM(1,1)-GM)*(GAM(3,3)-GM)-GAM(1,3)*GAM(1,3)
            DIJ(3,3,M) = (GAM(1,1)-GM)*(GAM(2,2)-GM)-GAM(1,2)*GAM(1,2)
            DIJ(1,2,M) =  GAM(1,3)*GAM(2,3)-GAM(1,2)*(GAM(3,3)-GM)
            DIJ(1,3,M) =  GAM(1,2)*GAM(2,3)-GAM(1,3)*(GAM(2,2)-GM)
            DIJ(2,3,M) =  GAM(1,2)*GAM(1,3)-GAM(2,3)*(GAM(1,1)-GM)
            DIJ(2,1,M) =  DIJ(1,2,M)
            DIJ(3,1,M) =  DIJ(1,3,M)
            DIJ(3,2,M) =  DIJ(2,3,M)
            TRD(M) =  DIJ(1,1,M)+DIJ(2,2,M)+DIJ(3,3,M)
         ENDDO

C---     Outer product of polarization vectors:
         DO K=1,NMODE
            M  = KMODE(K)
            DO J=1,3
               DO I=1,3
                  GIGJ(I,J,M) = DIJ(I,J,M)/TRD(M)
               ENDDO
            ENDDO
         ENDDO

C-----------------------------------------------------------------------
C  Compute outer product of polarization vectors by trivial
C  multiplication. The polarization vectors must be computed elsewhere.
C-----------------------------------------------------------------------

      ELSE
         
C---     Outer product of precomputed polarization vectors:
         DO K=1,NMODE
            M  = KMODE(K)
            DO J=1,3
               DO I=1,3
                  GIGJ(I,J,M) = GVEC(I,M)*GVEC(J,M)
               ENDDO
            ENDDO
         ENDDO

      ENDIF

c$$$      M = KMODE(1)
c$$$      DO J=1,3
c$$$         WRITE(6,*) 'GAM (I,J)    = ',(GAM(I,J),I=1,3)
c$$$      ENDDO
c$$$      DO J=1,3
c$$$         WRITE(6,*) 'GIGJ(I,J,M1) = ',(GIGJ(I,J,M),I=1,3)
c$$$      ENDDO


C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE MESIAS
C-----------------------------------------------------------------------


