C************************************************************************
C
C SUBROUTINE RKQS
C
C PURPOSE: Take one equality controlled Runge-Kutta step.
C          Computations are performed in double precision (REAL*8).
C          Gridded model are in single precission to save memory.
C 
C ERROR CONDITIONS:
C          IERR = 0 : successful execution of routine
C          IERR = 6 : Stepsize underflow encountered
C
C REFERENCE: Adapted from the subroutine RKQS in
C            Numerical Receipes, Chapter 16.2    
C
C
C SUBROUTINES CALLED : RKCK
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE RKQS(Y,YDOT,N,T,HTRY,ACCUR,YSCAL,IE1,IE2,HDID,
     +                HNEXT,GVEC,GN,KEVIN,KMODE,KASINO,ELK4,NX,NY,NZ,
     +                NELK,DXGRI4,X0GRI4,NPOLX,NPOLY,NPOLZ,CA4,DA4,
     +                NPXYZ,IERR,RAIDER)

      IMPLICIT NONE

C---  External variables:
      INTEGER    N                   ! Dimension of the raytracing system
      INTEGER    IE1,IE2             ! First/last element in error estim.
      INTEGER    IERR                ! Error flag. IERR=0 on normal return.
      REAL*8     HTRY,HDID,HNEXT     ! Steplengths (1st try, used, next)
      REAL*8     T                   ! Parameter along the ray 
      REAL*8     Y(N)                ! The ray in phase space (x_i,p_i)
      REAL*8     YDOT(N)             ! Derivative of Y w.r.t. T
      REAL*8     YSCAL(N)            ! Scaling factor for accuracy
      REAL*8     ACCUR               ! Required accuracy of the solution
      REAL*8     GVEC(3,3),GN(3)     ! Eigen vectors/values of Christ.
      INTEGER    KEVIN               ! How to solve Christoffel equation?
      INTEGER    KMODE(3)            ! Current wave mode in KMODE(1)
      INTEGER    KASINO              ! Anisotropic symmetry type
C###  NOTE: The elastic model is REAL*4:
      INTEGER    NX,NY,NZ            ! Size of elastic grid model
      INTEGER    NELK                ! No of independent elastic moduli
      REAL*4     ELK4(NX,NY,NZ,NELK) ! Density norm. moduli on a grid
      REAL*4     DXGRI4(3)           ! (x,y,z) steplength in moduli
      REAL*4     X0GRI4(3)           ! (x,y,z) coord. of ELK(1,1,1,*)
      INTEGER    NPOLX,NPOLY,NPOLZ   ! Degree of interpolating polynomial
      INTEGER    NPXYZ               ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4     CA4(NPXYZ+1,3)      ! Precomputed array for interpolation
      REAL*4     DA4(NPXYZ+1,3)      ! Precomputed array for interpolation 

C---  External subroutines:
      EXTERNAL   RAIDER              ! Subroutine passed to RKCK

C---  Parameters:
      INCLUDE '../include_files/runge_kutta.inc'
      REAL*8     ERRCON,SAFETY
      REAL*8     PGROW,PSHRNK
      PARAMETER (SAFETY= 0.9  )
      PARAMETER (PGROW =-0.2  )
      PARAMETER (PSHRNK=-0.25 )
      PARAMETER (ERRCON= 1.89e-4)    ! ERRCON=(5.0/SAFETY)**(1.0/PGROW)

C---  Internal variables:
      INTEGER    I
      REAL*8     YERR(NMAX),YTEMP(NMAX)
      REAL*8     ERRMAX
      REAL*8     H,HTMP
      REAL*8     TNEW

C-----------------------------------------------------------------------
C  Initialization
C-----------------------------------------------------------------------

      IERR = 0
      H    = HTRY

C-----------------------------------------------------------------------
C  Perform a basic Cash-Karp Runge-Kutta step with step size H
C-----------------------------------------------------------------------

 1    CALL RKCK(Y,YDOT,N,T,H,YTEMP,YERR,GVEC,GN,KEVIN,KMODE,
     +          KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +          NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,RAIDER)

C#############################
C  No adaptiv steplength: 
C#############################

      HDID  = H
      HNEXT = H
      T     = T+H
      DO I=1,N
         Y(I) = YTEMP(I)
      ENDDO
      RETURN  

C-----------------------------------------------------------------------
C  Evaluate accuracy: Using only elements IE1 to IE2 are used in test
C-----------------------------------------------------------------------

      ERRMAX = 0.0
      DO I=IE1,IE2
         ERRMAX = MAX(ERRMAX,ABS(YERR(I)/YSCAL(I)))
      ENDDO
      ERRMAX=ERRMAX/ACCUR

C-----------------------------------------------------------------------
C  Check truncation error and reduce stepsize when necessary
C-----------------------------------------------------------------------

      IF(ERRMAX .GT. 1.0) THEN
C---     Error to large:
         HTMP = SAFETY*H*(ERRMAX**PSHRNK)
         H    = SIGN(MAX(ABS(HTMP),0.1*ABS(H)),H)
         TNEW = T+H
         IF (TNEW .EQ. T) IERR=6
         GOTO 1                    ! Trying once more
      ELSE
C---     Success. Compute next stepsize:
         IF(ERRMAX.GT.ERRCON) THEN
            HNEXT = SAFETY*H*(ERRMAX**PGROW)
         ELSE
C            HNEXT = 5.0*H          ! No more than factor 5.0 in increase.
            HNEXT = 2.0*H          ! No more than factor 2.0 in increase.
         ENDIF
         HDID = H
         T    = T+H
         DO I=1,N
            Y(I) = YTEMP(I)
         ENDDO
         RETURN
      ENDIF

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE RKQS
C-----------------------------------------------------------------------










