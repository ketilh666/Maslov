C************************************************************************
C
C SUBROUTINE RDHDR
C
C PURPOSE: Read ascii file header containing shot number,
C          wavemodes and number of initial phase directions.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD JANUARY  1999
C
C************************************************************************

      SUBROUTINE RDHDR(LUNEL,ISHOT,KMODE,NTH,NPH,NSKIP)

      IMPLICIT NONE

C---  External variables:
      INTEGER    LUNEL           ! I/O unit numbers
      INTEGER    ISHOT           ! Current shot 
      INTEGER    KMODE(3)        ! Current wave mode in KMODE(1)
      INTEGER    NTH,NPH         ! No of initial phase directions
      INTEGER    NSKIP           ! No of lines to skip in binary file

C---  Internal variables:
      LOGICAL      LCONT
      INTEGER      I,J,ISREAD
      INTEGER      IJUNK(3)
      CHARACTER*40 CJUNK

C-----------------------------------------------------------------------
C   Read header to ascii file
C-----------------------------------------------------------------------

C---  Initialize records to skip coounter:
      NSKIP = 0

 100  CONTINUE

C---     Read shotnumber, wavemodes and number of phase directions:
         READ(LUNEL,1) CJUNK
         READ(LUNEL,1) CJUNK
         READ(LUNEL,*) ISREAD,(KMODE(I),I=1,3),NPH,NTH 
         READ(LUNEL,1) CJUNK
         READ(LUNEL,1) CJUNK

         LCONT = ISREAD .NE. ISHOT

         IF (LCONT) THEN
            NSKIP = NSKIP + NPH*NTH
            DO J=1,NPH*NTH
               READ(LUNEL,*) (IJUNK(I),I=1,3)
            ENDDO
         ENDIF
 
      IF(LCONT) GOTO 100

 1    FORMAT (A)
 2    FORMAT (I6,3I3,2I5)
 3    FORMAT (2I6,I8)

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SBROUTINE RDHDR
C-----------------------------------------------------------------------

C************************************************************************
C
C SUBROUTINE RDRAY
C
C PURPOSE: Read ray travel time, position, slowness, polarization,
C          geometrical spreading etc. travel time from binary diskfile. 
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C                      KETIL HOKSTAD JANUARY  1998
C
C************************************************************************

      SUBROUTINE RDRAY(ITH1,IPH1,MTH,MPH,MAXEL,NRAYEL,TRAY,
     +                 XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                 GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,JREC0,
     +                 LUNEL,LURAY,LURXZ,LURYZ,LURXY)

      IMPLICIT NONE

C---  External variables:
      INTEGER    ITH1,IPH1,MTH,MPH  
      INTEGER    MAXEL  
      INTEGER    NRAYEL(MTH,MPH)          ! Number of rayelements
      REAL*8     TRAY (MAXEL,MTH,MPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,MTH,MPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,MTH,MPH)   ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,MTH,MPH)   ! Ray group velocity
      REAL*8     ETRAY(3,MAXEL,MTH,MPH)   ! Ray deriv. of slowness
      REAL*8     GSRAY(2,MAXEL,MTH,MPH)   ! Complex geom spreading
      REAL*8     GNRAY(3,MAXEL,MTH,MPH)   ! Ray eigenvals. (no sqrt)
      REAL*8     GVRAY(3,3,MAXEL,MTH,MPH) ! Ray eigenvectors 
      REAL*8     Q1RAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix Q1x (Cartesian)
      REAL*8     P1RAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix P1x (Cartesian)
      REAL*8     Q2RAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix Q2x (Cartesian)
      REAL*8     P2RAY(3,2,MAXEL,MTH,MPH) ! 3x2 matrix P2x (Cartesian)
      INTEGER    JREC0                    ! Last record written
      INTEGER    LUNEL,LURAY              ! I/O unit numbers.
      INTEGER    LURXZ,LURYZ,LURXY        ! I/O unit numbers for debugging.

C---  Parameters:
      INCLUDE '../include_files/io_pars.inc'

C---  Internal variables:
      INTEGER    ITH,IPH
      INTEGER    IJ,I,J,K,L,M  
      INTEGER    JREC               ! Direct access record counter
      REAL*4     RWRK(NIO1)         ! I/O work array

C-----------------------------------------------------------------------
C  Read number of rayelements to ascii file
C-----------------------------------------------------------------------

      DO M=1,MPH
         DO L=1,MTH

            IPH = IPH1 + M-1
            ITH = ITH1 + L-1

            READ(LUNEL,*) I,J,NRAYEL(L,M)

         ENDDO
      ENDDO

 1    FORMAT(2I6,I8)

C-----------------------------------------------------------------------
C  Read raytracing data to direct access (SU:ftn=0) binary file
C-----------------------------------------------------------------------

C---  Get first record to read (minus-1):
      JREC = JREC0

C---  Initialize I/O array to zero:
      DO I=1,NIO1
         RWRK(I) = 0.0
      ENDDO

      DO M=1,MPH
         DO L=1,MTH

            DO K=1,NRAYEL(L,M)

C---           Read from disk, binary direct access:
               JREC = JREC+1
               READ(LURAY,REC=JREC) (RWRK(I),I=1,NIO1)

C---           Scalars:
               TRAY (  K,L,M) = RWRK(KT  +1)          ! Travel time T
               GNRAY(1,K,L,M) = RWRK(KGN1+1)          ! Eigen value 1
               GNRAY(2,K,L,M) = RWRK(KGN2+1)          ! Eigen value 2
               GNRAY(3,K,L,M) = RWRK(KGN3+1)          ! Eigen value 3
               GSRAY(1,K,L,M) = RWRK(KGS +1)          ! Geom spr magn.
               GSRAY(2,K,L,M) = RWRK(KGS +2)          ! Geom spr phase
C---           Vectors:
               DO I=1,3
                  XRAY (I  ,K,L,M) = RWRK(KX  +I)     ! Ray position
                  PRAY (I  ,K,L,M) = RWRK(KP  +I)     ! Slowness p
                  VGRAY(I  ,K,L,M) = RWRK(KVG +I)     ! Group velocity
                  ETRAY(I  ,K,L,M) = RWRK(KET +I)     ! dp/dT
                  GVRAY(I,1,K,L,M) = RWRK(KGV1+I)     ! Eigen vector 1
                  GVRAY(I,2,K,L,M) = RWRK(KGV2+I)     ! Eigen vector 2
                  GVRAY(I,3,K,L,M) = RWRK(KGV3+I)     ! Eigen vector 3
               ENDDO
C---           3x2 matrices:
               DO J=1,2
                  DO I=1,3
                     IJ = I+3*(J-1)
                     Q1RAY(I,J,K,L,M) = RWRK(KQ1+IJ)  ! Q1 cartesian
                     P1RAY(I,J,K,L,M) = RWRK(KP1+IJ)  ! P1 cartesian
                     Q2RAY(I,J,K,L,M) = RWRK(KQ2+IJ)  ! Q2 cartesian
                     P2RAY(I,J,K,L,M) = RWRK(KP2+IJ)  ! P2 cartesian
                  ENDDO
               ENDDO

            ENDDO

         ENDDO
      ENDDO

C---  Update last record read:
      JREC0 = JREC

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C  END OF SUBROUTINE RDRAY
C-----------------------------------------------------------------------















