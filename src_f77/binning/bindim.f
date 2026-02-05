C************************************************************************
C
C SUBROUTINE BINDIM
C
C PURPOSE: Compute the size of the binning table
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY  1999
C
C************************************************************************
 
      SUBROUTINE BINDIM(NXBIN,NYBIN,DXBIN,X0BIN,XRAY,NTH,NPH,MAXEL)

      IMPLICIT NONE

C--- External variables:
      INTEGER NXBIN,NYBIN           ! Number of bin cells
      INTEGER MAXEL,NTH,NPH         ! Number of rays
      REAL*4  X0BIN(2)              ! Origin of the bin grid
      REAL*4  DXBIN(2)              ! Cell size in x- and y-direction
      REAL*8  XRAY(3,MAXEL,NTH,NPH) ! Ray positions

C--- Internal variables:
      INTEGER     I,J,K,L,M
      INTEGER     NX(2)
      INTEGER     IMIN(2),IMAX(2)
      REAL        XMIN(2),XMAX(2)
      REAL        SMIN(2),SMAX(2)
      REAL        X0(2),X1(2)
      REAL        XTEST

      INTEGER     LMAX(2),MMAX(2)
      INTEGER     LMIN(2),MMIN(2)
      REAL        VMIN,VMAX

C-----------------------------------------------------------------------
C   Find max and min values of XRAY
C-----------------------------------------------------------------------

      DO I=1,2
         XMIN(I) =  1.0E30
         XMAX(I) = -1.0E30
      ENDDO

      K = MAXEL
      DO M=1,NPH
         DO L=1,NTH
            DO I=1,2
               XTEST = REAL(XRAY(I,K,L,M))
               IF (XTEST .LT. XMIN(I) ) THEN
                  XMIN(I)=XTEST
                  LMIN(I) = L
                  MMIN(I) = M
               ENDIF
               IF (XTEST .GT. XMAX(I) ) THEN
                  XMAX(I)=XTEST
                  LMAX(I) = L
                  MMAX(I) = M
               ENDIF
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C   Center of first bin
C-----------------------------------------------------------------------

      DO I=1,2
         SMIN(I) = 1.0
         SMAX(I) = 1.0
         IF (XMIN(I) .LT. 0.0) SMIN(I) = -1.0
         IF (XMAX(I) .LT. 0.0) SMAX(I) = -1.0
      ENDDO

      DO I=1,2
         IMIN(I) = INT((XMIN(I)+0.5*SMIN(I)*DXBIN(I))/DXBIN(I))
         IMAX(I) = INT((XMAX(I)+0.5*SMAX(I)*DXBIN(I))/DXBIN(I))
      ENDDO

C-----------------------------------------------------------------------
C   Number of bins in x- and y-directons
C-----------------------------------------------------------------------

      DO I=1,2
         X0(I) = REAL(IMIN(I))*DXBIN(I)
         X1(I) = REAL(IMAX(I))*DXBIN(I)
         NX(I) = 1 + NINT((X1(I)-X0(I))/DXBIN(I))
      ENDDO

      NXBIN    = NX(1)
      NYBIN    = NX(2)
      X0BIN(1) = X0(1)
      X0BIN(2) = X0(2)


      L = LMIN(1)
      M = 1
      VMIN = REAL(XRAY(1,K,L,M)**2+XRAY(2,K,L,M)**2+XRAY(3,K,L,M)**2)
      VMIN = 1.0/SQRT(VMIN)

      L = LMAX(1)
      M = 1
      VMAX = REAL(XRAY(1,K,L,M)**2+XRAY(2,K,L,M)**2+XRAY(3,K,L,M)**2)
      VMAX = 1.0/SQRT(VMAX)


      WRITE(6,*) 'BINDIM:'
      WRITE(6,*) ' + XMIN,IMIN = ',XMIN(1),XMIN(2),IMIN(1),IMIN(2)
      WRITE(6,*) ' + XMAX,IMAX = ',XMAX(1),XMAX(2),IMAX(1),IMAX(2)
      WRITE(6,*) ' + X0  ,NX   = ',X0(1),X0(2),NX(1),NX(2)
      WRITE(6,*) ' + LMAX,MMAX = ',LMAX(1),LMAX(2),MMAX(1),MMAX(2)
      WRITE(6,*) ' + LMIN,MMIN = ',LMIN(1),LMIN(2),MMIN(1),MMIN(2)
      WRITE(6,*) ' + VMIN,VMAX = ',VMIN,VMAX


C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE BINDIM
C-----------------------------------------------------------------------
