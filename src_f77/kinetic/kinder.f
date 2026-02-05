C************************************************************************
C
C SUBROUTINE KINDER
C
C PURPOSE: Compute derivatives of phase space coordinates (x_i,p_i)
C          with respect to traveltime along the ray
C          Note: 3D grid is single presicion (REAL*4).
C          
C NOTE   : Be aware of the dirty F77 style YDOT(1),YDOT(4) etc below. 
C          which can make debugging a real*8 nightmare. But it works 
C          because F77 passes the pointer to the first memory address:
C             Y(1:3),YDOT(1:3) <=> X(1:3),XDOT(1:3)
C             Y(4:6),YDOT(4:6) <=> P(1:3),PDOT(1:3)
C          The reason for doing this is that the Runge-Kutta 
C          integration of the kinematic raytracing system is easiest
C          to program when X_i and P_i forms a 6 dimensional 
C          vector (the phase space).
C          
C SUBROUTINES CALLED : DRHOOK CHRIST MESIAS CAESAR BRUTUS HILL 
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE KINDER(YDOT,Y,NDIM,GVEC,GN,KEVIN,KMODE,KASINO,
     +                  ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NDIM                ! Dim of Y and YDOT: NDIM=6
      REAL*8     Y(NDIM)             ! Phase space coord. (x_i,P-i)
      INTEGER    KEVIN               ! How to solve Christoffel equation?
      INTEGER    KMODE(3)            ! Current wave mode in KMODE(1)
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
      REAL*8     YDOT(NDIM)          ! Derivative of Y w.r.t traveltime T
      REAL*8     GN(3)               ! Eigen values  of Christoffel tensor 
      REAL*8     GVEC(3,3)           ! Eigen vectors of Christoffel tensor 

C---  Parameters:
      INCLUDE   '../include_files/ray_control.inc'
      INTEGER    NDERIV, NMODE
      PARAMETER (NDERIV=1)
      PARAMETER (NMODE =1)

C---  Internal variables:
      LOGICAL    LDEGEN              ! Degenerate eigenvals qS1 and qS2?
      INTEGER    M1
      REAL*8     TRD(3)              ! Trace of cofactor matrix
      REAL*8     GIGJ(3,3,3)         ! Product of polariz. vect. DIJ/TRD
      REAL*8     GAM(3,3)            ! Christoffel tensor
      REAL*8     DGAMDX(3,3,3)       ! 1st deriv. of GAM w.r.t. position
      REAL*8     DGAMDP(3,3,3)       ! 1st deriv. of GAM w.r.t. slowness
      REAL*8     AA   (3,3,3,3)      ! Density normalized elastic const.
      REAL*8     DADI (3,3,3,3,3)    ! Derivatives of elastic constants
      REAL*8     PUNK2(3,3,3,3,3,3)  ! Dummy array

      INTEGER    I                   ! For debugging

C-----------------------------------------------------------------------
C   Get density normalized moduli and 1st derivatives at position X
C   and compute the Christoffel tensor and its 1st derivatives
C   Note: Y(1:3) = X(1:3), Y(4:6) = P(1:3)
C-----------------------------------------------------------------------

      CALL DRHOOK(AA,DADI,PUNK2,NDERIV,Y(1),KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)
      CALL CHRIS0(GAM,AA,Y(4))
      CALL CHRIS1(DGAMDX,DGAMDP,AA,DADI,Y(4))

c$$$      WRITE(6,*) 'KINDER: X,XDOT=',(Y(I),I=1,3),(YDOT(I),I=1,3)

C-----------------------------------------------------------------------
C   Compute eigen values and eigenvectors (if KEVIN=KBRUT) of
C   the Christoffel tensor
C-----------------------------------------------------------------------

      IF (KEVIN.EQ.KBRUT) THEN
         !write(6,*) 'Calling BRUTUS'
         CALL BRUTUS(GN,GVEC,GAM,LDEGEN)
      ELSE
         !write(6,*) 'Calling CAESAR'
         CALL CAESAR(GN,GAM,KMODE,NMODE,LDEGEN)
      ENDIF

c$$$      WRITE(6,*) 'KINDER: KEVIN = ',KEVIN
c$$$      WRITE(6,*) ' $ P  = ',(Y(I),I=4,6)
c$$$      WRITE(6,*) ' $ CH1= ',(GAM(I,1),I=1,3)
c$$$      WRITE(6,*) ' $ CH2= ',(GAM(I,2),I=1,3)
c$$$      WRITE(6,*) ' $ CH3= ',(GAM(I,3),I=1,3)
c$$$      WRITE(6,*) ' $ GV1= ',(GVEC(I,1),I=1,3)
c$$$      WRITE(6,*) ' $ GV2= ',(GVEC(I,2),I=1,3)
c$$$      WRITE(6,*) ' $ GV3= ',(GVEC(I,3),I=1,3)
c$$$      WRITE(6,*) ' $ GN = ',(GN(I),I=1,3)

C-----------------------------------------------------------------------
C   Compute group velocity dx_i/dt and dp_i/dt using Cerveny
C   equations (3.6.8), (3.6.12) and (3.6.13). The eigen value GN of 
C   the Christoffel equation equals unity for a ray fulfilling the 
C   eikonal equation.
C   Note: YDOT(1:3)=XDOT(1:3), YDOT(4:6)=PDOT(1:3) 
C-----------------------------------------------------------------------

      M1 = KMODE(1)
      CALL MESIAS(GIGJ,TRD,GVEC,GN,GAM,KEVIN,KMODE,NMODE,LDEGEN)
      CALL HILL(YDOT(1),YDOT(4),DGAMDX,DGAMDP,GIGJ(1,1,M1))

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE KINDER
C-----------------------------------------------------------------------
















