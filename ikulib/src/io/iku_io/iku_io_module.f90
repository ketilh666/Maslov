!****************************************************************         
!
!  IKU seismic Input/Output routines in fortran 90
!
!  Version 1.0
!
!  Arild Buland                                                         
!  Emmanuel Causse
!  
!
!  Public routines in this file:
!                                                                       
!  A) Open and close
!
!     iku_open ( file, name, action, format, nrecl )
!
!          "action, format, nrecl" are optional parameters
!    
!     iku_close( file )
!
!
!  B) Return unit number
!
!     iku_get_file_unit( file )
!
!
!  C) Fortran binary I/O:
!
!     iku_read  ( file, traces, rec, header )     
!     iku_write ( file, traces, rec, header )
!
!          "rec" is an optional parameter used for direct access only
!          "header" is an optional parameter used for SEG-Y only
!       
!
!
!  D) SEGY-Y I/O:  *)   
!
!     iku_write_reel_hdr  ( lout, ascii_hdr, bin_hdr )
!     iku_write_trace_hdr ( lout, trace_hdr )
!     iku_make_ascii_hdr  ( ascii_hdr )
!     iku_make_bin_hdr    ( bin_hdr, nrec, dt, nt, nfold )
!     iku_make_trace_hdr  ( trace_hdr, ishot, ix, x, nt, dt )
!
!     iku_readhdr ( file, ascii_buf, bin_buf )
!     iku_writehdr( file, ascii_buf, bin_buf )
!     iku_readtr  ( file, tr_hdr, tr_data, dim )   (Reads one trace  (1 dim))
!     iku_writetr ( file, tr_hdr, tr_data, dim )   (Writes one trace (1 dim))
!
!
!
!  Update history:
!  ===============
!  - Lengde paa filnavn oekt til 300 16 Jan. 1998 (FM)
!  - *) Punkt D og tillegg i punkt C gjort juni 1998 (ks)
!
!
!**************************************************************         


module iku_io_module

  use iku_machine_dependent_module
    
   implicit none 
   private
   public :: file_type,                                & ! Type definition
             iku_open, iku_close,                      & ! Subroutines (iku_open_close)
             iku_read, iku_readhdr, iku_readtr,        & !      "      (iku_read)
             iku_write, iku_writehdr, iku_writetr,     & !      "      (iku_write)
             iku_get_file_unit,iku_modif_file_unit,    & !      "      (iku_file_type)
             iku_write_reel_hdr, iku_write_trace_hdr,  & !      "      (iku_print_data)
             iku_write_file,                           & !      "      (      "       )
             iku_make_ascii_hdr, iku_make_bin_hdr,     & !      "      (iku_define_data)
             iku_make_trace_hdr,                       & !      "      (      "        )
             iku_get_file_type, hamlet,                & ! Functions   (iku_file_type) 
             lnm, lfg, lu_min, lu_max                    ! Parameters

   integer, parameter :: lnm     = 300  ! Length of filenames
   integer, parameter :: lfg     =  10  ! Length of character flags
   integer, parameter :: lu_min  =  10  ! Minimum unit number
   integer, parameter :: lu_max  = 100  ! Minimum unit number

   type file_type
    private
      integer            :: unit      ! unit number
      character(len=lnm) :: name      ! file name
      character(len=lfg) :: action    ! read, write
      character(len=lfg) :: format    ! ascii, seq, dir, segy, ...
      integer            :: nrecl     ! record length (dir. access)
      integer            :: rec       ! record number (dir. access)
      integer            :: iostat    ! error status 
      logical            :: file_is_open
   end type file_type

!
! The following constants are spesific for the SEG-Y IO routines :
! _________________________________________________________________________________________

! Parameters:

   integer, parameter :: IYMREC  = 64000 ! Maximal size of file record in bytes .       
   integer, parameter :: IYMEBC  =  3200 ! Dimension of Reel Character header.                
   integer, parameter :: IYMREH  =   197 ! Dimension of Reel header array.                    
   integer, parameter :: IYMTRH  =   101 ! Dimension of Trace header array.                   
                                                                     
! Reel identification header indexes: 
                                                                     
   integer, parameter :: IYLNUM  =  2   ! Line number.      
   integer, parameter :: IYRNUM  =  3   ! Reel number.              
   integer, parameter :: IYDTPR  =  4   ! Number of data traces per record.            
   integer, parameter :: IYANUM  =  5   ! Number of aux. traces per record.           
   integer, parameter :: IYSINT  =  6   ! Sample interval in micro seconds.           
   integer, parameter :: IYSPTR  =  8   ! Number of samples per data trace.          
   integer, parameter :: IYFORM  = 10   ! Data sample format code.                
   integer, parameter :: IYFOLD  = 11   ! CDP fold.                   
   integer, parameter :: IYSI    = 25   ! Measurement system (meters/feet)       
                   
                                                                     
!  Trace identification header indexes:
                                                                     
   integer, parameter :: IYTSEQ  =  1   !   1-  4: Trace sequence number within line
   integer, parameter :: IYOFRN  =  3   !   9- 12: Original field record number. 
   integer, parameter :: IYOFTN  =  4   !  13- 16: Trace number within the orig. field record.
   integer, parameter :: IYCMPN  =  6   !  21- 24: CMP number.
   integer, parameter :: IYTRID  =  8   !  29- 30: Trace identification code. (1=seism. data) 
   integer, parameter :: IYDREC  = 36   ! 109-110: Delay recording time (ms).   
   integer, parameter :: IYNOSA  = 39   ! 115-116: Number of samples in this trace. 
   integer, parameter :: IYDTTR  = 40   ! 117-118: Sample int. in micro s. for this trace.   

! _____________________________________________________________________________________


   interface iku_read
      module procedure iku_read_1d
      module procedure iku_read_2d
      module procedure iku_read_3d
      module procedure iku_read_4d
      module procedure iku_read_3d_int
      module procedure iku_read_4d_int
   end interface

   interface iku_write
      module procedure iku_write_1d
      module procedure iku_write_2d
      module procedure iku_write_3d
      module procedure iku_write_4d
      module procedure iku_write_3d_int
      module procedure iku_write_4d_int
   end interface

! _____________________________________________________________________________________


contains
  
   include 'iku_open_close.f90'
   include 'iku_file_type.f90'
   include 'iku_read.f90'
   include 'iku_write.f90'
   include 'iku_print_data.f90'
   include 'iku_define_data.f90'
   include 'iku_subroutines.f90'

end module iku_io_module







