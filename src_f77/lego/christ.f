C************************************************************************
C
C SUBROUTINE CHRIST
C
C PURPOSE: Compute the Christoffel matrix and 1st and 2nd 
C          drivativs w.r.t. position and slowness.
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : CHRIS0 CHRIS1 CHRIS2
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE CHRIST(GAM,DGAMDX,DGAMDP,DGAMXX,DGAMPP,
     +                  DGAMXP,DGAMPX,NDERIV,AA,DADI,DADIJ,P)

      IMPLICIT NONE

C---  External input variables:
      INTEGER    NDERIV             ! Highest order of deriv. (0/1/2)
      REAL*8     P(3)               ! Slowness or phase direction
      REAL*8     AA   (3,3,3,3    ) ! Density norm. moduli at (x,y,z)
      REAL*8     DADI (3,3,3,3,3  ) ! 1st deriv. of moduli w.r.t. (x,y,z) 
      REAL*8     DADIJ(3,3,3,3,3,3) ! 2nd deriv. of moduli w.r.t. (x,y,z) 

C---  External output variables:
      REAL*8     GAM   (3,3    )    ! Christoffel tensor
      REAL*8     DGAMDX(3,3,3  )    ! 1st deriv. of GAM w.r.t. position
      REAL*8     DGAMDP(3,3,3  )    ! 1st deriv. of GAM w.r.t. slowness
      REAL*8     DGAMXX(3,3,3,3)    ! 2nd deriv. of GAM w.r.t. position
      REAL*8     DGAMPP(3,3,3,3)    ! 2nd deriv. of GAM w.r.t. slowness
      REAL*8     DGAMXP(3,3,3,3)    ! Mixed 2nd deriv. of GAM (X 1st)
      REAL*8     DGAMPX(3,3,3,3)    ! Mixed 2nd deriv. of GAM (P 1st)

C-----------------------------------------------------------------------
C  Compute Christoffel tensor and derivatives 
C-----------------------------------------------------------------------

      IF    (NDERIV.EQ.0) THEN
         CALL CHRIS0(GAM,AA,P)
      ELSEIF(NDERIV.EQ.1) THEN
         CALL CHRIS0(GAM,AA,P)
         CALL CHRIS1(DGAMDX,DGAMDP,AA,DADI,P)
      ELSEIF(NDERIV.EQ.2) THEN
         CALL CHRIS0(GAM,AA,P)
         CALL CHRIS1(DGAMDX,DGAMDP,AA,DADI,P)
         CALL CHRIS2(DGAMXX,DGAMPP,DGAMXP,DGAMPX,AA,DADI,DADIJ,P)
      ENDIF

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CHRIST
C-----------------------------------------------------------------------

C************************************************************************
C
C SUBROUTINE CHRIS0
C
C PURPOSE: Compute the Christoffel matrix.
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE CHRIS0(GAM,AA,P)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     P(3)               ! Slowness or phase direction
      REAL*8     AA   (3,3,3,3)     ! Density norm. moduli at (x,y,z)


C---  External output variables:
      REAL*8     GAM   (3,3)        ! Christoffel tensor

C---  Internal variables:
      INTEGER    I,J,K,L

C-----------------------------------------------------------------------
C  Compute Christoffel tensor, Cerveny equation (2.2.21)
C-----------------------------------------------------------------------

      DO K=1,3
         DO I=1,3
            GAM(I,K) = 0.0
            DO L=1,3
               DO J=1,3
                  GAM(I,K) = GAM(I,K) + P(J)*P(L)*AA(I,J,K,L)
               ENDDO
            ENDDO
         ENDDO
      ENDDO
      
C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CHRIS0
C-----------------------------------------------------------------------

C************************************************************************
C
C SUBROUTINE CHRIS1
C
C PURPOSE: Compute the 1st derivatives of the Christoffel tensor 
C          w.r.t. position and slowness (phase direction).
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE CHRIS1(DGAMDX,DGAMDP,AA,DADI,P)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     P(3)               ! Slowness or phase direction
      REAL*8     AA   (3,3,3,3  )   ! Density norm. moduli at (x,y,z)
      REAL*8     DADI (3,3,3,3,3)   ! 1st deriv. of moduli w.r.t. (x,y,z) 


C---  External output variables:
      REAL*8     DGAMDX(3,3,3)      ! 1st deriv. of GAM w.r.t. position
      REAL*8     DGAMDP(3,3,3)      ! 1st deriv. of GAM w.r.t. slowness

C---  Internal variables:
      INTEGER    I,J,K,L,N

C-----------------------------------------------------------------------
C  Compute 1st derivative of Christoffel tensor w.r.t. position and
C  slowness (phase direction) Cerveny equation (4.14.8)
C-----------------------------------------------------------------------

C---  1st derivative w.r.t. position:
      DO N=1,3
         DO K=1,3
            DO I=1,3
               DGAMDX(I,K,N) = 0.0
               DO L=1,3
                  DO J=1,3
                     DGAMDX(I,K,N) = DGAMDX(I,K,N) + 
     +                               P(J)*P(L)*DADI(I,J,K,L,N)
                  ENDDO
               ENDDO
            ENDDO
         ENDDO
      ENDDO

C---  1st derivative w.r.t. slowness (phase direction):

      DO N=1,3
         DO K=1,3
            DO I=1,3
               DGAMDP(I,K,N) = 0.0
               DO L=1,3
                  DGAMDP(I,K,N) = DGAMDP(I,K,N) + 
     +                           (AA(N,I,L,K) + AA(I,L,K,N))*P(L)
               ENDDO
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CHRIS1
C-----------------------------------------------------------------------

C************************************************************************
C
C SUBROUTINE CHRIS2
C
C PURPOSE: Compute 2nd derivatives of the Christoffel tensor 
C          w.r.t. position and slowness (phase direction).
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE CHRIS2(DGAMXX,DGAMPP,DGAMXP,DGAMPX,AA,DADI,DADIJ,P)

      IMPLICIT NONE

C---  External input variables:
      REAL*8     P(3)               ! Slowness or phase direction
      REAL*8     AA   (3,3,3,3    ) ! Density norm. moduli at (x,y,z)
      REAL*8     DADI (3,3,3,3,3  ) ! 1st deriv. of moduli w.r.t. (x,y,z) 
      REAL*8     DADIJ(3,3,3,3,3,3) ! 2nd deriv. of moduli w.r.t. (x,y,z) 


C---  External output variables:
      REAL*8     DGAMXX(3,3,3,3)    ! 2nd deriv. of GAM w.r.t. position
      REAL*8     DGAMPP(3,3,3,3)    ! 2nd deriv. of GAM w.r.t. slowness
      REAL*8     DGAMXP(3,3,3,3)    ! Mixed 2nd deriv. og GAM
      REAL*8     DGAMPX(3,3,3,3)    ! Mixed 2nd deriv. og GAM

C---  Internal variables:
      INTEGER    I,J,K,L,M,N
      REAL*8 DIFF

C-----------------------------------------------------------------------
C  Compute 2nd derivative of Christoffel tensor w.r.t. position and
C  slowness (phase direction) Cerveny equation (4.14.8)
C  CHECK if mixed derivatives are correct !!!!!!!!
C-----------------------------------------------------------------------

C---  2nd derivative w.r.t. position:
      DO N=1,3
         DO M=1,3
            DO K=1,3
               DO I=1,3
                  DGAMXX(I,K,M,N) = 0.0
                  DO L=1,3
                     DO J=1,3
                        DGAMXX(I,K,M,N) = DGAMXX(I,K,M,N) + 
     +                                    P(J)*P(L)*DADIJ(I,J,K,L,M,N)
                     ENDDO
                  ENDDO
               ENDDO
            ENDDO
         ENDDO
      ENDDO

C---  Mixed 2nd derivative w.r.t. X (1st) and P (2nd):
      DO N=1,3
         DO M=1,3
            DO K=1,3
               DO I=1,3
C---              Old code (wrong?)
Cold              DGAMPX(I,K,M,N) = 0.0
C---              New code (right?)
                  DGAMXP(I,K,M,N) = 0.0
                  DO L=1,3
C---                 Old code (wrong?)
Cold                 DGAMPX(I,K,M,N) = DGAMPX(I,K,M,N) + 
Cold +                        P(L)*(DADI(I,M,K,L,N) + DADI(I,L,K,M,N))
C---                 New code (right?)
                     DGAMXP(I,K,M,N) = DGAMXP(I,K,M,N) + 
     +                        P(L)*(DADI(I,N,K,L,M) + DADI(I,L,K,N,M))
                  ENDDO
               ENDDO
            ENDDO
         ENDDO
      ENDDO

C---  Mixed 2nd derivative w.r.t. P (1st) and X (2nd):
      DO N=1,3
         DO M=1,3
            DO K=1,3
               DO I=1,3
C---              Old code (wrong?)
Cold              DGAMXP(I,K,M,N) = 0.0
C---              New code (right?)
                  DGAMPX(I,K,M,N) = 0.0
                  DO L=1,3
C---                 Old code (wrong?)
Cold                 DGAMXP(I,K,M,N) = DGAMXP(I,K,M,N) + 
Cold +                        P(L)*(DADI(I,N,K,L,M) + DADI(I,L,K,N,M))
C---                 New code (right?)
                     DGAMPX(I,K,M,N) = DGAMPX(I,K,M,N) + 
     +                        P(L)*(DADI(I,M,K,L,N) + DADI(I,L,K,M,N))
                  ENDDO
               ENDDO
            ENDDO
         ENDDO
      ENDDO

C---  2nd derivative w.r.t. slowness:
      DO N=1,3
         DO M=1,3
            DO K=1,3
               DO I=1,3
                  DGAMPP(I,K,M,N) = AA(I,N,K,M) + AA(I,M,K,N) 
               ENDDO
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE CHRIS2
C-----------------------------------------------------------------------








