C************************************************************************
C
C SUBROUTINE SHENN8
C
C PURPOSE: Find the N nearest neighbour points to be used
C          in 3D Shepard interpolation of ray tracing data.
C          
C REFERENCES: 
C          Kincaid and Cheney (1991): Numerical Analyisis.
C          Mathematics of scientific computing. (Chapter 6)
C          Brooks/Cole publ. Company.
C          
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD SEPTEMBER 1999
C
C************************************************************************

      SUBROUTINE SHENN8(NNTAB,NSHE,XINT,XRAY,NRAYEL,
     +                  MAXEL,NTH,NPH,LENTRE)

      IMPLICIT NONE

C---  External output variables:
      INTEGER NNTAB(3,NSHE)          ! Table of NSHE nearest neighbor.
                                     ! K=1: Ray element index
                                     ! K=2: Polar angle index
                                     ! K=3: Azim. angle index

C---  External input variables:
      INTEGER LENTRE                 ! Search entire or limited part 
      INTEGER NSHE                   ! No of points used in interpolation
      INTEGER MAXEL                  ! Max no of rayelements
      INTEGER NTH,NPH                ! Number of initial phase angles
      INTEGER NRAYEL(NTH,NPH)        ! Number of rayelements
      REAL*8  XRAY(3,MAXEL,NTH,NPH)  ! Ray positions
      REAL*8  XINT(3)                ! Interpolation output point

C---  Parameters:
      INCLUDE '../include_files/interpol.inc'

C---  Internal variables:
      INTEGER I,J,K,ITH,IPH
      INTEGER K0,K1,K2,ITH1,ITH2,IPH1,IPH2
      REAL*8  RMIN,RTEST,ZTEST
      REAL*8  X1,Y1,Z1,RTMP1
      REAL*8  X2,Y2,Z2,RTMP2

C---  Save for next call:
      SAVE    K0,ITH,IPH

C-----------------------------------------------------------------------
C     Find the NSHE nearest neighbours of the point XINT
C-----------------------------------------------------------------------

      IF (LENTRE) THEN

C---     Initialize:
         RMIN = 1.0e12
         DO J=1,NSHE
            NNTAB(1,J) = J
            NNTAB(2,J) = 1
            NNTAB(3,J) = 1
         ENDDO

C---     Search the entire data set:
         DO IPH=1,NPH
            DO ITH=1,NTH
               DO K=1,NRAYEL(ITH,IPH)-1
                  Z1 = XINT(3) - XRAY(3,K,ITH,IPH)
                  Z2 = XRAY(3,K+1,ITH,IPH) - XINT(3)
                  ZTEST = Z1*Z2
                  IF (ZTEST.GE.0.0d0) THEN
                     X1 = ( XINT(1) - XRAY(1,K  ,ITH,IPH) )
                     Y1 = ( XINT(2) - XRAY(2,K  ,ITH,IPH) )
                     X2 = ( XINT(1) - XRAY(1,K+1,ITH,IPH) )
                     Y2 = ( XINT(2) - XRAY(2,K+1,ITH,IPH) )
                     RTMP1 = X1*X1 + Y1*Y1 + Z1*Z1
                     RTMP2 = X2*X2 + Y2*Y2 + Z2*Z2
                     IF (RTMP1 .LE. RTMP2) THEN
                        RTEST = RTMP1
                        K1    = K
                        K2    = K+1
                     ELSE
                        RTEST = RTMP2
                        K1    = K+1
                        K2    = K
                     ENDIF
                     IF (RTEST .LE. RMIN) THEN
                        DO J=NSHE,3,-1
                           NNTAB(1,J) = NNTAB(1,J-2)
                           NNTAB(2,J) = NNTAB(2,J-2)
                           NNTAB(3,J) = NNTAB(3,J-2)
                        ENDDO
                        NNTAB(1,1) = K1
                        NNTAB(2,1) = ITH
                        NNTAB(3,1) = IPH
                        NNTAB(1,2) = K2
                        NNTAB(2,2) = ITH
                        NNTAB(3,2) = IPH
                        RMIN = RTEST
                     ENDIF
                  ENDIF
               ENDDO
            ENDDO
         ENDDO
      ELSE

C---     Initialize with last nearest neighbor:
c$$$         K0   = NNTAB(1,1)
c$$$         ITH  = NNTAB(2,1)
c$$$         IPH  = NNTAB(3,1)
         X1   = ( XINT(1) - XRAY(1,K0,ITH,IPH) )
         Y1   = ( XINT(2) - XRAY(2,K0,ITH,IPH) )
         Z1   = ( XINT(3) - XRAY(3,K0,ITH,IPH) )
         RMIN = X1*X1 + Y1*Y1 +Z1*Z1

C---     Limited search in near last nearest neighbor:
         ITH1 = MAX(NNTAB(2,1)-LSRCH2,1  )
         ITH2 = MIN(NNTAB(2,1)-LSRCH2,NTH)
         IPH1 = MAX(NNTAB(3,1)+LSRCH3,1  )
         IPH2 = MIN(NNTAB(3,1)+LSRCH3,NPH)
         DO IPH=IPH1,IPH2
            DO ITH=ITH1,ITH2
               K1   = MAX(K0-LSRCH1,1)
               K2   = MIN(K0+LSRCH1,NRAYEL(ITH,IPH))
               DO K=K1,K2
                  X1 = ( XINT(1) - XRAY(1,K,ITH,IPH) )
                  Y1 = ( XINT(2) - XRAY(2,K,ITH,IPH) )
                  Z1 = ( XINT(3) - XRAY(3,K,ITH,IPH) )
                  RTEST = X1*X1 + Y1*Y1 +Z1*Z1
                  IF (RTEST .LE. RMIN) THEN
                     DO J=NSHE,2,-1
                        NNTAB(1,J) = NNTAB(1,J-1)
                        NNTAB(2,J) = NNTAB(2,J-1)
                        NNTAB(3,J) = NNTAB(3,J-1)
                     ENDDO
                     NNTAB(1,1) = K
                     NNTAB(2,1) = ITH
                     NNTAB(3,1) = IPH
                     RMIN = RTEST
                  ENDIF
               ENDDO
            ENDDO
         ENDDO

      ENDIF

C-----------------------------------------------------------------------
C     Store indices of nearest neighbors for next call
C-----------------------------------------------------------------------

      K0   = NNTAB(1,1)
      ITH  = NNTAB(2,1)
      IPH  = NNTAB(3,1)

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE SHENN8
C-----------------------------------------------------------------------


