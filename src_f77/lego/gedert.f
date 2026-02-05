C************************************************************************
C
C SUBROUTINE JUDAS
C
C PURPOSE: Compute derivative  of the polarization vectors
C          w.r.t. traveltime along the ray.
C
C REFERENCES: Equation numbers refer to 
C          Cerveny, V., 1995: Elastic wavefields in three-
C          dimensional isotropic and anisotropic structures. 
C          Lecture notes, University of Trondheim, 1995.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD FEBRUARY 1998
C
C************************************************************************

      SUBROUTINE GEDERT(GVDOT,GVEC,GN,P,PDOT,KMODE)

      IMPLICIT NONE

C---  External input variables:
      INTEGER  KMODE(3)        ! Wavemodes. Current mode is in kmode(1).
      REAL*8   P(3)            ! Slowness vector
      REAL*8   PDOT(3)         ! Slowness vector
      REAL*8   GN(3)           ! Eigen values of the Christoffel tensor
      REAL*8   GVEC(3,3)       ! Eigen vectors of the Christoffel tensor

C---  External output variables:
      REAL*8   GVDOT(3,3)      ! Derivative of polariz. vector w.r.t time

C---  Parameters:
      INCLUDE '../include_files/ray_control.inc'


C---  Internal variables:
      INTEGER  I,M
      REAL*8   RN,RD

C-----------------------------------------------------------------------
C  Compute derivative of polarization vectors w.r.t time using
C  Cerveny equation (4.14.14)
C-----------------------------------------------------------------------

C      WRITE(6,*) 'GEDERT: P,PDOT=',(P(I),I=1,3),(PDOT(I),I=1,3)
 

      DO M=1,3
         DO I=1,3
            GVDOT(I,M) = 0.0
         ENDDO
      ENDDO
      RETURN
     
C--- Length of slowness squared:
      RD = 0.0
      DO I=1,3
         RD = RD + P(I)*P(I)
      ENDDO

C--- qS1 and qs2 modes:
      DO M=1,2
         RN = 0.0
         DO I=1,3
            RN = RN + GVEC(I,M)*PDOT(I) 
         ENDDO
         DO I=1,3
            GVDOT(I,M) = -P(I)*RN/RD
         ENDDO
      ENDDO

C--- qP mode:
      M = 3
      RN = 0.0
      DO I=1,3
         RN = RN + P(I)*PDOT(I) 
      ENDDO
      DO I=1,3
         GVDOT(I,M) = (PDOT(I)-P(I)*RN/RD)/SQRT(RD)  
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE GEDERT
C-----------------------------------------------------------------------




