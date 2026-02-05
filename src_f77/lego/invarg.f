C************************************************************************
C
C SUBROUTINE INVARG
C
C PURPOSE: Compute the invariants P,Q,R of the Christoffel tensor
C          tensor by Cervenys equations (2.2.29).

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
C
C************************************************************************

      SUBROUTINE INVARG(P,Q,R,GAM)

      IMPLICIT NONE

C---  External variables:
      REAL*8   GAM(3,3)   ! Christoffel tensor
      REAL*8   P,Q,R      ! Invariants of the Christoffel matrix

C---  Parameters:

C---  Internal variables:

C-----------------------------------------------------------------------
C  Compute invariants of Christoffel tensor, Cerveny equation (2.2.29)
C-----------------------------------------------------------------------

C---  Trace:
      P  =  GAM(1,1)+GAM(2,2)+GAM(3,3)

C---  Sum of submatrix determinants:
      Q  = GAM(1,1)*GAM(2,2) - GAM(1,2)*GAM(1,2) +
     +     GAM(2,2)*GAM(3,3) - GAM(2,3)*GAM(2,3) +
     +     GAM(1,1)*GAM(3,3) - GAM(1,3)*GAM(1,3) 

C---  Determinant (The code line below is sufficient for our purpose):
Cut      R  = Q-P + 1.0
      R  = GAM(1,1)*(GAM(2,2)*GAM(3,3) - GAM(2,3)*GAM(2,3)) -
     +     GAM(1,2)*(GAM(2,1)*GAM(3,3) - GAM(1,3)*GAM(2,3)) +
     +     GAM(1,3)*(GAM(2,1)*GAM(2,3) - GAM(1,3)*GAM(2,2))

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE INVARG
C-----------------------------------------------------------------------


