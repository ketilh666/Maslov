C************************************************************************
C
C SUBROUTINE DEGEN
C
C PURPOSE: Perturb the Christoffel system to make it non-degenrated
C          and then return corresponding changes in wave front 
C          normals needed to make the system well conditioned.
C
C REFERENCE: Jech, J. and Psencik, I.,1989: First-order perturbation
C            method for anisotropic media, Geophys. J. Int, 99
C
C SUBROUTINES CALLED : CHRIST, BRUTUS
C
C PROGRAMMED: SVERRE BRANDSBERG-DAHL, FEBRUARY 1999
C 
C************************************************************************

      SUBROUTINE DEGEN(NMODE,KMODE,GAM,AA,P,GVEC,NEWGN,GAM2)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  NMODE              ! Number of modes to compute
      INTEGER  KMODE(3)           ! Wavemodes. Current mode is in kmode(1).
      REAL*8   GAM(3,3)           ! Christoffel tensor
      REAL*8   AA(3,3,3,3)        ! Density norm. moduli at (x,y,z)
      REAL*8   P(3)               ! Slowness vectors

C---  External output variables:
      REAL*8   GVEC(3,3)          ! Polariz. vectors DIJ/TRD
      REAL*8   NEWGN(3)           ! New eigenvalues, phase velocities
      REAL*8   GAM2(3,3)          ! Extra Christoffel matrix



C---  Internal variables:
      REAL*8   GVECD(3,3)         ! Perturbed part of eigen vector matrix
      REAL*8   DGAM(3,3)          ! Perturbed Christoffel matrix
      REAL*8   ALPH(3)            ! Phase vector
      REAL*8   DALPH              ! Perturbation in 3.comp of phase vector 
      REAL*8   C(3,3)             ! Table of constants
      REAL*8   PLEN               ! Velocity

      INTEGER  I,J,K,M,N          ! Loop counters
      LOGICAL  GDEGEN             ! Degenerate eigenvalues for qS1 and qS2?


C---  The amount of perturbation in phase dir. (x,y) -> (x+eps,y-eps)
      REAL*8   EPS
      PARAMETER ( EPS=0.1)


C************************************************************************
C     Make a perturbation of the slowness vector so that the 
C     system is non-degenerate
C************************************************************************

C---  Find the phase vector
      PLEN = SQRT( P(1)**2+P(2)**2+P(3)**2 )
      DO I=1,3
         ALPH(I) = P(I)/PLEN
      ENDDO



c$$$      WRITE(6,*)' OLDALP = ',ALPH(1),ALPH(2),ALPH(3)
c$$$      PLEN = SQRT(ALPH(1)**2+ALPH(2)**2+ALPH(3)**2)
c$$$      WRITE(6,*)' |ALPHAO| = ',PLEN



C---  Perturb the phase vector with epsilon
 1    ALPH(1) = ALPH(1) + EPS
      ALPH(2) = ALPH(2) 
      DALPH   = ( -ALPH(1)*EPS - ALPH(2))/ALPH(3)
      ALPH(3) = ALPH(3)+DALPH



c$$$      WRITE(6,*)' NEWALP = ',ALPH(1),ALPH(2),ALPH(3)
c$$$      PLEN = SQRT(ALPH(1)**2+ALPH(2)**2+ALPH(3)**2)
c$$$      WRITE(6,*)' |ALPHAN| = ',PLEN




C---  Find the new polarization vectors
      CALL CHRIS0(GAM2,AA,ALPH)            ! Compute the new GAM2
      CALL BRUTUS(NEWGN,GVEC,GAM2,GDEGEN)  ! Compute GVEC and NEWGN

      IF (GDEGEN) THEN 
       GOTO 1                   ! perturb again, since still degenerated
      ENDIF


C************************************************************************

C---  Determine the perturbed Christoffel matrix
C     and calculate the C(M,N)'s , eqn(12) in the paper

c$$$      DO I=1,3
c$$$         WRITE(6,*)' NEWGN = ',NEWGN(1)         
c$$$         DO J=1,3
c$$$            DGAM(I,J) = GAM(I,J)/PLEN**2 - GAM2(I,J)
c$$$         ENDDO
c$$$      ENDDO
c$$$
c$$$      DO M=1,3
c$$$         DO N=1,3
c$$$            IF(M.EQ.N) THEN
c$$$               C(M,N) = 0.0
c$$$            ELSE
c$$$               C(M,N) = 0.0
c$$$               DO J=1,3
c$$$                  DO K=1,3
c$$$                     C(M,N) = C(M,N)+((DGAM(J,K)*GVEC(J,M)*GVEC(K,N))/
c$$$     +                    (NEWGN(M)-NEWGN(N)))
c$$$                  ENDDO
c$$$               ENDDO
c$$$            ENDIF
c$$$         ENDDO
c$$$      ENDDO
c$$$
c$$$
c$$$
c$$$C---  Calculate the perturbation in polarization
c$$$      DO M=1,3
c$$$         DO J=1,3
c$$$            GVECD(J,M) = 0.0
c$$$            DO N=1,3
c$$$               GVECD(J,M) = GVECD(J,M) + C(M,N)*GVEC(J,N)
c$$$            ENDDO
c$$$         ENDDO
c$$$
c$$$      ENDDO

C---  Calculate the polarization vectors
c$$$      DO I=1,3
c$$$         DO J=1,3
c$$$            GVEC(J,I) = GVEC(J,I)  + GVECD(J,I)
c$$$         ENDDO
c$$$      ENDDO

C---  Scale the quantities with the phase velocity
      DO I=1,3
         DO J=1,3
            GAM2(J,I) = GAM2(J,I)/NEWGN(3)
         ENDDO
      ENDDO

      DO I=1,3
         NEWGN(I) = NEWGN(I)/NEWGN(3)
      ENDDO


C***************************************************************************

      RETURN
      END

C***************************************************************************
C END SUBROUTINE DEGEN
C***************************************************************************






