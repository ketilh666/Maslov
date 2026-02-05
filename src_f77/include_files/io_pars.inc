C***********************************************************************
C INCLUDE FILE io_pars.inc
C
C PURPOSE: Define record lengths and pointers to different
C          ray theoretical quantities on I/O disk files.
C
C PROGRAMMED : KETIL HOKSTAD DECEMBER 1998
C
C***********************************************************************

C-----------------------------------------------------------------------
C  Record lengths for ray data on diskfiles
C-----------------------------------------------------------------------

       INTEGER     NIO1,NIO2
       PARAMETER ( NIO1=51 )    ! Record length on disk file
       PARAMETER ( NIO2=2  )    ! Used in debugging

C-----------------------------------------------------------------------
C  Parameters controling the position of the different ray theoretical
C  quantities in the disk file record (constant record length).
C  The parameters define offset in the record, hence IADR=IOFF+1.
C  Example: The offset for slowness is KP=4, which means that slowness 
C           components p1,p2,p3 are stored in positions 5,6,7.
C-----------------------------------------------------------------------

       INTEGER KT,KX,KP,KVG,KET,KGN1,KGN2,KGN3,KGV1,KGV2,KGV3
       INTEGER KQ1,KP1,KQ2,KP2,KGS 
       PARAMETER ( KT   =  0 )  !  1: Travel time    (scalar    )
       PARAMETER ( KX   =  1 )  !  2: Ray path       (3-vector  )
       PARAMETER ( KP   =  4 )  !  3: Ray slowness   (3-vector  )
       PARAMETER ( KVG  =  7 )  !  4: Group velocity (3-vector  )
       PARAMETER ( KET  = 10 )  !  5: dp/dT          (3-vector  )
       PARAMETER ( KGN1 = 13 )  !  6: Eigenvalue 1   (scalar    )
       PARAMETER ( KGN2 = 14 )  !  7: Eigenvalue 2   (scalar    )
       PARAMETER ( KGN3 = 15 )  !  8: Eigenvalue 3   (scalar    )
       PARAMETER ( KGV1 = 16 )  !  9: Eigenvector 1  (3-vector  )
       PARAMETER ( KGV2 = 19 )  ! 10: Eigenvector 2  (3-vector  )
       PARAMETER ( KGV3 = 22 )  ! 11: Eigenvector 3  (3-vector  )
       PARAMETER ( KGS  = 25 )  ! 12: Geom spreading (2-vector  )
       PARAMETER ( KQ1  = 27 )  ! 13: Q1 cartesian   (3x2-matrix)
       PARAMETER ( KP1  = 33 )  ! 14: P1 cartesian   (3x2-matrix)
       PARAMETER ( KQ2  = 39 )  ! 15: Q2 cartesian   (3x2-matrix)
       PARAMETER ( KP2  = 45 )  ! 16: P2 cartesian   (3x2-matrix)

C***********************************************************************
C   END OF INCLUDE FILE io_pars.inc
C***********************************************************************
