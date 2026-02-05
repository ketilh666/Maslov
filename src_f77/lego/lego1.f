      PROGRAM LEGO1

      IMPLICIT   NONE

C---  Parameters: 
      INCLUDE '../include_files/ray_control.inc'
      INCLUDE '../include_files/io_pars.inc'
      INCLUDE '../include_files/geo_model.inc'
      INTEGER    NP,NDERIV
      INTEGER    NX,NY,NZ,NELK
      PARAMETER (NX=10,NY=10,NZ=10,NELK=5)
      PARAMETER (NP    =3)
      PARAMETER (NDERIV=1)

      REAL*8     X(3),P(3),VNORM(3)   ! Position, slowness and phase dir
      REAL*8     VPHASE(3)            ! Phase velocities
c$$$      REAL*8     CIJ  (6,6    )       ! Voigt matrix
c$$$      REAL*8     DCIJ (6,6,3  )       ! 1st derivatives of Voigt matrix
c$$$      REAL*8     DDCIJ(6,6,3,3)       ! 2nd derivatives of Voigt matrix
      REAL*8     AA   (3,3,3,3    )   ! Density norm. moduli at (x,y,z)
      REAL*8     DADI (3,3,3,3,3  )   ! 1st deriv. of moduli w.r.t (x,y,z) 
      REAL*8     DADIJ(3,3,3,3,3,3)   ! 2nd deriv. of moduli w.r.t (x,y,z) 
      REAL*8     GAM0(3,3),GAM(3,3)   ! Christoffel tensor
      REAL*8     DGAMDX(3,3,3  )      ! 1st deriv. of GAM w.r.t. position
      REAL*8     DGAMDP(3,3,3  )      ! 1st deriv. of GAM w.r.t. slowness
      REAL*8     DGAMXX(3,3,3,3)      ! 2nd deriv. of GAM w.r.t. position
      REAL*8     DGAMPP(3,3,3,3)      ! 2nd deriv. of GAM w.r.t. slowness
      REAL*8     DGAMXP(3,3,3,3)      ! Mixed 2nd deriv. og GAM
      REAL*8     GN0(3),GN(3)         ! Eigen values of the Christoffel tensor
      REAL*8     GVEC0(3,3),GVEC(3,3) ! Eigen vectors of the Christoffel tensor
      REAL*8     TRD(3)               ! Trace of cofactor matrix
      REAL*8     GIGJ(3,3,3)          ! Product of polariz. vect. DIJ/TRD
      REAL*8     XDOT(3),PDOT(3)
      REAL*8     RN
      LOGICAL    LDEGEN               ! Degenerate eigenvalues for qS1 and qS2?
      INTEGER    NMODE,KMODE(3)
      INTEGER    M1,M2,M3
      INTEGER    I,J,K,L,M,N
      INTEGER    KEVIN,KASINO
      INTEGER    LUT

C###  NOTE: The elastic model is REAL*4:
      REAL*4     DXGRI4(3),X0GRI4(3)
      REAL*4     ELK4(NX,NY,NZ,NELK)   
      INTEGER    NPOLX,NPOLY,NPOLZ     ! Degree of interpolating polynomial
      INTEGER    NPXYZ                 ! NPXYZ=MAX(NPOLX,NPOLY,NPOLZ)
      REAL*4     CA4(MAXPOL+1,3)       ! Precomputed array for interpolation
      REAL*4     DA4(MAXPOL+1,3)       ! Precomputed array for interpolation 

      CHARACTER*50 CSEP

C-----------------------------------------------------------------
C  User defined parameters
C-----------------------------------------------------------------

      X(1)     = 1000.0
      X(2)     = 1000.0
      X(3)     =    0.0

      VNORM(1) = 1.0
      VNORM(2) = 0.0
      VNORM(3) = 1.0

      NMODE    = 3

      KMODE(1) = K_QP
      KMODE(2) = K_QS1
      KMODE(3) = K_QS2

      LUT      = 11

C-----------------------------------------------------------------
C  Open output file
C-----------------------------------------------------------------

      IF(LUT.NE.6) OPEN(LUT,FILE='LEGO1.ascii',FORM='FORMATTED')
      
      CSEP = '=================================================='
      WRITE(LUT,1) CSEP

C-----------------------------------------------------------------
C  Normalize phase direction
C-----------------------------------------------------------------

      RN = 0.0
      DO J=1,3
         RN = RN + VNORM(J)*VNORM(J)
      ENDDO
      RN = SQRT(RN)

      DO J=1,3
         VNORM(J) = VNORM(J)/RN
      ENDDO

C-----------------------------------------------------------------
C   Geo model 
C-----------------------------------------------------------------

      CALL DRHOOK(AA,DADI,DADIJ,NDERIV,X,KASINO,
     +            ELK4,NX,NY,NZ,NELK,DXGRI4,X0GRI4,
     +            NPOLX,NPOLY,NPOLZ,CA4,DA4,NPXYZ)

C-----------------------------------------------------------------
C   Cristoffel equation #1: Phase direction
C-----------------------------------------------------------------

      CALL CHRIST(GAM0,DGAMDX,DGAMDP,DGAMXX,DGAMPP,DGAMXP,
     +            NDERIV,AA,DADI,DADIJ,VNORM)
      CALL BRUTUS(GN0,GVEC0,GAM0,LDEGEN)

      DO J=1,3
         VPHASE(J) = SQRT(GN0(J))
      ENDDO
 
      WRITE(LUT,1) 'Christoffel equation #1: Phase direction '
      WRITE(LUT,5) ' * Wave modes: KMODE = ',(KMODE(I),I=1,3)
      WRITE(LUT,4) ' * Eigen vals: VFASE = ',(VPHASE(I),I=1,3)
      DO J=1,3
         WRITE(LUT,2) ' * Number : ',J
         WRITE(LUT,4) '   + Eigen vector : ',(GVEC0(I,J),I=1,3)
      ENDDO
      WRITE(LUT,1) CSEP

C-----------------------------------------------------------------
C   Christoffel equation #2: Slowness
C-----------------------------------------------------------------

      M1 = KMODE(1)
      DO J=1,3
         P(J) = VNORM(J)/VPHASE(M1)
      ENDDO

      CALL CHRIST(GAM,DGAMDX,DGAMDP,DGAMXX,DGAMPP,DGAMXP,
     +            NDERIV,AA,DADI,DADIJ,P)
      CALL BRUTUS(GN,GVEC,GAM,LDEGEN)

      WRITE(LUT,1) 'Christoffel equation #2: Slowness'
      WRITE(LUT,5) ' * Wave modes: KMODE = ',(KMODE(I),I=1,3)
      WRITE(LUT,4) ' * Eigen vals: GN    = ',(GN(I),I=1,3)
      DO J=1,3
         WRITE(LUT,2) ' * Number : ',J
         WRITE(LUT,4) '   + Eigen vector : ',(GVEC(I,J),I=1,3)
      ENDDO
      WRITE(LUT,1) CSEP

C-----------------------------------------------------------------
C     Product of eigenvectors #1: KEVIN=KBRUT  
C-----------------------------------------------------------------

      KEVIN = KBRUT
      M1    = KMODE(1)
      CALL MESIAS(GIGJ,TRD,GVEC,GN,GAM,KEVIN,KMODE,NMODE,LDEGEN)

      WRITE(LUT,1) 'Product of eigenvectors #1: KEVIN=KBRUT'
      WRITE(LUT,5) ' * Wave modes: KMODE = ',(KMODE(I),I=1,3)
      WRITE(LUT,4) ' * Eigen vals: GN    = ',(GN(I),I=1,3)
      DO J=1,3
         WRITE(LUT,2) ' * Number : ',J
         WRITE(LUT,4) '   + Product GIGJ : ',(GIGJ(I,J,M1),I=1,3)
      ENDDO
      WRITE(LUT,1) CSEP

C-----------------------------------------------------------------
C     Derivatives #1: HILL, KEVIN=KBRUT
C-----------------------------------------------------------------

      CALL HILL(XDOT,PDOT,DGAMDX,DGAMDP,GIGJ(1,1,M1))
      WRITE(LUT,1) 'Derivatives #1: HILL, KEVIN=KBRUT'
      WRITE(LUT,4) '   + Derivative XDOT : ',(XDOT(I),I=1,3)
      WRITE(LUT,4) '   + Derivative PDOT : ',(PDOT(I),I=1,3)
      WRITE(LUT,1) CSEP
      
C-----------------------------------------------------------------
C     Product of eigenvectors #1: KEVIN=KFAST  
C-----------------------------------------------------------------

      KEVIN = KFAST
      M1    = KMODE(1)
      CALL CAESAR(GN,GAM,KMODE,NMODE,LDEGEN)
      CALL MESIAS(GIGJ,TRD,GVEC,GN,GAM,KEVIN,KMODE,NMODE,LDEGEN)

      WRITE(LUT,1) 'Product of eigenvectors #1: KEVIN=KFAST'
      WRITE(LUT,5) ' * Wave modes: KMODE = ',(KMODE(I),I=1,3)
      WRITE(LUT,4) ' * Eigen vals: GN    = ',(GN(I),I=1,3)
      DO J=1,3
         WRITE(LUT,2) ' * Number : ',J
         WRITE(LUT,4) '   + Product GIGJ : ',(GIGJ(I,J,M1),I=1,3)
      ENDDO
      WRITE(LUT,1) CSEP

C-----------------------------------------------------------------
C     Derivatives #2: HILL, KEVIN=KFAST
C-----------------------------------------------------------------

      CALL HILL(XDOT,PDOT,DGAMDX,DGAMDP,GIGJ(1,1,M1))
      WRITE(LUT,1) 'Derivatives #2: HILL, KEVIN=KFAST'
      WRITE(LUT,4) '   + Derivative XDOT : ',(XDOT(I),I=1,3)
      WRITE(LUT,4) '   + Derivative PDOT : ',(PDOT(I),I=1,3)
      WRITE(LUT,1) CSEP
      
C-----------------------------------------------------------------
C     Derivatives #3: vsurfd
C-----------------------------------------------------------------

c$$$      CALL vsurfd(aa,dadi,p,xdot,pdot)
c$$$      WRITE(LUT,1) 'Derivatives #2: VSURFD'
c$$$      WRITE(LUT,4) '   + Derivative XDOT : ',(XDOT(I),I=1,3)
c$$$      WRITE(LUT,4) '   + Derivative PDOT : ',(PDOT(I),I=1,3)
c$$$      WRITE(LUT,1) CSEP

C-----------------------------------------------------------------
C   Close output file
C-----------------------------------------------------------------

      IF (LUT.NE.6) CLOSE(LUT)



 1    FORMAT(A)
 2    FORMAT(A,I4)
 3    FORMAT(A,F8.2)
 4    FORMAT(A,3F8.2)
 5    FORMAT(A,3I3)

C-----------------------------------------------------------------
      END
C-----------------------------------------------------------------
