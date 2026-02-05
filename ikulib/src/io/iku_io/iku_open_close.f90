 !**************************************************************
   !
   !  IKU seismic I/O routines
   !  iku_open
   !  Arild Buland 25/11-1996
   !  Emmanuel Causse, 16/10-1997: include status argument
   !                   17/11-1997: check for nrecl if dir. access
   !
   !**************************************************************
   subroutine iku_open( file, name, action, format, nrecl, status ) 

      type(file_type)            :: file
      character(len=*)           :: name

      ! Optional parameters :
      character(len=*), optional :: action    ! Read or Write
      character(len=*), optional :: format    ! dir/seq/ascii/segy
      integer,          optional :: nrecl     ! Record length
      character(len=*), optional :: status    ! old/new/replace/scratch...

      ! Internal variables:
      integer :: length, lumin, lumax, lunit 
      logical :: lexist, lopened 


      1 format(a)

      file % iostat = 0 

      !-------------------------------------------------------------------
      !     Fill in optional parameters if present: 
      !-------------------------------------------------------------------

      if ( present(action) ) file % action = action   
      if ( present(format) ) file % format = format
      if ( present(nrecl) )  file % nrecl  = nrecl

      !-------------------------------------------------------------------
      !     Remove space at start and end of string:
      !-------------------------------------------------------------------

      file % name   = name
      call strstr( file%name, length ) 

      if ( length .eq. 0 ) then 
         file % unit  = -10 
         file % iostat = -10 
         return 
      end if

      !-------------------------------------------------------------------
      !     Transform all format-characters into lower case: 
      !-------------------------------------------------------------------

      call lower_case( file%format )

      !-------------------------------------------------------------------
      !     Find free unit number:
      !-------------------------------------------------------------------

      lumin =  10
      lumax = 100 

      do lunit = lumin, lumax
         inquire( unit=lunit, opened=lopened ) 
         if ( .not. lopened ) exit
      end do

      if ( lunit .gt. lumax ) then 
         file%iostat = -1 
         write(6,1)'No free unit numbers below ', lumax 
         write(6,1) file%name 
         write(6,1)'Program terminated.' 
         stop 
      end if

      file%unit  = lunit

      !-------------------------------------------------------------------
      !     Does file exist (for read mode only) ?
      !-------------------------------------------------------------------

      inquire( file=file%name, exist=lexist ) 

      if (  (file%action(1:4) .eq. 'read')  .and.  (.not. lexist) ) then 
         write(6,1)'File does not exist:' 
         write(6,1) file%name 
         write(6,1)'Program terminated from iku_open.' 
         stop 
      end if

      !-------------------------------------------------------------------
      !     Open file depending on file format:
      !-------------------------------------------------------------------

      if (file%format(1:5) .eq. 'ascii') then 

         ! Open text file (ascii):
         if ( present(status) ) then
              open( file%unit, file=file%name, status=status )
         else
            open( file%unit, file=file%name )
         end if
      elseif ( file%format(1:3) .eq. 'seq' ) then 

         ! Open fortran sequential access binary file:
         if ( present(status) ) then
            open( file%unit, file=file%name, access='sequential', &
                  form='unformatted', status=status) 
         else
            open( file%unit, file=file%name, access='sequential', &
              form='unformatted') 
         end if
      elseif ( file%format(1:3) .eq. 'dir' ) then 

         ! Open fortran direct access binary file:       
         if (.not. present(nrecl)) then
            write(6,*) 'File cannot be opened with direct access'
            write(6,*) 'if the record length nrecl is not specified.'
            write(6,*) 'Program terminated from iku_open.'
            stop  
         end if
         if ( present(status) ) then
            open( file%unit, file=file%name, access='direct', &
                  form='unformatted', recl=mdep_recl*file%nrecl, &
                  status=status)
         else
            open( file%unit, file=file%name, access='direct', &
                  form='unformatted', recl=mdep_recl*file%nrecl)
         end if
         file%rec = 0
      elseif ( file%format(1:4) .eq. 'segy' ) then 

         ! Open a dummy fortran file to hold the segy unit number:
         open( file%unit, status='scratch') 
         if ( file%action(1:5) .eq. 'write' ) then
            ! Open segy for write only:
            !call segyow( file%unit, file%name, file%iostat )
         else
            ! Open segy for read only:
            !call segyor( file%unit, file%name, file%iostat )
         end if
      else 

         ! Open text file as default:
         if ( present(status) ) then
            open( file%unit, file=file%name, status=status ) 
         else
            open( file%unit, file=file%name ) 
         end if
      end if

   file%file_is_open = .true.   

   end subroutine iku_open




   !**************************************************************
   !
   !  IKU seismic I/O routines
   !  iku_close
   !  Arild Buland 24/2-1997
   !  Emmanuel Causse 10/10-1997
   !
   !**************************************************************
   subroutine iku_close( file ) 

      type(file_type)            :: file
      integer  :: ierr

      if ( .not.file%file_is_open ) then
         write(6,*) 'The file is not open'
         write(6,*) 'Program terminated from iku_close'
         stop
      end if
      if ( file%format(1:4) .eq. 'segy' ) then 
         !call segycl( file%unit, ierr )
      end if

      close( file%unit )
      
      file%file_is_open = .false.


   end subroutine iku_close
