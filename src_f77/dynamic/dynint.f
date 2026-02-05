C************************************************************************
C
C SUBROUTINE DYNINT
C
C PURPOSE: Perform dynamic raytracing of Q1x,P1x OR Q2x,P2x
C          for a known kinetic ray.
C
C NOTE   : Geological model on grid is REAL*4
C
C ERROR CONDITIONS:
C          IERR = 0 : Successful execution of routine
C          IERR = 1 : Max number of iterations reached.
C          IERR = 3 : Arrays too small to store all data up to T=T1
C            
C REFERENCE: Adapted from the subroutine ODEINT in
C            Numerical Receipes, Chapter 16.2    
C
C
C SUBROUTINES CALLED : DYNDER RKCK LDDYN STTDYN
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY   1999
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE DYNINT(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                  QXRAY,PXRAY,MAXEL,QX0,PX0,T0,T1,KEVIN,KMODE,
     +                  KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,IERR)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     QX0(3,2),PX0(3,2)   ! Initial QX and PX
      REAL*8     T0,T1               ! Initial and max traveltime
      INTEGER    KEVIN               ! How to solve Christoffel eq?
      INTEGER    KMODE(3)            ! Current wave mode in KMODE(1)
      INTEGER    MAXEL               ! Max no of ray elements stored.
      REAL*8     TRAY (  MAXEL)      ! Stored Ray traveltime
      REAL*8     XRAY (3,MAXEL)      ! Stored Ray positions
      REAL*8     PRAY (3,MAXEL)      ! Stored Ray slowness
      REAL*8     VGRAY(3,MAXEL)      ! Stored Ray group velocity
      REAL*8     ETRAY(3,MAXEL)      ! Stored Ray derivative of slowness
      REAL*8     GNRAY(3,MAXEL)      ! Stored Ray eigenvalues. (no sqrt)
      REAL*8     GVRAY(3,3,MAXEL)    ! Stored Ray eigenvectors (polariz)
      INTEGER    NRAYEL              ! Number of rayelements
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
      REAL*8     QXRAY(3,2)          ! Stored 3x2 matrix QXx (Cartesian)
      REAL*8     PXRAY(3,2)          ! Stored 3x2 matrix PXx (Cartesian)
      INTEGER    IERR                ! Error flag. IERR=0 if no error.

C---  External subroutines:
      EXTERNAL   DYNDER              ! Passed to subroutine RKQS

C---  Parameters:
      INCLUDE '../include_files/runge_kutta.inc'
      INCLUDE '../include_files/ray_control.inc'
      REAL*8     TINY
      PARAMETER (TINY=1.0e-15)       ! A small number

C---  Internal variables:
      LOGICAL   LEXIT
      INTEGER   I,J,K,K0,ISTEP       ! Loop counters
      REAL*8    H,HNEXT              ! Current steplength
      REAL*8    T                    ! Traveltime along the ray
      REAL*8    Y(NDYN)              ! Phase space coord. (x_i,p_i)
      REAL*8    YDOT(NDYN)           ! Derivative of Y w.r.t. T
      REAL*8    YJUNK(NDYN)          ! Not used
      REAL*8    GN(3),GVEC(3,3)      ! Eigen values/vectors of Christ.

C-----------------------------------------------------------------------
C   Initialize phase space and Runge-Kutta variables 
C-----------------------------------------------------------------------

C---  Dynamic raytracing system:
      K0 = NKIN
      K  = 0
      DO J=1,2
         DO I=1,3
            K = K+1
            Y(K0+K   ) = QX0(I,J)
            Y(K0+K+ 6) = PX0(I,J)
         ENDDO
      ENDDO

C---  Eigenvalues of the Christoffel equation:
      GN(KMODE(1)) = 1.0d0
      GN(KMODE(2)) = 3.14d0**2
      GN(KMODE(3)) = 3.14d0**2

C---  Error flag:
      IERR   = 0

C-----------------------------------------------------------------------
C   RUNGE-KUTTA ITERATION : Number of steps is known
C-----------------------------------------------------------------------

C---  Loop over rayelements:
      DO ISTEP=1,NRAYEL-1

C---     Get precomuted kinetic raytracing data:
         CALL LDDYN(ISTEP,Y,YDOT,NDYN,GVEC,GN,T,HNEXT,NRAYEL,
     +              TRAY,XRAY,PRAY,VGRAY,ETRAY,GVRAY,GNRAY,MAXEL)

C---     Compute derivatives of Qx and Px w.r.t. T:
         CALL DYNDER(YDOT,Y,NDYN,GVEC,GN,KBRUT,KMODE,KASINO,
     +               ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +               NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)

C---     Store ray position and slowness at current T?
         CALL STDYN(ISTEP,TRAY,QXRAY,PXRAY,NRAYEL,MAXEL,Y,YDOT,NDYN,T)

C---     Take one basic Runge-Kutta step:
         H = HNEXT
         CALL RKCK(Y,YDOT,NDYN,T,H,Y,YJUNK,GVEC,GN,KEVIN,KMODE,
     +             KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +             NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,DYNDER)

C---  End of iteration loop:
      ENDDO

C---  Store last element:
      CALL STDYN(NRAYEL,TRAY,QXRAY,PXRAY,NRAYEL,MAXEL,Y,YDOT,NDYN,T+H)

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE DYNINT
C-----------------------------------------------------------------------

C************************************************************************
C
C SUBROUTINE LDDYN
C
C PURPOSE: Store kinetic raytracing data to output arrays.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY  1998
C
C************************************************************************

      SUBROUTINE LDDYN(IRAYEL,Y,YDOT,N,GVEC,GN,T,TSTEP,NRAYEL,
     +                 TRAY,XRAY,PRAY,VGRAY,ETRAY,GVRAY,GNRAY,MAXEL)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  IRAYEL              ! Current Runge-Kutta step
      INTEGER  NRAYEL              ! Number of stored rayelements
      INTEGER  N,MAXEL             ! Max no of ray elements stored.
      REAL*8   TRAY (  MAXEL)      ! Stored Ray traveltime
      REAL*8   XRAY (3,MAXEL)      ! Stored Ray positions
      REAL*8   PRAY (3,MAXEL)      ! Stored Ray slowness
      REAL*8   VGRAY(3,MAXEL)      ! Stored Ray group velocity
      REAL*8   ETRAY(3,MAXEL)      ! Stored Ray derivative of slowness
      REAL*8   GNRAY(3,MAXEL)      ! Stored Ray eigenvalues. (no sqrt)
      REAL*8   GVRAY(3,3,MAXEL)    ! Stored Ray eigenvectors (polariz)
       
C---  External output variables:
      REAL*8   Y(N),YDOT(N)        ! Phase space coord. (x_i,p_i)
      REAL*8   GN(3),GVEC(3,3)     ! Eigen values/vectors of Christ.
      REAL*8   T,TSTEP             ! Current time step

C---  Parameters:

C---  Internal variables:
      INTEGER  I,J,K

C-----------------------------------------------------------------------
C  Load precomputed kinetic raytracing data
C-----------------------------------------------------------------------

C---  Rayelement:
      K = IRAYEL
      J = K
c$$$      J = MIN(K+1,NRAYEL) - 1
      
C---  Compute time increment:
      TSTEP = TRAY(J+1)-TRAY(J)
      
C---  Load scalars:
      T     = TRAY (  K)
      GN(1) = GNRAY(1,K)
      GN(2) = GNRAY(2,K)
      GN(3) = GNRAY(3,K)
C---  Load vectors:
      DO I=1,3
         Y   (I  ) = XRAY (I  ,K)
         Y   (I+3) = PRAY (I  ,K)
         YDOT(I  ) = VGRAY(I  ,K)
         YDOT(I+3) = ETRAY(I  ,K)
         GVEC(I,1) = GVRAY(I,1,K)
         GVEC(I,2) = GVRAY(I,2,K)
         GVEC(I,3) = GVRAY(I,3,K)
      ENDDO
      
C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE LDDYN
C-----------------------------------------------------------------------
      
C************************************************************************
C
C SUBROUTINE STDYN
C
C PURPOSE: Store dynamic raytracing data to output arrays.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY  1998
C
C************************************************************************

      SUBROUTINE STDYN(IRAYEL,TRAY,QXRAY,PXRAY,NRAYEL,MAXEL,Y,YDOT,N,T)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  IRAYEL              ! Current Runge-Kutta step
      INTEGER  NRAYEL              ! Number of stored rayelements
      INTEGER  N,MAXEL             ! Max no of ray elements stored.
      REAL*8   Y(N),YDOT(N)        ! Phase space coord. (x_i,p_i)
      REAL*8   T                   ! Current time step

C---  External output variables:
      REAL*8   TRAY (MAXEL)        ! Stored Ray traveltime
      REAL*8   QXRAY(3,2,MAXEL)    ! Stored 3x2 matrix Qx (Cartesian)
      REAL*8   PXRAY(3,2,MAXEL)    ! Stored 3x2 matrix Px (Cartesian)
       
C---  Parameters:
      INCLUDE '../include_files/runge_kutta.inc'

C---  Internal variables:
      INTEGER  I,J,K,L,L0
      
C-----------------------------------------------------------------------
C  Store kinetic raytracing data
C-----------------------------------------------------------------------

         K = IRAYEL
         
C---     Store scalars:
C---     Store vectors:
C---     Store tensors:
         L0 = NKIN
         L  = 0
         DO J=1,2
            DO I=1,3
               L = L+1
               QXRAY(I,J,K) = Y(L0+L   )
               PXRAY(I,J,K) = Y(L0+L+ 6)
            ENDDO
         ENDDO

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE STDYN
C-----------------------------------------------------------------------
      
