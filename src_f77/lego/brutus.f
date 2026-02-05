C************************************************************************
C
C SUBROUTINE BRUTUS
C
C PURPOSE: Compute the invariants eigenvalues and eigenvectors
C          of the Christoffel tensor by the Jacobi method.
C          Note that eigenvalues are returned without taking 
C          the square root.
C
C REFERENCES: Numerical Receipes, Chapter 11.1
C
C SUBROUTINES CALLED : JACOBI EIGSRT
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE BRUTUS(GN,GVEC,GAM,LDEGEN)

      IMPLICIT NONE

C---  External variables:
      REAL*8   GAM(3,3)   ! Christoffel tensor
      REAL*8   GN(3)      ! Eigen values of the Christoffel tensor
      REAL*8   GVEC(3,3)  ! Eigen vectors of the Christoffel tensor
      LOGICAL  LDEGEN     ! Degenerate eigenvalues for qS1 and qS2?

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'

C---  Internal variables:
      REAL*8   GAM2(3,3),GVEC2(3,3)
      INTEGER  NROT,I,J

C-----------------------------------------------------------------------
C  Make a copy of GAM because JACOBI destroys the matrix
C-----------------------------------------------------------------------

      DO J=1,3
         DO I=1,3
            GAM2(I,J) = GAM(I,J)
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C  Compute eigenvalues and eigenvectors of Christoffel tensor
C  by the Jacobi method, see Numerical Receipes chapter 11.1
C-----------------------------------------------------------------------

      CALL JACOBI(GAM2,3,3,GN,GVEC2,NROT)
      CALL EIGSRT(GN,GVEC2,3,3)

C-----------------------------------------------------------------------
C  Check for degenerate eigenvalues
C-----------------------------------------------------------------------

      LDEGEN = ABS( (GN(K_QS2)-GN(K_QS1))/GN(K_QS1) ) .LT. TOSH

      DO J=1,3
         DO I=1,3
            GVEC(I,J) = GVEC2(I,J)
         ENDDO
      ENDDO

C      WRITE(6,*) '   BRUTUS: Jacobi iterations '
C      WRITE(6,*) ' + GN = ',SQRT(GN(1)),SQRT(GN(2)),SQRT(GN(3))

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE BRUTUS
C-----------------------------------------------------------------------





