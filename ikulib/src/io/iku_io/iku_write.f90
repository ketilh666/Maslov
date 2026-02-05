   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_1d
   !     Arild Buland 10/02/97
   !     Emmanuel Causse 10/10-1997
   !     Emmanuel Causse 05/04/2000 (iku_write_4d added)
   !**************************************************************
   subroutine iku_write_1d( file, trace, rec, header )
      type(file_type)                 :: file
      real, dimension(:)              :: trace
      integer, optional               :: rec
      integer, dimension(:), optional :: header
      integer, dimension(1)           :: header_dummy

      integer            :: i, n_1
      integer            :: file_unit_sgi,file_iostat_sgi
      integer            :: howmany
      integer, parameter :: WRITE_GIVEN_HDR     = 1
      integer, parameter :: WRITE_DEFAULT_HDR   = 0
      
      file_unit_sgi=file%unit
      file_iostat_sgi=file%iostat

      n_1 = size(trace,1)

      if (.not.file%file_is_open) then
         write(6,*) 'File is not open'

         write(6,*) 'Program terminated from iku_write'
         stop
      end if

      if ( file%format(1:3) .eq. 'seq' ) then
         write( file_unit_sgi, iostat=file_iostat_sgi )   trace

      else if ( file%format(1:3) .eq. 'dir' ) then
         if ( present(rec) ) then
            file%rec = rec
         else
            file%rec = file%rec + 1
         end if
         write( file_unit_sgi , rec=file%rec, iostat=file_iostat_sgi )   trace

      else if ( file%format(1:4) .eq. 'segy' ) then
         howmany = 1
         if ( present(header) ) then
            !call segy_write( file_unit_sgi, header, trace, n_1, howmany, WRITE_GIVEN_HDR )
         else
            !call segy_write( file_unit_sgi, header_dummy, trace, n_1, howmany, WRITE_DEFAULT_HDR )
         endif

      else   ! Default ascii:
         do i = 1, n_1
            write( file_unit_sgi, *, iostat=file_iostat_sgi )  trace(i) 
         end do

      end if

   end subroutine iku_write_1d




   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_2d
   !     Arild Buland 10/02/97
   !     Emmanuel Causse 10/10-1997
   !
   !**************************************************************
   subroutine iku_write_2d( file, traces, rec, header )
      type(file_type)                   :: file
      real, dimension(:,:)              :: traces
      integer, optional                 :: rec
      integer, dimension(:,:), optional :: header
      integer, dimension(1)             :: header_dummy

      integer             :: i, j, n_1, n_2
      integer            :: file_unit_sgi,file_iostat_sgi
      integer            :: howmany
      integer, parameter :: WRITE_GIVEN_HDRS     = 1
      integer, parameter :: WRITE_DEFAULT_HDRS   = 0
        


      file_unit_sgi=file%unit
      file_iostat_sgi=file%iostat

      n_1 = size(traces,1)
      n_2 = size(traces,2)

      if (.not.file%file_is_open) then
         write(6,*) 'File is not open'

         write(6,*) 'Program terminated from iku_write'
         stop
      end if

      if ( file%format(1:3) .eq. 'seq' ) then
         do j = 1, n_2
            write( file_unit_sgi, iostat=file_iostat_sgi ) &
                 ( traces(i,j) , i = 1, n_1 )
         enddo
      else if ( file%format(1:3) .eq. 'dir' ) then
         if ( present(rec) ) then
            file%rec = rec
         else
            file%rec = file%rec + 1
         end if
         write( file_unit_sgi, rec=file%rec, iostat=file_iostat_sgi )   traces

      else if ( file%format(1:4) .eq. 'segy' ) then
         howmany = n_2
         if ( present(header) ) then
            !call segy_write( file_unit_sgi, header, traces, n_1, howmany, WRITE_GIVEN_HDRS )
         else
            !call segy_write( file_unit_sgi, header_dummy, traces, n_1, howmany, WRITE_DEFAULT_HDRS )
         endif

      else   ! Default ascii:
         do j = 1, n_2
            do i = 1, n_1
               write( file_unit_sgi, *, iostat=file_iostat_sgi )  traces(i,j) 
            end do
         end do

      end if

   end subroutine iku_write_2d


   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_3d
   !     Arild Buland 10/02/97
   !     Emmanuel Causse 10/10-1997
   !
   !**************************************************************
   subroutine iku_write_3d( file, traces, rec, header ) 
      type(file_type)                      :: file
      real, dimension(:,:,:)               :: traces
      integer, optional                    :: rec
      integer, dimension(:,:,:), optional  :: header
      integer, dimension(1)                :: header_dummy

      integer            :: i, j, k, n_1, n_2, n_3
      integer            :: file_unit_sgi,file_iostat_sgi
      integer            :: howmany
      integer, parameter :: WRITE_GIVEN_HDRS     = 1
      integer, parameter :: WRITE_DEFAULT_HDRS   = 0

      
      file_unit_sgi=file%unit
      file_iostat_sgi=file%iostat
 
      n_1 = size(traces,1)
      n_2 = size(traces,2)
      n_3 = size(traces,3)      

      if (.not.file%file_is_open) then
         write(6,*) 'File is not open'

         write(6,*) 'Program terminated from iku_write'
         stop
      end if

      if ( file%format(1:3) .eq. 'seq' ) then
         do k = 1, n_3
            do j = 1, n_2
               write( file_unit_sgi, iostat=file_iostat_sgi ) &
                    ( traces(i,j,k) , i = 1, n_1 )
            end do
         enddo

      else if ( file%format(1:3) .eq. 'dir' ) then
         if ( present(rec) ) then
            file%rec = rec
         else
            file%rec = file%rec + 1
         end if
         write( file_unit_sgi, rec=file%rec, iostat=file_iostat_sgi )   traces

      else if ( file%format(1:4) .eq. 'segy' ) then
         howmany = n_2*n_3
         if ( present(header) ) then
            !call segy_write( file_unit_sgi, header, traces, n_1, howmany, WRITE_GIVEN_HDRS )
         else
            !call segy_write( file_unit_sgi, header_dummy, traces, n_1, howmany, WRITE_DEFAULT_HDRS )
         endif

      else   ! Default ascii:
         do k = 1, n_3
            do j = 1, n_2
               do i = 1, n_1
                  write( file_unit_sgi, *, iostat=file_iostat_sgi )  traces(i,j,k) 
               end do
            end do
         end do

      end if

   end subroutine iku_write_3d

   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_4d
   !     Emmanuel Causse 06/04-2000
   !
   !**************************************************************
   subroutine iku_write_4d( file, traces, rec, header ) 
      type(file_type)                       :: file
      real, dimension(:,:,:,:)              :: traces
      integer, optional                     :: rec
      integer, dimension(:,:,:,:), optional :: header
      integer, dimension(1)                 :: header_dummy

      integer            :: i, j, k, l, n_1, n_2, n_3, n_4
      integer            :: file_unit_sgi,file_iostat_sgi
      integer            :: howmany
      integer, parameter :: WRITE_GIVEN_HDRS     = 1
      integer, parameter :: WRITE_DEFAULT_HDRS   = 0

      
      file_unit_sgi=file%unit
      file_iostat_sgi=file%iostat
 
      n_1 = size(traces,1)
      n_2 = size(traces,2)
      n_3 = size(traces,3)      
      n_4 = size(traces,4)      

      if (.not.file%file_is_open) then
         write(6,*) 'File is not open'

         write(6,*) 'Program terminated from iku_write'
         stop
      end if

      if ( file%format(1:3) .eq. 'seq' ) then
         do l = 1, n_4
         do k = 1, n_3
            do j = 1, n_2
               write( file_unit_sgi, iostat=file_iostat_sgi ) &
                    ( traces(i,j,k,l) , i = 1, n_1 )
            end do
         enddo
         enddo

      else if ( file%format(1:3) .eq. 'dir' ) then
         if ( present(rec) ) then
            file%rec = rec
         else
            file%rec = file%rec + 1
         end if
         write( file_unit_sgi, rec=file%rec, iostat=file_iostat_sgi )   traces

      else if ( file%format(1:4) .eq. 'segy' ) then
         howmany = n_2*n_3*n_4
         if ( present(header) ) then
            !call segy_write( file_unit_sgi, header, traces, n_1, howmany, WRITE_GIVEN_HDRS )
         else
            !call segy_write( file_unit_sgi, header_dummy, traces, n_1, howmany, WRITE_DEFAULT_HDRS )
         endif

      else   ! Default ascii:
         do l = 1, n_4
         do k = 1, n_3
            do j = 1, n_2
               do i = 1, n_1
                  write( file_unit_sgi, *, iostat=file_iostat_sgi )  traces(i,j,k,l) 
               end do
            end do
         end do
         end do

      end if

   end subroutine iku_write_4d

   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_3d_int
   !     Emmanuel Causse 07/11-2000
   !     Comments: the same, but for integers
   !**************************************************************
   subroutine iku_write_3d_int( file, traces, rec, header ) 
      type(file_type)                      :: file
      integer, dimension(:,:,:)            :: traces
      integer, optional                    :: rec
      integer, dimension(:,:,:), optional  :: header
      integer, dimension(1)                :: header_dummy

      integer            :: i, j, k, n_1, n_2, n_3
      integer            :: file_unit_sgi,file_iostat_sgi
      integer            :: howmany
      integer, parameter :: WRITE_GIVEN_HDRS     = 1
      integer, parameter :: WRITE_DEFAULT_HDRS   = 0

      
      file_unit_sgi=file%unit
      file_iostat_sgi=file%iostat
 
      n_1 = size(traces,1)
      n_2 = size(traces,2)
      n_3 = size(traces,3)      

      if (.not.file%file_is_open) then
         write(6,*) 'File is not open'

         write(6,*) 'Program terminated from iku_write'
         stop
      end if

      if ( file%format(1:3) .eq. 'seq' ) then
         do k = 1, n_3
            do j = 1, n_2
               write( file_unit_sgi, iostat=file_iostat_sgi ) &
                    ( traces(i,j,k) , i = 1, n_1 )
            end do
         enddo

      else if ( file%format(1:3) .eq. 'dir' ) then
         if ( present(rec) ) then
            file%rec = rec
         else
            file%rec = file%rec + 1
         end if
         write( file_unit_sgi, rec=file%rec, iostat=file_iostat_sgi )   traces

      else   ! Default ascii:
         do k = 1, n_3
            do j = 1, n_2
               do i = 1, n_1
                  write( file_unit_sgi, *, iostat=file_iostat_sgi )  traces(i,j,k) 
               end do
            end do
         end do

      end if

   end subroutine iku_write_3d_int

   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_write_4d_int
   !     Emmanuel Causse 07/11-2000
   !
   !**************************************************************
   subroutine iku_write_4d_int( file, traces, rec, header ) 
      type(file_type)                       :: file
      integer, dimension(:,:,:,:)              :: traces
      integer, optional                     :: rec
      integer, dimension(:,:,:,:), optional :: header
      integer, dimension(1)                 :: header_dummy

      integer            :: i, j, k, l, n_1, n_2, n_3, n_4
      integer            :: file_unit_sgi,file_iostat_sgi
      integer            :: howmany
      integer, parameter :: WRITE_GIVEN_HDRS     = 1
      integer, parameter :: WRITE_DEFAULT_HDRS   = 0

      
      file_unit_sgi=file%unit
      file_iostat_sgi=file%iostat
 
      n_1 = size(traces,1)
      n_2 = size(traces,2)
      n_3 = size(traces,3)      
      n_4 = size(traces,4)      

      if (.not.file%file_is_open) then
         write(6,*) 'File is not open'

         write(6,*) 'Program terminated from iku_write'
         stop
      end if

      if ( file%format(1:3) .eq. 'seq' ) then
         do l = 1, n_4
         do k = 1, n_3
            do j = 1, n_2
               write( file_unit_sgi, iostat=file_iostat_sgi ) &
                    ( traces(i,j,k,l) , i = 1, n_1 )
            end do
         enddo
         enddo

      else if ( file%format(1:3) .eq. 'dir' ) then
         if ( present(rec) ) then
            file%rec = rec
         else
            file%rec = file%rec + 1
         end if
         write( file_unit_sgi, rec=file%rec, iostat=file_iostat_sgi )   traces

      else   ! Default ascii:
         do l = 1, n_4
         do k = 1, n_3
            do j = 1, n_2
               do i = 1, n_1
                  write( file_unit_sgi, *, iostat=file_iostat_sgi )  traces(i,j,k,l) 
               end do
            end do
         end do
         end do

      end if

   end subroutine iku_write_4d_int

   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_writehdr
   !     Kyrre Simonsen, 18/6 1998 
   !
   !**************************************************************
 
 subroutine iku_writehdr ( file , ascii_buf, bin_buf )
     type(file_type)       :: file
     character(len=*)      :: ascii_buf
     integer,dimension(:)  :: bin_buf
   
     integer     :: err
 
     !call segywh( file%unit , ascii_buf, bin_buf, err )
 end subroutine iku_writehdr



   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     iku_writetr
   !     Kyrre Simonsen, 18/6 1998 
   !
   !**************************************************************
  
 subroutine iku_writetr( file, tr_buf, data_buf, dim )
     
     type(file_type)         :: file
     integer, dimension(:)   :: tr_buf
     real,    dimension(:)   :: data_buf   
     integer                 :: dim
 
     integer       :: err
  
    !call segywr( file%unit , tr_buf, data_buf, dim, err )

 end subroutine iku_writetr
