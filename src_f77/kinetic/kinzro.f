C************************************************************************
C
C SUBROUTINE KINZRO
C
C PURPOSE: Compute initial slowness vector, phase velocity
C          and polarization vector for given initial 
C          phase direction.     
C
C ERROR CONDITIONS:
C          IERR =  0 : Successful execution of routine
C          IERR =  9 : Degenerate Eigenvalues for qS1 and qS2
C          IERR = 10 : Sign swapped on qP polarization vector.
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : DRHOOK CHRIST BRUTUS 
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE KINZRO(VNORM,KMODE,X,P,VPHASE,GN,GVEC,KASINO,
     +                  ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,IERR)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     VNORM(3)            ! Unit phase direction
      INTEGER    KMODE(3)            ! Current wave mode in KMODE(1)
      REAL*8     X(3)                ! Posititon (x,y,z) to use
      INTEGER    KASINO              ! Anisotropic symmetry type
C###  NOTE: The elastic model is REAL*4:
      INTEGER    NX,NY,NZ            ! Size of elastic grid model
      INTEGER    NELK                ! No of independent elastic moduli
      REAL*4     ELK4(NX,NY,NZ,NELK) ! Density norm. moduli on a grid
      REAL*4     DXGRI4(3)           ! (x,y,z) steplength in moduli
      REAL*4     X0GRI4(3)           ! (x,y,z) coord. of ELK4(1,1,1,*)
      INTEGER    NPOLX,NPOLY,NPOLZ   ! Degree of interpolating polynomial
      INTEGER    NPXYZ               ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4     CA4(NPXYZ+1,3)      ! Precomputed array for interpolation
      REAL*4     DA4(NPXYZ+1,3)      ! Precomputed array for interpolation 
 
C---  External output variables:
      REAL*8     P(3)                ! Slowness vector
      REAL*8     GN(3)               ! Eigen values
      REAL*8     GVEC(3,3)           ! Polarization vector
      REAL*8     VPHASE              ! Phase velocities
      INTEGER    IERR   

C---  Internal variables:
      LOGICAL    LDEGEN              ! Degenerate eigenvalues?
      INTEGER    I,M1                ! Loop counter
      REAL*8     GAM(3,3)            ! Christoffel tensor
      REAL*8     AA   (3,3,3,3    )  ! Density normalized moduli at x
      REAL*8     PUNK1(3,3,3,3,3  )  ! Dummy array
      REAL*8     PUNK2(3,3,3,3,3,3)  ! Dummy array

C---  Parameters:
      INCLUDE   '../include_files/ray_control.inc'
      INTEGER    NDERIV,NMODE
      PARAMETER (NDERIV=0)
      PARAMETER (NMODE =1)

C-----------------------------------------
C   Initialize 
C-----------------------------------------

      IERR = 0

C-----------------------------------------------------------------------
C   Get density normalized moduli at position X
C-----------------------------------------------------------------------

      CALL DRHOOK(AA,PUNK1,PUNK2,NDERIV,X,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)

C-----------------------------------------------------------------------
C   Solve Christoffel equation
C-----------------------------------------------------------------------

      CALL CHRIS0(GAM,AA,VNORM)
      CALL BRUTUS(GN,GVEC,GAM,LDEGEN)
      IF (LDEGEN) IERR = 9

c---  qP wave Z-component should have same sign as P(3):
      IF(SIGN(VNORM(3),GVEC(3,K_QP)).NE.VNORM(3))THEN
         IERR = 10
         DO I=1,3
            GVEC(I,K_QP) = -GVEC(I,K_QP)
         END DO
      END IF

C-----------------------------------------------------------------------
C   Phase velocity, slowness  and polarization vectors
C-----------------------------------------------------------------------

      M1 = KMODE(1)
      VPHASE = SQRT(GN(M1))
      
      DO I=1,3
         P(I)    = VNORM(I)/VPHASE
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE KINZRO
C-----------------------------------------------------------------------





