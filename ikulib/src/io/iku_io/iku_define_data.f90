


   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_make_ascii_hdr (Make the SEG-Y reel identification header)
   !     Kyrre Simonsen, 18/6 1998 
   !
   !**************************************************************
  subroutine iku_make_ascii_hdr( ebchdr )   
      character(len=*) :: ebchdr

!---------------------------------------------------------------------
!  Reel identification header. Part 1, the EBCDIC card image block.
!-------------------------------          1         2         3         4
!------------------------------- 1234567890123456789012345678901234567890
!---------------------------------------------------------------------
      ebchdr(       1 :   80) = 'C 1                                     '
      ebchdr(    80+1 : 2*80) = 'C 2     IKU Petroleum Research          '
      ebchdr(  2*80+1 : 3*80) = 'C 3                                     '
      ebchdr(  3*80+1 : 4*80) = 'C 4     Seismic methods section         '
      ebchdr(  4*80+1 : 5*80) = 'C 5                                     '
      ebchdr(  5*80+1 : 6*80) = 'C 6                                     '
      ebchdr(  6*80+1 : 7*80) = 'C 7                                     '
      ebchdr(  7*80+1 : 8*80) = 'C 8                                     '
      ebchdr(  8*80+1 : 9*80) = 'C 9                                     '
      ebchdr(  9*80+1 : 10*80)= 'C10                                     '
      ebchdr( 10*80+1 : 11*80)= 'C11                                     '
      ebchdr( 11*80+1 : 12*80)= 'C12                                     '
      ebchdr( 12*80+1 : 13*80)= 'C13                                     '
      ebchdr( 13*80+1 : 14*80)= 'C14                                     '
      ebchdr( 14*80+1 : 15*80)= 'C15                                     '
      ebchdr( 15*80+1 : 16*80)= 'C16                                     '
      ebchdr( 16*80+1 : 17*80)= 'C17                                     '
      ebchdr( 17*80+1 : 18*80)= 'C18                                     '
      ebchdr( 18*80+1 : 19*80)= 'C19                                     '
      ebchdr( 19*80+1 : 20*80)= 'C20                                     '
      ebchdr( 20*80+1 : 21*80)= 'C21                                     '
      ebchdr( 21*80+1 : 22*80)= 'C22                                     '
      ebchdr( 22*80+1 : 23*80)= 'C23                                     '
      ebchdr( 23*80+1 : 24*80)= 'C24                                     '
      ebchdr( 24*80+1 : 25*80)= 'C25                                     '
      ebchdr( 25*80+1 : 26*80)= 'C26                                     '
      ebchdr( 26*80+1 : 27*80)= 'C27                                     '
      ebchdr( 27*80+1 : 28*80)= 'C28                                     '
      ebchdr( 28*80+1 : 29*80)= 'C29                                     '
      ebchdr( 29*80+1 : 30*80)= 'C30                                     '
      ebchdr( 30*80+1 : 31*80)= 'C31                                     '
      ebchdr( 31*80+1 : 32*80)= 'C32                                     '
      ebchdr( 32*80+1 : 33*80)= 'C33                                     '
      ebchdr( 33*80+1 : 34*80)= 'C34                                     '
      ebchdr( 34*80+1 : 35*80)= 'C35                                     '
      ebchdr( 35*80+1 : 36*80)= 'C36                                     '
      ebchdr( 36*80+1 : 37*80)= 'C37                                     '
      ebchdr( 37*80+1 : 38*80)= 'C38                                     '
      ebchdr( 38*80+1 : 39*80)= 'C39                                     '
      ebchdr( 39*80+1 : 40*80)= 'C40                                     '

   end subroutine iku_make_ascii_hdr


   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_make_bin_hdr (Set values in the SEGY reel header.)
   !     Kyrre Simonsen, 18/6 1998 
   !
   !**************************************************************
   subroutine iku_make_bin_hdr( irehdr, nrec, dt, nt, nfold )

       integer, dimension(:)  :: irehdr
       integer                :: nrec, nt, nfold, i
       real                   :: dt

      do i = 1, IYMREH
         irehdr(i) = 0
      end do

!-----Line number:
      irehdr(IYLNUM) = 1
!-----Reel number:
      irehdr(IYRNUM) = 1
!-----Data traces/record:
      irehdr(IYDTPR) = nrec
!-----No. aux. traces/Record:
      irehdr(IYANUM) = 0
!-----Sample period (micro sec):
      irehdr(IYSINT) = nint( dt*1000 ) 
!-----No. of samples/trace:
      irehdr(IYSPTR) = nt
!-----Data format:
      irehdr(IYFORM) = 1     
!-----CDP fold:
      irehdr(IYFOLD) = nfold
!-----Measurement system:
      irehdr(IYSI) = 1


  end subroutine iku_make_bin_hdr


   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_make_trace_hdr (Set values in the SEGY trace header.)
   !     Kyrre Simonsen, 18/6 1998 
   !
   !**************************************************************
   subroutine iku_make_trace_hdr( itrhdr, ishot, ix, x, nt, dt )
       integer, dimension(:)  :: itrhdr
       integer                :: ishot, ix, nt, i
       real                   :: x, dt

      do i = 1, IYMTRH
         itrhdr(i) = 0
      end do

!-----Trace sequence:
      itrhdr(1)  = 1            
!-----Field record number (SHOT) (FFID):  
      itrhdr(3)  = ishot  
!-----Trace number in orig. field record:
      itrhdr(4)  = ix   
!-----Source point number (SOURCE):  
      itrhdr(5)  = ishot        
!-----CDP ensemble number (CDP):
      itrhdr(6)  = ishot        
!-----Trace number within cdp:
      itrhdr(7)  = ix     
!-----Trace id. code :  1 = seismic data:
      itrhdr(8)  = 1            
!-----Fold:
      itrhdr(10) = 0
!-----Offset: 
      itrhdr(12) = x
!-----Receiver group elevation:      
      itrhdr(13) = 0
!-----Surface elevation at source:
      itrhdr(14) = 0  
!-----Source depth below surface:
      itrhdr(15) = 0        
!-----Water depth at source:
      itrhdr(18) = 0
!-----Water depth at receiver:
      itrhdr(19) = 0
!-----Number of samples in (this) trace:
      itrhdr(39) = nt       
!-----Sampling interval:
      itrhdr(40) = int( dt*1000. )


   end subroutine iku_make_trace_hdr
