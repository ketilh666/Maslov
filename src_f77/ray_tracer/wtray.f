C************************************************************************
C
C SUBROUTINE WTHDR
C
C PURPOSE: Write ascii file header containing shot number,
C          wavemodes and number of initial phase directions.
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE WTHDR(LUNEL,ISHOT,KMODE,NTH,NPH)

      IMPLICIT NONE

C---  External variables:
      INTEGER    LUNEL           ! I/O unit numbers
      INTEGER    ISHOT           ! Current shot 
      INTEGER    KMODE(3)        ! Current wave mode in KMODE(1)
      INTEGER    NTH,NPH         ! Number of initial phase directions

C---  Internal variables:
      INTEGER    I

C-----------------------------------------------------------------------
C   Write header to ascii file
C-----------------------------------------------------------------------

      WRITE(LUNEL,1) '============================'
      WRITE(LUNEL,1) '  ISHOT <KMODE>  NPH  NTH   '
      WRITE(LUNEL,2) ISHOT,(KMODE(I),I=1,3),NPH,NTH
      WRITE(LUNEL,1) '----------------------------'
      WRITE(LUNEL,1) '   IPH   ITH   NRAYEL       '

 1    FORMAT (A)
 2    FORMAT (I6,3I3,2I5)

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SBROUTINE WTHDR
C-----------------------------------------------------------------------

C************************************************************************
C
C SUBROUTINE WTRAY
C
C PURPOSE: Write ray travel time, position, slowness, polarization,
C          geometrical spreading etc. to binary diskfile. 
C
C SUBROUTINES CALLED : INTERPWT
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD           JANUARY  1998
C                      SVERRE BRANDSBERG-DAHL  JUNE     1999
C
C************************************************************************

      SUBROUTINE WTRAY(KMODE,ITH1,IPH1,MTH,MPH,MAXEL,NRAYEL,TRAY,
     +                 XRAY,PRAY,VGRAY,ETRAY,GNRAY,GVRAY,
     +                 GSRAY,Q1RAY,P1RAY,Q2RAY,P2RAY,JREC0,
     +                 LUNEL,LURAY,LURXZ,LURYZ,LURXY)

      IMPLICIT NONE

C---  External variables:
      INTEGER    KMODE(3)                 ! current wave mode                
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
      REAL*8     FT,FX,FP
      PARAMETER (FT=1.0,FX=1.0,FP=1.0D3)

C---  Internal variables:
      INTEGER    ITH,IPH
      INTEGER    IJ,I,J,K,L,M       
      INTEGER    JREC,KREC          ! Direct access record counter
      REAL*4     RWRK(NIO1)         ! I/O work array
      REAL*4     RXZ(NIO2),RYZ(NIO2),RXY(NIO2)

      INTEGER    IX
      DATA       IX / 0 /
      SAVE       IX

      REAL*8 X0,X1,X2,Z0,Z1,Z2,W1,W2,GS,TIME

      INTEGER LUOFF

C-----------------------------------------------------------------------
C  Write number of rayelements to ascii file
C-----------------------------------------------------------------------



      DO M=1,MPH
         DO L=1,MTH

            IPH = IPH1 + M-1
            ITH = ITH1 + L-1

            WRITE(LUNEL,1) IPH,ITH,NRAYEL(L,M)

         ENDDO
      ENDDO

 1    FORMAT(2I6,I8)

C-----------------------------------------------------------------------
C  Write raytracing data to direct access (SU:ftn=0) binary file
C-----------------------------------------------------------------------

C---  Get last record written:
      JREC = JREC0
      KREC = JREC0

C---  Initialize I/O array to zero:
      DO I=1,NIO1
         RWRK(I) = 0.0
      ENDDO

      DO M=1,MPH
         DO L=1,MTH

            DO K=1,NRAYEL(L,M)

C---           Scalars:
               RWRK(KT  +1) = TRAY (  K,L,M)          ! Travel time T
               RWRK(KGN1+1) = GNRAY(1,K,L,M)          ! Eigen value 1
               RWRK(KGN2+1) = GNRAY(2,K,L,M)          ! Eigen value 2
               RWRK(KGN3+1) = GNRAY(3,K,L,M)          ! Eigen value 3
               RWRK(KGS +1) = GSRAY(1,K,L,M)          ! Geom spr magn.
               RWRK(KGS +2) = GSRAY(2,K,L,M)          ! Geom spr 
C---           Vectors:
               DO I=1,3
                  RWRK(KX  +I) = XRAY (I  ,K,L,M)     ! Ray position
                  RWRK(KP  +I) = PRAY (I  ,K,L,M)     ! Slowness p
                  RWRK(KVG +I) = VGRAY(I  ,K,L,M)     ! Group velocity
                  RWRK(KET +I) = ETRAY(I  ,K,L,M)     ! dp/dT
                  RWRK(KGV1+I) = GVRAY(I,1,K,L,M)     ! Eigen vector 1
                  RWRK(KGV2+I) = GVRAY(I,2,K,L,M)     ! Eigen vector 2
                  RWRK(KGV3+I) = GVRAY(I,3,K,L,M)     ! Eigen vector 3
               ENDDO
C---           3x2 matrices:
               DO J=1,2
                  DO I=1,3
                     IJ = I+3*(J-1)
                     RWRK(KQ1+IJ) = Q1RAY(I,J,K,L,M)  ! Q1 cartesian
                     RWRK(KP1+IJ) = P1RAY(I,J,K,L,M)  ! P1 cartesian
                     RWRK(KQ2+IJ) = Q2RAY(I,J,K,L,M)  ! Q2 cartesian
                     RWRK(KP2+IJ) = P2RAY(I,J,K,L,M)  ! P2 cartesian
                  ENDDO
               ENDDO

C---           Write to disk, binary direct access:
               JREC = JREC+1

            ENDDO

         ENDDO
      ENDDO

C---  Update last record written:
      JREC0 = JREC

C-----------------------------------------------------------------------
C  Spline interpolation to desired depth
C-----------------------------------------------------------------------

      CALL INTERPWT(KMODE,MTH,MPH,MAXEL,NRAYEL,TRAY,XRAY,
     +              PRAY,VGRAY,GSRAY,GVRAY,Q2RAY,P2RAY)

C-----------------------------------------------------------------------
C  Write raypath to direct access (SU:ftn=0) binary file for plotting
C-----------------------------------------------------------------------

      LUOFF = 45
      OPEN (LUOFF,FILE='OFFSET.dir',FORM='UNFORMATTED',
     +      ACCESS='DIRECT',RECL=1)


C---  Initialize I/O array to zero:
      DO I=1,NIO2
         RXZ(I) = 0.0
         RYZ(I) = 0.0
         RXY(I) = 0.0
      ENDDO

      DO M=1,MPH
         DO L=1,MTH

            DO K=1,NRAYEL(L,M)

C---           Projections of the ray in (xi,xj)-planes:
               RXZ(2) = XRAY(3,K,L,M)*-1.0 ! xz-plane
               RXZ(1) = XRAY(1,K,L,M)-300.0
               RYZ(1) = XRAY(3,K,L,M)     ! yz-plane
               RYZ(2) = XRAY(2,K,L,M)
               RXY(1) = XRAY(1,K,L,M)     ! xy-plane
               RXY(2) = XRAY(2,K,L,M)
               
               KREC = KREC+1
               WRITE(LURXZ,REC=KREC) (RXZ(I),I=1,NIO2)
c$$$               WRITE(LURYZ,REC=KREC) (RYZ(I),I=1,NIO2)
c$$$               WRITE(LURXY,REC=KREC) (RXY(I),I=1,NIO2)

C***           DEBUGGING:
               WRITE(LUNEL,2)  KREC,K,
     +                         FT*TRAY(  K,L,M),
     +                         FX*XRAY(1,K,L,M),FX*XRAY(2,K,L,M),
     +                         FX*XRAY(3,K,L,M),FP*PRAY(1,K,L,M),
     +                         FP*PRAY(2,K,L,M),FP*PRAY(3,K,L,M)
 2             FORMAT(2I6,F9.5,3F9.2,3F9.5)

            ENDDO

         ENDDO
      ENDDO

C***           DEBUGGING:
      WRITE(LUNEL,*) 'TRAVELTIME AND GEOMETRICAL SPREADING:'
      DO M=1,MPH
         DO L=1,MTH 

            K = MAXEL
c$$$            RXY(2) = 1.0/REAL(TRAY(K,L,M))
            RXY(2) = 1.0/REAL(GSRAY(1,K,L,M))
            RXY(1) = REAL(XRAY(1,K,L,M))-300.0
            RYZ(1) = REAL(TRAY(K,L,M))
            RYZ(2) = REAL(XRAY(1,K,L,M))-300.0

            IF (L.GE.2) THEN
               RWRK(1) = REAL(XRAY(1,K,L,M))-REAL(XRAY(1,K,L-1,M))
            ELSE
               RWRK(1) = 0.0
            ENDIF

            WRITE(6,11) '+++ ITH,T,X,DX = ',L,RYZ(1),RYZ(2),RWRK(1) 
 11         FORMAT(A,I5,F8.5,2F8.2)


C            WRITE(6,*)' WTRAY: OFFSET = ',RXY(1)


            IX = IX+1
            WRITE(LUOFF,REC=IX) (RXY(1))
            WRITE(LURXY,REC=IX) (RXY(I),I=1,NIO2)
            WRITE(LURYZ,REC=IX) (RYZ(I),I=1,NIO2)
            WRITE(LUNEL,9) 'ITH,X0,Z0,TIME,GS = ',
     +            L,XRAY(1,K,L,M),XRAY(3,K,L,M),
     +            RYZ(1),RXY(2)

 9          FORMAT (A,I4,2F10.2,F10.5,F12.7)

         ENDDO
      ENDDO

      CLOSE(LUOFF)
C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C  END OF SUBROUTINE WTRAY
C-----------------------------------------------------------------------















