C************************************************************************
C
C SUBROUTINE JUDAS
C
C PURPOSE: Compute the outer product of a ploarization vector and
C          its derivative w.r.t. position or slowness.
C          
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

      SUBROUTINE JUDAS(GIDGK,GIGJ,GN,DGAMDA,KMODE,NMODE,LDEGEN,
     +                 GAM,AA,P)

      IMPLICIT NONE

C---  External input variables:
      REAL*8   GAM(3,3)        ! Christoffel tensor
      REAL*8   AA(3,3,3,3)     ! Density norm. moduli at (x,y,z)
      REAL*8   P(3)            ! Slowness vectors
      INTEGER  NMODE           ! 3
      INTEGER  KMODE(NMODE)    ! Wavemodes. Current mode is in kmode(1).
      REAL*8   DGAMDA(3,3,3)   ! Deriv. of Christ. tensor w.r.t. x or p.
      REAL*8   GN(NMODE)       ! Eigen values of the Christoffel tensor
      REAL*8   NEWGN(NMODE)    ! Extra eigen values of the Christoffel tensor
      REAL*8   GIGJ(3,3,NMODE) ! Outer product of polartization vectors


      LOGICAL  LDEGEN          ! Degenerate eigenvalues for qS1 and qS2?

C---  External output variables:
      REAL*8   GIDGK(3,3,3)    ! Outer prod. of pol. vector and deriv.


C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'


C---  Internal variables:
      INTEGER  I,J,K,L,N
      INTEGER  M1,M2,M3
      REAL*8   D2,D3
      REAL*8   TRD(3)          ! Trace of cofactor matrix

C-----------------------------------------------------------------------
C  Wavemodes: M1 is the current wave mode and M2,M3 are the two others 
C-----------------------------------------------------------------------

c$$$      DO K=1,3
c$$$         DO J=1,3
c$$$            DO I=1,3
c$$$               GIDGK(I,J,K) = 0.0
c$$$            ENDDO
c$$$         ENDDO
c$$$      ENDDO
c$$$      RETURN

      M1 = KMODE(1)
      M2 = KMODE(2)
      M3 = KMODE(3)

C-----------------------------------------------------------------------
C  Compute prefactors D2 and D3 in Cerveny equation (4.14.10)
C  NOTE: This may require some modification if the qS1 and qS2
C        eigenvalues are degenerate.
C-----------------------------------------------------------------------
      

C***********************************************************************
C THE NEW PART THAT WILL PERTURB THE SLOWNESS DIRECTION TO FIND DESTINCT
C POLARIZATION VECTORS
C***********************************************************************

C      IF (.NOT.LDEGEN) THEN

C         WRITE(6,*)'VEL = ',GN(M1),GN(M2),GN(M3),LDEGEN

         D3 = GN(M3)-GN(M1)
         D2 = GN(M2)-GN(M1)
         D2 = 1.0/D2
         D3 = 1.0/D3

c$$$      ELSE
c$$$
c$$$         CALL DEGEN(NMODE,KMODE,GAM,AA,P,GIGJ,NEWGN)
c$$$
c$$$         WRITE(6,*)'VELNEW = ',NEWGN(M1),NEWGN(M2),NEWGN(M3),LDEGEN
c$$$
c$$$         D3 = NEWGN(M3)-NEWGN(M1)
c$$$         D2 = NEWGN(M2)-NEWGN(M1)
c$$$         D2 = 1.0/D2
c$$$         D3 = 1.0/D3
c$$$
c$$$      ENDIF
c$$$

c$$$         IF(LDEGEN) THEN
c$$$            D2 = 0.0
c$$$            D3 = 0.0
c$$$         ENDIF

c$$$         IF (ABS(D2).GT.ABS(D3)) THEN
c$$$            D2 = 1.0/D2
c$$$            D3 = 1.0/D3
c$$$         ELSE
c$$$            D2 = 0.0
c$$$            D3 = 1.0/D3
c$$$         ENDIF

C         WRITE(6,*) 'JUDAS : D2,D3,LDEGEN = ',D2,D3,LDEGEN
      
C-----------------------------------------------------------------------
C  Compute the outer product of g_i and its derivative dg_k/da_n.
C  See Cerveny equations (4.14.7), (4.14.9) and (4.14.10)
C-----------------------------------------------------------------------

      DO N=1,3
         DO K=1,3
            DO I=1,3
               GIDGK(I,K,N) = 0.0
               DO L=1,3
                  DO J=1,3
                     GIDGK(I,K,N) =  GIDGK(I,K,N) +
     +                              (DGAMDA(L,J,N)*GIGJ(I,J,M1))*
     +                              (D2*GIGJ(K,L,M2)+D3*GIGJ(K,L,M3))

                  ENDDO
               ENDDO
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE JUDAS
C-----------------------------------------------------------------------




