C************************************************************************
C
C SUBROUTINE INTERP
C
C PURPOSE: Interpolate ray data onto a fixed depth grid:
C          ray travel time, position, slowness, polarization,
C          geometrical spreading etc.
C
C SUBROUTINES CALLED : SPLINT,SPLINE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : SVERRE BRANDSBERG-DAHL JANUARY 1999
C
C************************************************************************

      SUBROUTINE INTERP(KMODE,NTH,NPH,MAXEL,NRAYEL,KINDX,TRAY,XRAY,
     +                  PRAY,VGRAY,GSRAY,GVRAY,Q2RAY,P2RAY,KMAH)


      IMPLICIT NONE

C---  External variables:
      INTEGER    KMODE(3)
      INTEGER    NTH,NPH  
      INTEGER    MAXEL  
      INTEGER    NRAYEL(NTH,NPH)          ! Number of rayelements
      INTEGER    KINDX(MAXEL,NTH,NPH)      ! Ray flip-index
      REAL*8     TRAY (MAXEL,NTH,NPH)     ! Ray traveltime
      REAL*8     XRAY (3,MAXEL,NTH,NPH)   ! Ray positions
      REAL*8     PRAY (3,MAXEL,NTH,NPH)   ! Ray slowness
      REAL*8     VGRAY(3,MAXEL,NTH,NPH)   ! Ray group velocity
      REAL*8     GSRAY(2,MAXEL,NTH,NPH)   ! Complex geom spreading
      REAL*8     GVRAY(3,3,MAXEL,NTH,NPH) ! Ray eigenvectors 
      REAL*8     Q2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix Q2x (Cartesian)
      REAL*8     P2RAY(3,2,MAXEL,NTH,NPH) ! 3x2 matrix P2x (Cartesian)

C---  External output variables
      INTEGER    KMAH(NTH,NPH)            ! KMAH index array at recording surface

C---  Internal variables:
      INTEGER    H,I,J,K,L,M,N,D,J1,J2,JD,IND     
      REAL*8     X0,Z0,X1,X2,Z1,Z2,GS,TIME,
     +           DERIV(101),RWRK(101)
      REAL*8     DER1,DER2
      PARAMETER  (D=2)

C---  DESIRED DEPTH (MUST CHANGE TO ARRAY TO MANAGE GENERAL RECORDING GEOM.)
      Z0 = 650   ! depth of recording surface



C-----------------------------------------------------------------
C---  Main loop over takeoff angles
C-----------------------------------------------------------------

      DO M=1,NPH
         DO L=1,NTH


C---        Find the ray-nodes above and belove Z0
            J = 2
            DO K=1,NRAYEL(L,M)
               IF( XRAY(3,K,L,M) .GT. Z0 ) THEN
                  J = K
                  GOTO 100
               ENDIF
            ENDDO

 100        CONTINUE


C---        Find the travel time that corresponds to this depth level
            X1 = XRAY(1,J-1,L,M)
            Z1 = XRAY(3,J-1,L,M)
            X2 = XRAY(1,J  ,L,M)
            Z2 = XRAY(3,J  ,L,M)
            X0 = X1 + (X2-X1)*(Z0-Z1)/(Z2-Z1)
            TIME = TRAY(J-1,L,M)+((Z0-Z1)/(Z2-Z1))*
     +             (TRAY(J,L,M)-TRAY(J-1,L,M)) 
            XRAY(1,MAXEL,L,M)  = X0
            XRAY(3,MAXEL,L,M)  = Z0
            TRAY(MAXEL,L,M)    = TIME 





C**********************************************************************
C  Interpolate the values we need in the later computations
C**********************************************************************

C---        Find the start and end knot for the spline
            J1 = MAX(1,J-1-D)
            J2 = MIN(NRAYEL(L,M),J+D)
            JD = J2-J1

C----------------------------------------------------------------------
C  Value 1+2: Ray position and geometrical spreading  
C----------------------------------------------------------------------
            DO N=1,1
C---           Initialize the work table containing the function values
               K = J1
               DO I=1,JD
                  RWRK(I) = GSRAY(N,K,L,M)
                  K = J1+I
               ENDDO
               
c$$$               DER1 = (GSRAY(N,J1+1,L,M)-GSRAY(N,J1,L,M))/
c$$$     +              (TRAY(J1+1,L,M)-TRAY(J1,L,M))
c$$$               DER2 = (GSRAY(N,J2,L,M)-GSRAY(N,J2-1,L,M))/
c$$$     +              (TRAY(J2,L,M)-TRAY(J2-1,L,M))

               DER1 = 0.0
               DER2 = 0.0

C---           Interpolate the second derivative and find the intrp value:
               CALL SPLINE(TRAY(J1,L,M),RWRK,JD,DER1,DER2,DERIV)
               CALL SPLINT(TRAY(J1,L,M),RWRK,DERIV,JD,TIME,GS)
               GSRAY(N,MAXEL,L,M) = GS 
            ENDDO
C----------------------------------------------------------------------


C----------------------------------------------------------------------
C  Value 3: Ray slowness VERY SMALL NUMBERS,DO WE NEED TO SCALE THEM???
C----------------------------------------------------------------------

            DO N=1,3
C---           Initialize the work table containing the function values
               K = J1
               DO I=1,JD
                  RWRK(I) = PRAY(N,K,L,M)
                  K = J1+I
               ENDDO
               
               DER1 = (PRAY(N,J1+1,L,M)-PRAY(N,J1,L,M))/
     +              (TRAY(J1+1,L,M)-TRAY(J1,L,M))
               DER2 = (PRAY(N,J2,L,M)-PRAY(N,J2-1,L,M))/
     +              (TRAY(J2,L,M)-TRAY(J2-1,L,M))

C---           Interpolate the second derivative and find the intrp value:
               CALL SPLINE(TRAY(J1,L,M),RWRK,JD,DER1,DER2,DERIV)
               CALL SPLINT(TRAY(J1,L,M),RWRK,DERIV,JD,TIME,GS)
               PRAY(N,MAXEL,L,M) = GS 
            ENDDO
C----------------------------------------------------------------------


C----------------------------------------------------------------------
C  Value 4: Group velocity
C----------------------------------------------------------------------
            
            DO N=1,3
C---           Initialize the work table containing the function values
               K = J1
               DO I=1,JD
                  RWRK(I) = VGRAY(N,K,L,M)
                  K = J1+I
               ENDDO
               
               DER1 = (VGRAY(N,J1+1,L,M)-VGRAY(N,J1,L,M))/
     +              (TRAY(J1+1,L,M)-TRAY(J1,L,M))
               DER2 = (VGRAY(N,J2,L,M)-VGRAY(N,J2-1,L,M))/
     +              (TRAY(J2,L,M)-TRAY(J2-1,L,M))

C---           Interpolate the second derivative and find the intrp value:
               CALL SPLINE(TRAY(J1,L,M),RWRK,JD,DER1,DER2,DERIV)
               CALL SPLINT(TRAY(J1,L,M),RWRK,DERIV,JD,TIME,GS)
               VGRAY(N,MAXEL,L,M) = GS 
            ENDDO
C----------------------------------------------------------------------


C----------------------------------------------------------------------
C  Value 5: Matrix Q2   Q2RAY(3,2,MAXEL,NTH,NPH)
C----------------------------------------------------------------------
            DO H=1,2
               DO N=1,3
C---              Initialize the work table containing the function values
                  K = J1
                  DO I=1,JD
                     RWRK(I) = Q2RAY(N,H,K,L,M)
                     K = J1+I
                  ENDDO
               
                  DER1 = (Q2RAY(N,H,J1+1,L,M)-Q2RAY(N,H,J1,L,M))/
     +                 (TRAY(J1+1,L,M)-TRAY(J1,L,M))
                  DER2 = (Q2RAY(N,H,J2,L,M)-Q2RAY(N,H,J2-1,L,M))/
     +                 (TRAY(J2,L,M)-TRAY(J2-1,L,M))

C---              Interpolate the second derivative and find the intrp value:
                  CALL SPLINE(TRAY(J1,L,M),RWRK,JD,DER1,DER2,DERIV)
                  CALL SPLINT(TRAY(J1,L,M),RWRK,DERIV,JD,TIME,GS)
                  Q2RAY(N,H,MAXEL,L,M) = GS 
               ENDDO
            ENDDO
C----------------------------------------------------------------------


C----------------------------------------------------------------------
C  Value 6: Matrix P2   P2RAY(3,2,MAXEL,NTH,NPH)
C----------------------------------------------------------------------
            DO H=1,2
               DO N=1,3
C---              Initialize the work table containing the function values
                  K = J1
                  DO I=1,JD
                     RWRK(I) = P2RAY(N,H,K,L,M)
                     K = J1+I
                  ENDDO
               
                  DER1 = (P2RAY(N,H,J1+1,L,M)-P2RAY(N,H,J1,L,M))/
     +                 (TRAY(J1+1,L,M)-TRAY(J1,L,M))
                  DER2 = (P2RAY(N,H,J2,L,M)-P2RAY(N,H,J2-1,L,M))/
     +                 (TRAY(J2,L,M)-TRAY(J2-1,L,M))

C---              Interpolate the second derivative and find the intrp value:
                  CALL SPLINE(TRAY(J1,L,M),RWRK,JD,DER1,DER2,DERIV)
                  CALL SPLINT(TRAY(J1,L,M),RWRK,DERIV,JD,TIME,GS)
                  P2RAY(N,H,MAXEL,L,M) = GS 
               ENDDO
            ENDDO
C----------------------------------------------------------------------


C----------------------------------------------------------------------
C  Value 7: Ray polarization vector
C----------------------------------------------------------------------
            H = KMODE(1)
            DO N=1,3
C---  Initialize the work table containing the function values
               K = J1
               DO I=1,JD
                  RWRK(I) = GVRAY(N,H,K,L,M)
                  K = J1+I
               ENDDO
               
               DER1 = (GVRAY(N,H,J1+1,L,M)-GVRAY(N,H,J1,L,M))/
     +              (TRAY(J1+1,L,M)-TRAY(J1,L,M))
               DER2 = (GVRAY(N,H,J2,L,M)-GVRAY(N,H,J2-1,L,M))/
     +              (TRAY(J2,L,M)-TRAY(J2-1,L,M))
               
C---  Interpolate the second derivative and find the intrp value:
               CALL SPLINE(TRAY(J1,L,M),RWRK,JD,DER1,DER2,DERIV)
               CALL SPLINT(TRAY(J1,L,M),RWRK,DERIV,JD,TIME,GS)
               GVRAY(N,H,MAXEL,L,M) = GS 
            ENDDO

C----------------------------------------------------------------------


C----------------------------------------------------------------------
C  Value 8: KMAH index
C----------------------------------------------------------------------


            IND = 0

            DO I=1,J
               IND=IND+KINDX(I,L,M)
            ENDDO
            
            KMAH(L,M) = INT(IND)



            WRITE(6,*) ' INTERP: KMAH = ', KMAH(L,M)



C----------------------------------------------------------------------

         ENDDO   ! main loop over ray takeoff angles
      ENDDO      ! main loop over ray takeoff angles



      RETURN
      END
C-----------------------------------------------------------------------
C  END OF SUBROUTINE INTERP
C-----------------------------------------------------------------------















