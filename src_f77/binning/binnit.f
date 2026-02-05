C************************************************************************
C
C SUBROUTINE BINNIT
C
C PURPOSE: Assign ray data to cells on a regular grid.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY  1999
C
C************************************************************************
 
      SUBROUTINE BINNIT(NRTAB,JRTAB,NXBIN,NYBIN,MAXINB,
     +                  DXBIN,X0BIN,XRAY,NTH,NPH,MAXEL,NZERO)

      IMPLICIT NONE

C--- External variables:
      INTEGER NXBIN,NYBIN           ! Number of bin cells
      INTEGER MAXINB                ! Max number of rays in a bin        
      INTEGER NRTAB(NXBIN,NYBIN)    ! Number of rays in each bin
      INTEGER JRTAB(2,MAXINB,NXBIN,NYBIN) ! Rays in each bins
      INTEGER NZERO                 ! Number of bins with zero rays
      INTEGER MAXEL,NTH,NPH         ! Number of rays
      REAL*4  X0BIN(2)              ! Origin of the bin grid
      REAL*4  DXBIN(2)              ! Cell size in x- and y-direction
      REAL*8  XRAY(3,MAXEL,NTH,NPH) ! Ray positions

C--- Internal variables:
      INTEGER  I,J,K,L,M
      INTEGER  MRTAB,NRMAX

C-----------------------------------------------------------------------
C   Initialize arrays
C-----------------------------------------------------------------------

      DO J=1,NYBIN
         DO I=1,NXBIN
            NRTAB(I,J) = 0
            DO M=1,MAXINB
               JRTAB(1,M,I,J) = 0
               JRTAB(2,M,I,J) = 0
            ENDDO
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C   Distribute traces to bins
C-----------------------------------------------------------------------

      WRITE(6,*) 'BINNING: NXBIN,NYBIN = ',NXBIN,NYBIN
      K = MAXEL
      DO M=1,NPH
         DO L=1,NTH
            I = 1 + NINT( (REAL(XRAY(1,K,L,M))-X0BIN(1))/DXBIN(1) )
            J = 1 + NINT( (REAL(XRAY(2,K,L,M))-X0BIN(2))/DXBIN(2) )
            MRTAB = NRTAB(I,J) + 1


C            WRITE(6,*) ' + L,M,I,J = ',L,M,I,J


            IF (MRTAB .LE. MAXINB) THEN
               NRTAB(I,J) = MRTAB
               JRTAB(1,MRTAB,I,J) = L
               JRTAB(2,MRTAB,I,J) = M
            ELSE
               WRITE(6,*) 'WARNING in BINNING: arrays too small'
            ENDIF
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
C  Find max number of traces in a bin
C  Detect bins that are still empty
C-----------------------------------------------------------------------

      NRMAX = 0
      NZERO = 0

      DO J=1,NYBIN
         DO I=1,NXBIN
            MRTAB = NRTAB(I,J)
            IF (MRTAB .GT. NRMAX) NRMAX = MRTAB
            IF (MRTAB .EQ. 0    ) NZERO = NZERO + 1
         ENDDO
      ENDDO

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C  END OF SUBROUTINE BINNIT
C-----------------------------------------------------------------------















