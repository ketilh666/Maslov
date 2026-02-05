C************************************************************************
C
C SUBROUTINE DYNZRO
C
C PURPOSE: Compute initial matrices Qx and PX in cartesian coordinates 
C          from initial position, polarization and slowness vector 
C          in cartesian coordinates and initial matrices Qy and Py in 
C          ray centered coordinates.
C
C ERROR CONDITIONS:
C          IERR =  0 : Successful execution of routine
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : DRHOOK CHRIS1 HILL HYMAT GOCART
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE DYNZRO(QY,PY,X,P,GVEC,KMODE,HY,QX,PX,NX2,KASINO,
     +                  ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,IERR)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     QY(2,2), PY(2,2)    ! Initial matrices in ray centered
      REAL*8     X(3)                ! Posititon (x,y,z) to use
      REAL*8     P(3)                ! Initial slowness in cartesian coor.
      REAL*8     GVEC(3,3)           ! Initial polarizations in cartesian
      INTEGER    KMODE(3)            ! Current wavemode in KMODE(1)
      INTEGER    NX2                 ! 2nd dimension of QX and PX
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
      REAL*8     HY(3,3)             ! Ray centered to Cartesian transf.
      REAL*8     QX(3,NX2)           ! Initial matrix QX in cartesian coord
      REAL*8     PX(3,NX2)           ! Initial matrix PX in cartesian coord
      INTEGER    IERR   

C---  Parameters:
      INCLUDE   '../include_files/ray_control.inc'
      INTEGER    NDERIV,NMODE
      PARAMETER (NDERIV=1)
      PARAMETER (NMODE =1)

C---  Internal variables:
      LOGICAL    LDEGEN              ! Degenerate eigenvalues?
      INTEGER    I,J,M1              ! Loop counters
      REAL*8     GIGJ(3,3,NMODE)     ! Product of polariz. vect. DIJ/TRD
      REAL*8     GAM(3,3)            ! Christoffel tensor
      REAL*8     DGAMDX(3,3,3)       ! 1st deriv. of GAM w.r.t. position
      REAL*8     DGAMDP(3,3,3)       ! 1st deriv. of GAM w.r.t. slowness
      REAL*8     AA   (3,3,3,3    )  ! Density normalized moduli at x
      REAL*8     DADI (3,3,3,3,3  )  ! 1st derivatives of moduli at x
      REAL*8     PUNK2(3,3,3,3,3,3)  ! Dummy array
      REAL*8     PDOT(3),XDOT(3)     ! Derivatives of X and P w.r.t. T

C-----------------------------------------
C   Initialize 
C-----------------------------------------

      IERR = 0

C-----------------------------------------------------------------------
C   Get density normalized moduli at position X and compute
C   1st derivatives of Christoffel tensor.
C-----------------------------------------------------------------------

      CALL DRHOOK(AA,DADI,PUNK2,NDERIV,X,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)
      CALL CHRIS1(DGAMDX,DGAMDP,AA,DADI,P)

C-----------------------------------------------------------------------
C   Compute group velocity dx_i/dt and dp_i/dt in cartesian 
C   coordinates using Cerveny equations (3.6.8)
C   Compute matrix HY using Cerveny equation (4.1.42)
C   Compute the matrices Px and Qx in cartesian coordinates,
C   Cerveny equations (4.14.29) and (4.14.31)
C-----------------------------------------------------------------------

C---  Outer product of polarization vector:
      M1 = KMODE(1)       ! The wave mode of the current ray
      DO J=1,3
         DO I=1,J
            GIGJ(I,J,1) = GVEC(I,M1)*GVEC(J,M1)
            GIGJ(J,I,1) = GIGJ(I,J,1)
         ENDDO
      ENDDO

      CALL HILL(XDOT,PDOT,DGAMDX,DGAMDP,GIGJ)
      CALL HYMAT(HY,GVEC,ECART)
      CALL GOCART(QX,PX,3,NX2,X,P,XDOT,PDOT,HY,QY,PY,2,2)

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE DYNZRO
C-----------------------------------------------------------------------


