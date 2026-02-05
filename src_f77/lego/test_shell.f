      PROGRAM TS
      IMPLICIT NONE

      INTEGER N
      PARAMETER (N=6)

      REAL    A0(N),A1(N),A2(N)
      INTEGER IND0(N),IND1(N),IND2(N)
      INTEGER I,M

      A0(1) =  3.0
      A0(2) =  6.0
      A0(3) =  2.0
      A0(4) =  1.0
      A0(5) =  4.0
      A0(6) =  5.0
      
      IND0(1) = 1
      IND0(2) = 2
      IND0(3) = 3
      IND0(4) = 4
      IND0(5) = 5
      IND0(6) = 6

      DO I=1,N
         A1(I)   = A0(I)
         A2(I)   = A0(I)
         IND1(I) = IND0(I)
         IND2(I) = IND0(I)
      ENDDO

      M = 3
      CALL SHELLA(M,A1,IND1)
      CALL SHELLD(M,A2,IND2)

      WRITE(6,1) 'Before sort:'
      WRITE(6,2) '   A0  (I)  = ',(A0(I)  ,I=1,N)
      WRITE(6,3) '   IND0(I)  = ',(IND0(I),I=1,N)
      WRITE(6,1) 'Ascending sort:'
      WRITE(6,2) '   A1  (I)  = ',(A1(I)  ,I=1,N)
      WRITE(6,3) '   IND1(I)  = ',(IND1(I),I=1,N)
      WRITE(6,1) 'Decending sort:'
      WRITE(6,2) '   A2  (I)  = ',(A2(I)  ,I=1,N)
      WRITE(6,3) '   IND2(I)  = ',(IND2(I),I=1,N)

 1    FORMAT(A)
 2    FORMAT(A,6F6.1)
 3    FORMAT(A,6I6)

      END
