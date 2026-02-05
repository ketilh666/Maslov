C************************************************************************
C
C SUBROUTINE KININT
C
C PURPOSE: Trace a ray with given initial cordinates and
C          slowness by the Runge-Kutta method.
C
C NOTE   : Geological model on grid (ELK4) is REAL*4
C
C ERROR CONDITIONS:
C          IERR = 0 : Successful execution of routine
C          IERR = 1 : Max number of iterations reached.
C          IERR = 2 : Steplength becomes too small (less than HMIN)
C          IERR = 3 : Arrays too small to store all data up to T=T1
C            
C REFERENCE: Adapted from the subroutine ODEINT in
C            Numerical Receipes, Chapter 16.2    
C
C
C SUBROUTINES CALLED : KINDER, RKCK, STKIN
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER  1998
C                      KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE KININT(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                  MAXEL,X0,P0,T0,T1,DTSAVE,KEVIN,KMODE,KASINO,
     +                  ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                  NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,
     +                  ACCUR,H0,HMIN,NGOD,NBAD,IERR)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     X0(3),P0(3)         ! Initial positiona and slowness
      REAL*8     T0,T1               ! Initial and max traveltime
      REAL*8     DTSAVE              ! Intervall for saving raypath
      REAL*8     H0,HMIN             ! Initial and minimum steplength
      REAL*8     ACCUR               ! Required accuracy
      INTEGER    KEVIN               ! How to solve Christoffel eq?
      INTEGER    KMODE(3)            ! Current wave mode in KMODE(1)
      INTEGER    MAXEL               ! Max no of ray elements stored.
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
      REAL*8     TRAY (  MAXEL)      ! Stored Ray traveltime
      REAL*8     XRAY (3,MAXEL)      ! Stored Ray positions
      REAL*8     PRAY (3,MAXEL)      ! Stored Ray slowness
      REAL*8     VGRAY(3,MAXEL)      ! Stored Ray group velocity
      REAL*8     ETRAY(3,MAXEL)      ! Stored Ray derivative of slowness
      REAL*8     GNRAY(3,MAXEL)      ! Stored Ray eigenvalues. (no sqrt)
      REAL*8     GVRAY(3,3,MAXEL)    ! Stored Ray eigenvectors (polariz)
      INTEGER    NRAYEL              ! Number of rayelements (computed).
      INTEGER    NGOD,NBAD           ! No of good and bad (fixed) steps
      INTEGER    IERR                ! Error flag. IERR=0 if no error.

C---  External subroutines:
      EXTERNAL   KINDER              ! Passed to subroutine RKQS

C---  Parameters:
      INCLUDE '../include_files/runge_kutta.inc'
      INCLUDE '../include_files/ray_control.inc'
      REAL*8     TINY
      PARAMETER (TINY=1.0e-15)       ! A small number

C---  Internal variables:
      LOGICAL   LEXIT
      INTEGER   M1,I,ISTEP           ! Loop counters
      REAL*8    H,HNEXT,HDID         ! Current steplength
      REAL*8    T                    ! Traveltime along the ray
      REAL*8    TSAVE                ! Last saved time step
      REAL*8    Y(NKIN)              ! Phase space coord. (x_i,p_i)
      REAL*8    YDOT(NKIN)           ! Derivative of Y w.r.t. T
      REAL*8    YSCAL(NKIN)          ! Scale factors
      REAL*8    GN(3),GVEC(3,3)      ! Eigen values/vectors of Christ.

C*************** DEBUGGING *************************
c$$$      WRITE(6,*) 'SUBROUTINE KININT:'
c$$$      WRITE(6,*) '   + KMODE    = ',(KMODE(I),I=1,3)
c$$$      WRITE(6,*) '   + MAXEL    = ',MAXEL
c$$$      WRITE(6,*) '   + T0,T1    = ',T0,T1
c$$$      WRITE(6,*) '   + X0_i     = ',(X0(I),I=1,3)
c$$$      WRITE(6,*) '   + DTSAVE   = ',DTSAVE
c$$$      WRITE(6,*) '   + ACCUR    = ',ACCUR
c$$$      WRITE(6,*) '   + H0,HMIN  = ',H0,HMIN
C***************************************************
C-----------------------------------------------------------------------
C   Initialize phase space and Runge-Kutta variables 
C-----------------------------------------------------------------------

C---  Traveltime along the ray:
      T = T0

C---  Kinetic raytracing system:
      DO I=1,3
         Y(I)   = X0(I)
         Y(I+3) = P0(I)
      ENDDO

C---  Eigenvalues of the Christoffel equation:
      GN(KMODE(1)) = 1.0d0
      GN(KMODE(2)) = 3.14d0**2
      GN(KMODE(3)) = 3.14d0**2

C---  Steplength:
      HNEXT  = SIGN(H0,T1-T0)

C---  Number of good and bad (but fixed) steps:
      NGOD   = 0
      NBAD   = 0

C---  Number of ray elements:
      NRAYEL = 0

C---  Error flag:
      IERR   = 0

C-----------------------------------------------------------------------
C   RUNGE-KUTTA ITERATION : Number of steps is unknown
C-----------------------------------------------------------------------

C---  Loop over rayelements:
      DO ISTEP=1,MXSTEP

CUT         WRITE(6,*) '### KINIT: START STEP ',ISTEP

C---     Steplength for current Runge-Kutta step:
         H = HNEXT
         IF ((T+H-T1)*(T+H-T0) .GT. 0.0) H = T1-T + HMIN

C---     Compute derivatives of ray position and slowness w.r.t. T:
         CALL KINDER(YDOT,Y,NKIN,GVEC,GN,KBRUT,KMODE,KASINO,
     +               ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +               NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)

C---     Store ray position and slowness at current T?
         CALL STKIN(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GVRAY,GNRAY,
     +              MAXEL,Y,YDOT,NKIN,GVEC,GN,T,TSAVE,DTSAVE)

C---     Compute scale factors used to monitor accuracy  
         DO I=1,NKIN
            YSCAL(I) = ABS(Y(I)) + ABS(H*YDOT(I)) + TINY
         ENDDO

C---     Take one quality controlled Runge-Kutta step:
         CALL RKQS(Y,YDOT,NKIN,T,H,ACCUR,YSCAL,1,3,HDID,
     +             HNEXT,GVEC,GN,KEVIN,KMODE,KASINO,ELK4,NX,NY,NZ,
     +             NELK,DXGRI4,X0GRI4,NPOLX,NPOLY,NPOLZ,CA4,DA4,
     +             NPXYZ,IERR,KINDER)

C---     Check for success:
         IF (HDID .EQ. H) THEN
            NGOD = NGOD+1
         ELSE
            NBAD = NBAD+1
         ENDIF

C---     Check for error conditions:
         IF (ISTEP  .EQ. MXSTEP ) IERR=1  ! Maximum number of steps
         IF (HNEXT  .LT. HMIN   ) IERR=2  ! Steplength too small
         IF (NRAYEL .EQ. MAXEL-1) IERR=3  ! Data will be lost

C---     One more step?
         LEXIT = ((T-T1)*(T1-T0) .GE. 0.0) .OR. IERR.NE.0
         IF (LEXIT) GOTO 100 ! EXIT

C---  End of iteration loop:
      ENDDO

 100  CONTINUE

C---  Store last element:
      CALL STKIN(NRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GVRAY,GNRAY,
     +           MAXEL,Y,YDOT,NKIN,GVEC,GN,T,TSAVE,DTSAVE)

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE KININT
C-----------------------------------------------------------------------


C************************************************************************
C
C SUBROUTINE STKIN
C
C PURPOSE: Store kinetic raytracing data to output arrays.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY  1998
C
C************************************************************************

      SUBROUTINE STKIN(IRAYEL,TRAY,XRAY,PRAY,VGRAY,ETRAY,GVRAY,GNRAY,
     +                 MAXEL,Y,YDOT,N,GVEC,GN,T,TSAVE,DTSAVE)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  N,MAXEL             ! Max no of ray elements stored.
      REAL*8   Y(N),YDOT(N)        ! Phase space coord. (x_i,p_i)
      REAL*8   GN(3),GVEC(3,3)     ! Eigen values/vectors of Christ.
      REAL*8   T                   ! Traveltime along the ray
      REAL*8   DTSAVE              ! Intervall for saving raypath

C---  External output variables:
      INTEGER  IRAYEL              ! Number of stored rayelements
      REAL*8   TRAY (  MAXEL)      ! Stored Ray traveltime
      REAL*8   XRAY (3,MAXEL)      ! Stored Ray positions
      REAL*8   PRAY (3,MAXEL)      ! Stored Ray slowness
      REAL*8   VGRAY(3,MAXEL)      ! Stored Ray group velocity
      REAL*8   ETRAY(3,MAXEL)      ! Stored Ray derivative of slowness
      REAL*8   GNRAY(3,MAXEL)      ! Stored Ray eigenvalues. (no sqrt)
      REAL*8   GVRAY(3,3,MAXEL)    ! Stored Ray eigenvectors (polariz)
      REAL*8   TSAVE               ! Last saved time step
       
C---  Parameters:

C---  Internal variables:
      INTEGER  I,K

C-----------------------------------------------------------------------
C  Store kinetic raytracing data
C-----------------------------------------------------------------------

Cut   IF( ABS(T-TSAVE) .GE. ABS(DTSAVE) ) THEN

C---     Update rayelement counter:
         IRAYEL = IRAYEL+1
         K      = IRAYEL
         TSAVE  = T
         
C---     Store scalars:
         TRAY (  K) = T
         GNRAY(1,K) = GN(1)
         GNRAY(2,K) = GN(2)
         GNRAY(3,K) = GN(3)
C---     Store vectors:
         DO I=1,3
            XRAY (I  ,K) = Y(I)
            PRAY (I  ,K) = Y(I+3)
            VGRAY(I  ,K) = YDOT(I)
            ETRAY(I  ,K) = YDOT(I+3)
            GVRAY(I,1,K) = GVEC(I,1)
            GVRAY(I,2,K) = GVEC(I,2)
            GVRAY(I,3,K) = GVEC(I,3)
         ENDDO
         
Cut   ENDIF
      
C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE STKIN
C-----------------------------------------------------------------------
      
