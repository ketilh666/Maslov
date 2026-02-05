
   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_reel_hdr
   !     (Write selected parameters from a segy file header)
   !     Kyrre Simonsen, 18/6 1998
   !
   !**************************************************************
   subroutine iku_write_reel_hdr( lout, ebchdr, irehdr )
      integer                 :: lout       
      character(len=*)        :: ebchdr      
      integer,   dimension(:) :: irehdr 
      integer                 :: i,j

      write (lout,*) ' EBCDIC Reel Header: ' 
      write (lout,'()') 

      do j=0,39         
         write(lout,'(A80)') ebchdr(80*j+1:80*j+80)
      end do
     
      write(lout,*) '/**/'
      write(lout,*) ' Binary Reel Header (selected fields):'
      write(lout,*) ' Line number               : ',irehdr(IYLNUM)
      write(lout,*) ' Reel number               : ',irehdr(IYRNUM)
      write(lout,*) ' Data traces/Record        : ',irehdr(IYDTPR)
      write(lout,*) ' AUX. traces/Record        : ',irehdr(IYANUM)
      write(lout,*) ' Sample interval(Micro sec): ',irehdr(IYSINT)
      write(lout,*) ' No. samples/trace         : ',irehdr(IYSPTR)
      write(lout,*) ' Data format               : ',irehdr(IYFORM)
      write(lout,*) ' CDP Fold                  : ',irehdr(IYFOLD)
      write(lout,*) ' Measurement system        : ',irehdr(IYSI  )
      write(lout,'()')

   end subroutine iku_write_reel_hdr


   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_trace_hdr
   !     (Write selected parameters from segy trace header)
   !     Kyrre Simonsen, 18/6 1998 
   !
   !**************************************************************
   subroutine iku_write_trace_hdr( lout, itrhdr )
      integer               :: lout
      integer, dimension(:) :: itrhdr

      write(lout,*)' Binary Trace Header:'
      write(lout,*)' Trace Seq. number within line :',itrhdr(1)
      write(lout,*)' Orig. field Rec.No (SHOT) FFID:',itrhdr(3)
      write(lout,*)' Trace No    (CH/CMP)      CHAN:',itrhdr(4)
      write(lout,*)' Source point number     SOURCE:',itrhdr(5)
      write(lout,*)' CDP ensemble number        CDP:',itrhdr(6)
      write(lout,*)' Trace No within CDP           :',itrhdr(7)
      write(lout,*)' Trace ID code                 :',itrhdr(8)
      write(lout,*)' Fold                          :',itrhdr(10)
      write(lout,*)' Offset                  OFFSET:',itrhdr(12) 
      write(lout,*)' Delay recording time (ms)     :',itrhdr(36)
      write(lout,*)' No. Samples                   :',itrhdr(39)
      write(lout,*)' Samp. Interval                :',itrhdr(40)
      write(lout,'()')

    end subroutine iku_write_trace_hdr


   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_file(Write parameters in file_type)
   !     Kyrre Simonsen, 18/6 1998 
   !
   !**************************************************************
 subroutine iku_write_file( lout, file )
      integer           :: lout
      type(file_type)   :: file

      write (lout,*) 'unit no   : ',file%unit      ! unit number
      write (lout,*) 'file name : ',file%name      ! file name
      write (lout,*) 'read/write: ',file%action    ! read, write
      write (lout,*) 'format    : ',file%format    ! ascii, seq, dir, segy, ...
      write (lout,*) 'record len: ',file%nrecl     ! record length (dir. access)
      write (lout,*) 'record no : ',file%rec       ! record number (dir. access)
      write (lout,*) 'iostat    : ',file%iostat    ! error status 
      write (lout,*) 'open?     : ',file%file_is_open

    end subroutine iku_write_file
