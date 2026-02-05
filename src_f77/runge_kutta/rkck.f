C************************************************************************
C
C SUBROUTINE RKCK
C
C PURPOSE: Take one Cash-Carp Runge-Kutta step
C          Derivatives are computed by the external routine RAIDER,
C          the specific name of which is passed as an argument.
C          Computations are performed in double precision (REAL*8).
C          Gridded model are in single precission to save memory.
C            
C REFERENCE: Adapted from the subroutine RKCK in
C            Numerical Receipes, Chapter 16.2    
C
C SUBROUTINES CALLED : RAIDER (That is KINDER or DYNDER)
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE RKCK(Y,YDOT,N,T,H,YOUT,YERR,GVEC,GN,KEVIN,KMODE,
     +                KASINO,ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +                NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ,RAIDER)

      IMPLICIT NONE

C---  External variables:
      INTEGER    N                   ! Dimension of the raytracing system
      REAL*8     T                   ! Parameter along the ray 
      REAL*8     H                   ! Steplengths (1st try, used, next)
      REAL*8     Y(N)                ! Known Y at T
      REAL*8     YDOT(N)             ! Derivative of Y w.r.t. T
      REAL*8     YOUT(N)             ! Computed new Y-values
      REAL*8     YERR(N)             ! Scaling factor for accuracy
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
      EXTERNAL   RAIDER              ! Subroutine computing derivatives

C---  Parameters:
      INCLUDE '../include_files/runge_kutta.inc'

      REAL*8     A2,A3,A4,A5,A6
      REAL*8     B21,B31,B32,B41,B42,B43,
     +           B51,B52,B53,B54,B61,B62,B63,B64,B65
      REAL*8     C1,C3,C4,C6
      REAL*8     DC1,DC3,DC4,DC5,DC6
      PARAMETER (A2=0.2, A3=0.3, A4=0.6, A5=1.0, A6=0.875)
      PARAMETER (B21= 0.2              , 
     +           B31= 3.0/40.0         , B32= 9.0/40.0   , 
     +           B41= 0.3              , B42=-0.9        , B43=1.2 , 
     +           B51=-11.0/54.0        , B52= 2.5        ,   
     +           B53=-70.0/27.0        , B54= 35.0/27.0  , 
     +           B61= 1631.0/55296.0   , B62= 175.0/512.0, 
     +           B63= 575.0/13824.0    ,
     +           B64= 44275.0/110592.0 , B65=253.0/4096.0   )
      PARAMETER (C1 = 37.0/378.0       , C3=250.0/621.0  , 
     +           C4 = 125.0/594.0      , C6=512.0/1771.0    )
      PARAMETER (DC1=C1-2825.0/27648.0 , DC3=C3-18575.0/48384.0,
     +           DC4=C4-13525.0/55296.0, DC5=-277.0/14336.0,DC6=C6-0.25)

C---  Internal variables:
      INTEGER    I
      REAL*8     AK2(NMAX),AK3(NMAX),AK4(NMAX),AK5(NMAX),AK6(NMAX)
      REAL*8     YTEMP(NMAX)

C-----------------------------------------------------------------------
C  First step
C-----------------------------------------------------------------------

      DO I=1,N
         YTEMP(I) = Y(I) + B21*H*YDOT(I)
      ENDDO

C-----------------------------------------------------------------------
C  Second step
C-----------------------------------------------------------------------

      CALL RAIDER(AK2,YTEMP,N,GVEC,GN,KEVIN,KMODE,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)
      
      DO I=1,N
         YTEMP(I) = Y(I) + H*( B31*YDOT(I) + B32*AK2(I)  )
      ENDDO

C-----------------------------------------------------------------------
C  Third step
C-----------------------------------------------------------------------

      CALL RAIDER(AK3,YTEMP,N,GVEC,GN,KEVIN,KMODE,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)
      
      DO I=1,N
         YTEMP(I) = Y(I) + H*( B41*YDOT(I) +B42*AK2(I) +
     +                         B43*AK3(I)                )
      ENDDO

C-----------------------------------------------------------------------
C  Fourth step
C-----------------------------------------------------------------------

      CALL RAIDER(AK4,YTEMP,N,GVEC,GN,KEVIN,KMODE,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)
      
      DO I=1,N
         YTEMP(I) = Y(I) + H*( B51*YDOT(I) + B52*AK2(I) +
     +                         B53*AK3(I)  + B54*AK4(I)   )
      ENDDO

C-----------------------------------------------------------------------
C  Fifth step
C-----------------------------------------------------------------------

      CALL RAIDER(AK5,YTEMP,N,GVEC,GN,KEVIN,KMODE,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)
      
      DO I=1,N
         YTEMP(I) = Y(I) + H*( B61*YDOT(I) + B62*AK2(I) +
     +                         B63*AK3(I)  + B64*AK4(I) +
     +                         B65*AK5(I)                 )
      ENDDO

C-----------------------------------------------------------------------
C  Sixth step: Accumulate increments with proper weights.
C-----------------------------------------------------------------------

      CALL RAIDER(AK6,YTEMP,N,GVEC,GN,KEVIN,KMODE,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)
      
      DO I=1,N
         YOUT(I) = Y(I) + H*( C1*YDOT(I) + C3*AK3(I) +
     +                        C4*AK4(I)  + C6*AK6(I)   )
      ENDDO

C-----------------------------------------------------------------------
C  Estimate error as the difference between 4th and 5th order methods
C-----------------------------------------------------------------------

      DO I=1,N
         YERR(I)  = H*( DC1*YDOT(I) + DC3*AK3(I) + 
     +                  DC4*AK4(I)  + DC5*AK5(I) + DC6*AK6(I) )
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END 
C-----------------------------------------------------------------------
C    END OF SUBROUTINE RKCK
C-----------------------------------------------------------------------


