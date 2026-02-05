C************************************************************************
C
C SUBROUTINE JACOBI
C
C PURPOSE: Compute Eigenvalues and Eigenvectors of a real
C          symmetric matrix by Jacobi iteration. Eigenvalues and
C          eigenvectors are not ordered on output. Use routine
C          EIGSRT to sort in descending order (w.r.t eigenvalues).          
C            
C REFERENCE: Numerical Receipes, Chapter 11.1    
C            
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : CARL SPENCER, SCHLUMBERGER CAMBRIDGE RESEARCH
C MODIFIED           : KETIL HOKSTAD DECEMBER 1998
C
C************************************************************************

      SUBROUTINE JACOBI(A,N,NP,D,V,NROT)

      IMPLICIT NONE

C---  External variables:
      INTEGER    N,NP
      INTEGER    NROT        ! Number of Jacobi rotations
      REAL*8     A(NP,NP)    ! Matrix
      REAL*8     V(NP,NP)    ! Eigen vectors
      REAL*8     D(NP)       ! Eigen values

C---  Parameters:
      INTEGER    NMAX,MAXITER
      PARAMETER (NMAX   =100)    ! Max dimension of sytem of eqs.
      PARAMETER (MAXITER=50 )    ! Max no of iterations

C---  Local variables:
      INTEGER    I,IP,IQ,J
      REAL*8     C,G,H,S,SM,T,TAU,THETA,TRESH
      REAL*8     B(NMAX),Z(NMAX)

C-----------------------------------------------------------
C  Initiallize
C-----------------------------------------------------------

      DO IP=1,N
         DO IQ=1,N
            V(IP,IQ)=0.d0
         ENDDO
         V(IP,IP)=1.d0
      ENDDO

      DO IP=1,N
         B(IP)=A(IP,IP)
         D(IP)=B(IP)
         Z(IP)=0.d0
      ENDDO


C-----------------------------------------------------------
C  Jacobi iteration: Max 50 iterations
C  The termination condition below relies on iteration
C  to machine underflow
C-----------------------------------------------------------

      NROT=0
      DO I=1,MAXITER

         SM=0.d0
         DO IP=1,N-1
            DO IQ=IP+1,N
               SM=SM+ABS(A(IP,IQ))
            ENDDO
         ENDDO

C---     Exit loop and return on successful execution:
         IF(SM.EQ.0.d0)RETURN

C---     Threshold for first 3 iterations:
         IF(I.LT.4)THEN
            TRESH=0.2d0*SM/N**2
         ELSE
            TRESH=0.d0
         ENDIF

         DO IP=1,N-1
            DO IQ=IP+1,N

               G=100.d0*ABS(A(IP,IQ))
               IF((I.GT.4).AND.(ABS(D(IP))+G.EQ.ABS(D(IP))) .AND.
     *            (ABS(D(IQ))+G.EQ.ABS(D(IQ))))THEN
                  A(IP,IQ)=0.d0
               ELSE IF(ABS(A(IP,IQ)).GT.TRESH)THEN
                  H=D(IQ)-D(IP)
                  IF(ABS(H)+G.EQ.ABS(H))THEN
                     T=A(IP,IQ)/H
                  ELSE
                     THETA=0.5d0*H/A(IP,IQ)
                     T=1./(ABS(THETA)+SQRT(1.+THETA**2))
                     IF(THETA.LT.0.d0)T=-T
                  ENDIF
                  C=1./SQRT(1+T**2)
                  S=T*C
                  TAU=S/(1.+C)
                  H=T*A(IP,IQ)
                  Z(IP)=Z(IP)-H
                  Z(IQ)=Z(IQ)+H
                  D(IP)=D(IP)-H
                  D(IQ)=D(IQ)+H
                  A(IP,IQ)=0.d0
                  DO J=1,IP-1
                     G=A(J,IP)
                     H=A(J,IQ)
                     A(J,IP)=G-S*(H+G*TAU)
                     A(J,IQ)=H+S*(G-H*TAU)
                  ENDDO
                  DO J=IP+1,IQ-1
                     G=A(IP,J)
                     H=A(J,IQ)
                     A(IP,J)=G-S*(H+G*TAU)
                     A(J,IQ)=H+S*(G-H*TAU)
                  ENDDO
                  DO J=IQ+1,N
                     G=A(IP,J)
                     H=A(IQ,J)
                     A(IP,J)=G-S*(H+G*TAU)
                     A(IQ,J)=H+S*(G-H*TAU)
                  ENDDO
                  DO J=1,N
                     G=V(J,IP)
                     H=V(J,IQ)
                     V(J,IP)=G-S*(H+G*TAU)
                     V(J,IQ)=H+S*(G-H*TAU)
                  ENDDO
                  NROT=NROT+1
               ENDIF

            ENDDO
         ENDDO

         DO IP=1,N
            B(IP)=B(IP)+Z(IP)
            D(IP)=B(IP)
            Z(IP)=0.d0
         ENDDO

      ENDDO

      WRITE(6,*) 'JACOBI: Too many iterations'
C      PAUSE 'JACOBI: Too many iterations'

C-----------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------
C   END OF SUBROUTINE JACOBI
C-----------------------------------------------------------
