C**************************************************************
C Given the arrays XA(1:N) and YA(1:N) which tabulate a function, 
C y(i)=f(x(i)), and given values YP1 and YPN for the first 
C derivative of the function at the first and last point, 
C this routine returns an array Y2(1:N) with the second derivative 
C of the function.
C
C REFERENCE  : Numerical Receipes, Chapter 3.3
C
C PROGRAMMED : Sverre Brandsberg-Dahl January 1999
C
C**************************************************************
      SUBROUTINE SPLINE(X,Y,N,YP1,YPN,Y2)
      INTEGER N,NMAX
      REAL*4 YP1,YPN,X(N),Y(N),Y2(N)
      PARAMETER (NMAX=1001)
      INTEGER I,K
      REAL*4 P,QN,SIG,UN,U(NMAX)
      IF (YP1.GT.0.99E30) THEN
         Y2(1) = 0.
         U(1) = 0.
      ELSE
         Y2(1) = -0.5
         U(1) = (3./(X(2)-X(1)))*((Y(2)-Y(1))/(X(2)-X(1))-YP1)
      ENDIF
      DO I=2,N-1
         SIG = (X(I)-X(I-1))/(X(I+1)-X(I-1))
         P = SIG*Y2(I-1)+2
         Y2(I) = (SIG-1.)/P
         U(I) = (6.*((Y(I+1)-Y(I))/(X(I+1)-X(I))-(Y(I)-Y(I-1))/
     +          (X(I)-X(I-1)))/(X(I+1)-X(I-1))-SIG*U(I-1))/P
      ENDDO
      IF (YPN.GT.0.99E30) THEN
         QN = 0.
         UN = 0.
      ELSE
         QN = 0.5
         UN = (3.0/(X(N)-X(N-1)))*(YPN-(Y(N)-Y(N-1))/(X(N)-X(N-1)))
      ENDIF
      Y2(N) = (UN-QN*U(N-1))/(QN*Y2(N-1)+1.)
      DO K=N-1,1,-1
         Y2(K) = Y2(K)*Y2(K+1)+U(K)
      ENDDO
      RETURN
      END

