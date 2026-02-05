      SUBROUTINE SPLINT(XA,YA,Y2A,N,X,Y)
      INTEGER N
      REAL*8 X,Y,XA(N),Y2A(N),YA(N)
C*************************************************************
C Given the arrays XA(1:N) and YA(1:N) which tabulate a function, 
C y(i)=f(x(i)), and given the array Y2A(1:N) which is the output 
C from the routine SPLINE, and given a value X this routine 
C returns a value Y=f(X)
C
C REFERENCE  : Numerical Receipes, Chapter 3.3
C
C PROGRAMMED : Sverre Brandsberg-Dahl January 1999
C 
C
C*************************************************************
      INTEGER K,KHI,KLO
      REAL*8 A,B,H
      KLO = 1
      KHI = N
 1    IF (KHI-KLO.GT.1) THEN
         K = (KHI+KLO)/2
         IF (XA(K).GT.X) THEN
            KHI = K
         ELSE
            KLO = K
         ENDIF
         GOTO 1
      ENDIF
      H = XA(KHI)-XA(KLO)
      IF (H.EQ.0.) PAUSE 'BAD XA INPUT IN SPLINT' 
      A = (XA(KHI)-X)/H
      B = (X-XA(KLO))/H
      Y = A*YA(KLO)+B*YA(KHI)
     +    +((A**3-A)*Y2A(KLO)+(B**3-B)*Y2A(KHI))*(H**2)/6.
      RETURN
      END
