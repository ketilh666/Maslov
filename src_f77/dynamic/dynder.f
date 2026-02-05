C************************************************************************
C
C SUBROUTINE DYNDER
C
C PURPOSE: Compute derivatives with respect to traveltime along 
C          the ray of matrices Qx and Px in cartesian coordinates 
C          for dynamic raytracing.
C          Note: 3D grid is single presicion (REAL*4).
C          
C NOTE   : Be aware of the dirty F77 style YDOT(1),YDOT(4) etc below. 
C          which can make debugging a real*8 nightmare. But it works 
C          because F77 passes the pointer to the first memory address:
C             Y( 1: 3), YDOT( 1: 3) <=> X (1:3    ), XDOT (1:3    )
C             Y( 4: 6), YDOT( 4: 6) <=> P (1:3    ), PDOT (1:3    )
C             Y( 7:12), YDOT( 7:12) <=> Q1(1:3,1:2), Q1DOT(1:3,1:2)
C             Y(13:18), YDOT(13:18) <=> P1(1:3,1:2), P1DOT(1:3,1:2)
C             Y(19:24), YDOT(19:24) <=> Q2(1:3,1:2), Q2DOT(1:3,1:2)
C             Y(25:30), YDOT(25:30) <=> P2(1:3,1:2), P2DOT(1:3,1:2)
C          The reason for doing this is that the Runge-Kutta 
C          integration of the kinematic raytracing system is easiest
C          to program when Qx_ij and Px_ij forms a 12 dimensional vector.
C          
C SUBROUTINES CALLED : DRHOOK CHRIST MESIAS JUDAS
C                      CAESAR BRUTUS HILL BILL
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD JANUARY   1999
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE DYNDER(YDOT,Y,NDIM,GVEC,GN,KEVIN,KMODE,KASINO,
     +                  ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NDIM                  ! Dim of Y and YDOT: NDIM=18
      REAL*8     Y(NDIM)               ! Kinematic+Dynamic ray tracing vars.
      INTEGER    KEVIN                 ! How to solve Christoffel equation?
      INTEGER    KMODE(3)              ! Current wave mode in KMODE(1)
      INTEGER    KASINO                ! Anisotropic symmetry type
C###  NOTE: The elastic model is REAL*4:
      INTEGER    NX,NY,NZ              ! Size of elastic grid model
      INTEGER    NELK                  ! No of independent elastic moduli
      REAL*4     ELK4(NX,NY,NZ,NELK)   ! Density norm. moduli on a grid
      REAL*4     DXGRI4(3)             ! (x,y,z) steplength in moduli
      REAL*4     X0GRI4(3)             ! (x,y,z) coord. of ELK4(1,1,1,*)
      INTEGER    NPOLX,NPOLY,NPOLZ     ! Degree of interpolating polynomial
      INTEGER    NPXYZ                 ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4     CA4(NPXYZ+1,3)        ! Precomputed array for interpolation
      REAL*4     DA4(NPXYZ+1,3)        ! Precomputed array for interpolation 

C---  External output variables:
      REAL*8     YDOT(NDIM)            ! Derivative of Y w.r.t traveltime T
      REAL*8     GN(3)                 ! Eigen values  of Christoffel tensor 
      REAL*8     GVEC(3,3)             ! Eigen vectors of Christoffel tensor 

C---  Parameters:
      INCLUDE   '../include_files/ray_control.inc'
      INCLUDE   '../include_files/runge_kutta.inc'
      INTEGER    NDERIV, NMODE
      PARAMETER (NDERIV=2)
      PARAMETER (NMODE =3)

C---  Internal variables:
      LOGICAL    LDEGEN,LBRUT       ! Degenerate eigenvals qS1 and qS2?
      INTEGER    M1,M2,M3
      REAL*8     TRD(3)             ! Trace of cofactor matrix
      REAL*8     GIGJ(3,3,3)        ! Product of polariz. vect. DIJ/TRD
      REAL*8     GIDGJX(3,3,3)      ! Prod. of pol.vect. and derivs
      REAL*8     GIDGJP(3,3,3)      ! Prod. of pol.vect. and derivs
      REAL*8     GAM(3,3)           ! Christoffel tensor
      REAL*8     GAM2(3,3)          ! Christoffel tensor
      REAL*8     DGAMDX(3,3,3)      ! 1st deriv. of GAM w.r.t. position
      REAL*8     DGAMDP(3,3,3)      ! 1st deriv. of GAM w.r.t. slowness
      REAL*8     DGAMXX(3,3,3,3)    ! 2nd deriv. of GAM w.r.t. position
      REAL*8     DGAMPP(3,3,3,3)    ! 2nd deriv. of GAM w.r.t. slowness
      REAL*8     DGAMXP(3,3,3,3)    ! Mixed 2nd derivatives of GAM (X 1st)
      REAL*8     DGAMPX(3,3,3,3)    ! Mixed 2nd derivatives of GAM (P 1st)
      REAL*8     AA   (3,3,3,3)     ! Density normalized elastic const.
      REAL*8     DADI (3,3,3,3,3)   ! 1st derivatives of elastic const.
      REAL*8     DADIJ(3,3,3,3,3,3) ! 2nd derivatives of elastic const.
      REAL*8     GG(3)
      REAL*8     GVDOT(3,3)         ! Derivative of polariz. vector w.r.t time
      REAL*8     NEWGN(3)           ! New eigen values  of Christoffel tensor 
      INTEGER    I,J,K              ! For debugging

C###  How to compute derivatives of polarization ???
      INTEGER     KDEG
      PARAMETER ( KDEG = 0 )  ! Set to zero
Ccut  PARAMETER ( KDEG = 1 )  ! Cerveny eqs (4.14.9) and (4.14.10) 
Ccut  PARAMETER ( KDEG = 2 )  ! Cerveny eq  (4.14.14) and chain-rule 

C###  How to compute QXDOT and QPDOT ???
      INTEGER     KOPT
      PARAMETER ( KOPT = 1 )  ! This is what we used first  
Ccut  PARAMETER ( KOPT = 2 )  ! This should be correct (I think)

C-----------------------------------------------------------------------
C   Get density normalized moduli and 1st derivatives at position X
C   and compute the Christoffel tensor and its 1st derivatives
C   Note: Y(1:3) = X(1:3), Y(4:6) = P(1:3)
C-----------------------------------------------------------------------

      CALL DRHOOK(AA,DADI,DADIJ,NDERIV,Y(1),KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)
      CALL CHRIS0(GAM,AA,Y(4))
      CALL CHRIS1(DGAMDX,DGAMDP,AA,DADI,Y(4))
      CALL CHRIS2(DGAMXX,DGAMPP,DGAMXP,DGAMPX,AA,DADI,DADIJ,Y(4))

C-----------------------------------------------------------------------
C   Compute eigen values and eigenvectors if KEVIN=KBRUT or
C   compute eigenvalues if KFAST.
C-----------------------------------------------------------------------


C---  Should we do the full calculation??????
      IF     (KEVIN.EQ.KBRUT) THEN
         CALL BRUTUS(GN,GVEC,GAM,LDEGEN)

c$$$         IF (LDEGEN) THEN
c$$$            CALL DEGEN(NMODE,KMODE,GAM,AA,Y(4),GVEC,NEWGN,GAM2) 
c$$$
c$$$
c$$$            DO I=1,3
c$$$               GN(I) = NEWGN(I)
c$$$               DO J=1,3
c$$$                  GAM(J,I) = GAM2(J,I)
c$$$               ENDDO
c$$$            ENDDO
c$$$         ENDIF

C---  If not use the fast approximation
      ELSEIF (KEVIN.EQ.KFAST) THEN
         CALL CAESAR(GN,GAM,KMODE,NMODE,LDEGEN)
      ENDIF

C-----------------------------------------------------------------------
C   Compute products of polarization vectors and derivatives,
C   Cerveny equations (3.6.12), (3.6.13), (4.14.9) and (4.14.10).
C-----------------------------------------------------------------------

      CALL MESIAS(GIGJ,TRD,GVEC,GN,GAM,KEVIN,KMODE,NMODE,LDEGEN)

      IF     (KDEG .EQ. 1) THEN
C###     Use Cerveny eqs (4.14.9) and (4.14.10) for derivs of polariz:
         CALL JUDAS(GIDGJX,GIGJ,GN,DGAMDX,KMODE,NMODE,LDEGEN,
     +              GAM,AA,Y(4))
         CALL JUDAS(GIDGJP,GIGJ,GN,DGAMDP,KMODE,NMODE,LDEGEN,
     +              GAM,AA,Y(4))
      ELSEIF (KDEG .EQ. 2) THEN
C###     Use Cerveny eq  (4.14.14) and chain-rule for derivs of polariz:
         CALL GEDERT(GVDOT,GVEC,GN,Y(4),YDOT(4),KMODE)
         CALL GEDERK(GIDGJX,Y(4),GVDOT,GVEC,GN,KMODE)
         CALL GEDERK(GIDGJP,YDOT(4),GVDOT,GVEC,GN,KMODE)
      ELSE
C###     Set to zero:
         DO K=1,3
            DO J=1,3
               DO I=1,3
                  GIDGJX(I,J,K) = 0.0d0
                  GIDGJP(I,J,K) = 0.0d0
               ENDDO
            ENDDO
         ENDDO
      ENDIF

C-----------------------------------------------------------------------
C   Compute group velocity dx_i/dt and dp_i/dt using Cerveny
C   equations (3.6.12), (3.6.13), (4.14.3), (4.14.6).
C   Compute dQx_ij/dt and dPx_ij/dt using Cerveny
C   equations (4.14.5) and (4.14.7).
C   Note: YDOT( 1: 3)=XDOT (1:3)     , YDOT( 4: 6)=PDOT (1:3) 
C         YDOT( 7:12)=Q1DOT(1:3,1:2) , YDOT(13:18)=P1DOT(1:3,1:2)
C         YDOT(19:24)=Q2DOT(1:3,1:2) , YDOT(25:30)=P2DOT(1:3,1:2)
C-----------------------------------------------------------------------

      M1 = KMODE(1)

      IF (NDIM.LT.NKAD) THEN
C---     Tracing one  of Q1x,P1x OR  Q2x,P2x :
         IF (KOPT .EQ. 1) THEN
            CALL HILL(YDOT(1),YDOT(4),DGAMDX,DGAMDP,GIGJ(1,1,M1))
            CALL BILL(YDOT(7),YDOT(13),Y(7),Y(13),DGAMDX,DGAMDP,
     +                DGAMXX,DGAMXP,DGAMPX,DGAMPP,GIGJ(1,1,M1),
     +                GIDGJX,GIDGJP)
         ELSE
            CALL HILL(YDOT(1),YDOT(4),DGAMDX,DGAMDP,GIGJ(1,1,M1))
            CALL WILL(YDOT(7),YDOT(13),Y(7),Y(13),DGAMDX,DGAMDP,
     +                DGAMXX,DGAMXP,DGAMPX,DGAMPP,GIGJ(1,1,M1),
     +                GIDGJX,GIDGJP)
         ENDIF
      ELSE
C---     Tracing both of Q1x,P1x AND Q2x,P2x :
         IF (KOPT .EQ. 1) THEN
            CALL HILL(YDOT(1),YDOT(4),DGAMDX,DGAMDP,GIGJ(1,1,M1))
            CALL BILL(YDOT(7),YDOT(13),Y(7),Y(13),DGAMDX,DGAMDP,
     +                DGAMXX,DGAMXP,DGAMPX,DGAMPP,GIGJ(1,1,M1),
     +                GIDGJX,GIDGJP)
            CALL BILL(YDOT(19),YDOT(25),Y(19),Y(25),DGAMDX,DGAMDP,
     +                DGAMXX,DGAMXP,DGAMPX,DGAMPP,GIGJ(1,1,M1),
     +                GIDGJX,GIDGJP)
         ELSE
            CALL HILL(YDOT(1),YDOT(4),DGAMDX,DGAMDP,GIGJ(1,1,M1))
            CALL WILL(YDOT(7),YDOT(13),Y(7),Y(13),DGAMDX,DGAMDP,
     +                DGAMXX,DGAMXP,DGAMPX,DGAMPP,GIGJ(1,1,M1),
     +                GIDGJX,GIDGJP)
            CALL WILL(YDOT(19),YDOT(25),Y(19),Y(25),DGAMDX,DGAMDP,
     +                DGAMXX,DGAMXP,DGAMPX,DGAMPP,GIGJ(1,1,M1),
     +                GIDGJX,GIDGJP)
         ENDIF
      ENDIF

c$$$      WRITE(6,*) 'DYNDER: NDIM = ',NDIM
c$$$      WRITE(6,*) ' + Y   ( 1: 6) = ',(Y   (I),I= 1, 6)
c$$$      WRITE(6,*) ' + Y   ( 7:12) = ',(Y   (I),I= 7,12)
c$$$      WRITE(6,*) ' + Y   (13:18) = ',(Y   (I),I=13,18)
c$$$      WRITE(6,*) ' + YDOT( 1: 6) = ',(YDOT(I),I= 1, 6)
c$$$      WRITE(6,*) ' + YDOT( 7:12) = ',(YDOT(I),I= 7,12)
c$$$      WRITE(6,*) ' + YDOT(13:18) = ',(YDOT(I),I=13,18)
 
C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE DYNDER
C-----------------------------------------------------------------------




