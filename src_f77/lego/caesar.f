C************************************************************************
C
C SUBROUTINE CAESAR
C
C PURPOSE: Compute eigenvalues GN(P) of the Christoffel tensor.
C          For the current mode, i.e. a ray fulfilling the eikonal 
C          equation, the eigen value  is GM=GN(P)=1.0. The two other 
C          eigenvalues are GN(P)=(VN/VM)**2, where VM and VN are
C          phase velocities, are computed by solving a quadratic 
C          equation for GN(P).
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : INVARG QROOTS
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C                      KETIL HOKSTAD JANUARY  1999
C
C************************************************************************

      SUBROUTINE CAESAR(GN,GAM,KMODE,NMODE,LDEGEN)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  NMODE           ! Number of modes to compute
      INTEGER  KMODE(3)        ! Wavemodes. Current mode is in kmode(1).
      REAL*8   GAM(3,3)        ! Christoffel tensor

C---  External output variables:
      REAL*8   GN(3)           ! Eigenvalues  of the Christoffel tensor
      LOGICAL  LDEGEN          ! Degenerate eigenvalues for qS1 and qS2?

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'

C---  Internal variables:
      INTEGER  M1,M2,M3,I
      REAL*8   P1,Q1,R1        ! Invariants of the Christoffel tensor.
      REAL*8   A1,B1,C1

C-----------------------------------------------------------------------
C  Compute eigen values GN(P) for the Christoffel equation.
C  According to the eikonal equation, the eigenvalue for the 
C  current mode is GM=1.0, see Cerveny equation (2.2.37). The 
C  two remaining eigenvalues are computed by solving a quadratic
C  equation where the coefficients are given by the invariants of 
C  the Christoffel tensor, see equations (2.2.28) and (2.2.29).
C-----------------------------------------------------------------------

      LDEGEN = .FALSE.

C---  The current  eigenmode:
      M1 = KMODE(1)             
      GN(M1) = 1.0       

      IF (NMODE.GT.1) THEN

C---     The 2nd and 3rd eigen modes:
         M2 = KMODE(2)    
         M3 = KMODE(3)    

C---     Invariants og the Christoffel tensor:
         CALL INVARG(P1,Q1,R1,GAM)

C---     Solve quadratic equation for the non-eikonal eigenvalues:
         A1 = 1.0d0
         B1 = P1-GN(M1)
         C1 = R1/GN(M1)
         CALL QROOTS(GN(M2),GN(M3),A1,B1,C1)

C---     Check for S-wave degeneracy:
         LDEGEN = ABS(GN(K_QS2)-GN(K_QS1)) .LE. TOSH*GN(K_QS1)

c$$$         WRITE(6,*) 'CAESAR : NMODE,KMODE = ',NMODE,(KMODE(I),I=1,3)
c$$$         WRITE(6,*) ' * GN = ',SQRT(GN(1)),SQRT(GN(2)),SQRT(GN(3))

      ENDIF

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CAESAR
C-----------------------------------------------------------------------


