   !**************************************************************
   !
   !  IKU seismic I/O routines
   !  iku_get_file_unit
   !  Arild Buland 24/2-1997
   !
   !**************************************************************
   integer function iku_get_file_unit( file ) 

      type(file_type)            :: file

      iku_get_file_unit = file % unit

   end function iku_get_file_unit


   !**************************************************************
   !
   !  IKU seismic I/O routines
   !  iku_modif_file_unit
   !  Emmanuel Causse october 1997
   !
   !**************************************************************
   subroutine iku_modif_file_unit(file,unit)

   type(file_type)  ,intent(inout)        :: file
   integer          ,intent(in)           :: unit   

   file%unit = unit

   end subroutine iku_modif_file_unit


   !**************************************************************
   !
   !  IKU seismic I/O routines
   !  iku_get_file_type
   !  Ketil Hokstad 28/7-1997
   !  Emmanuel Causse 10/10-1997
   !
   !**************************************************************
   subroutine iku_get_file_type(file,unit,name,action, &
                                format,nrecl,rec,iostat,flag ) 

      type(file_type)  ,intent(in) :: file
      character(len=*) ,optional   :: name      ! File name
      character(len=*) ,optional   :: action    ! Read or Write
      character(len=*) ,optional   :: format    ! dir/seq/ascii/segy
      integer          ,optional   :: unit      ! File unit number
      integer          ,optional   :: nrecl     ! Record length (dir. access)
      integer          ,optional   :: rec       ! Record number (dir. access)
      integer          ,optional   :: iostat    ! Status variable
      logical          ,optional   :: flag      ! Flag for open flag

      if (present(unit  )) unit   = file%unit
      if (present(name  )) name   = file%name
      if (present(action)) action = file%action
      if (present(format)) format = file%format
      if (present(nrecl )) nrecl  = file%nrecl
      if (present(rec   )) rec    = file%rec
      if (present(iostat)) iostat = file%iostat
      if (present(flag  )) flag   = file%file_is_open

   end subroutine iku_get_file_type


   !**********************************************************************
   !
   !  Seismic function hamlet
   !
   !  Purpose : Check if text string is equal to NONE
   !            
   !  Subroutines called :   none
   !  Functions called   :   none
   ! 
   !  Programmed         :   Ketil Hokstad January 2002
   !
   !**********************************************************************
   
   logical function hamlet(cname)
     
     implicit none
     
     !--- External variables: 
     character(len=*) ,intent(in) :: cname
     
     !--- Internal variables:
     character(len=4) :: ctmp4
     logical          :: ibsen
     
     !--- Chech if CNAME equals NONE:
     ctmp4 = trim(adjustl(cname))
     ibsen = ctmp4.eq.'NONE' .or. &
             ctmp4.eq.'None' .or. &
             ctmp4.eq.'none'

     !--- Function value:
     hamlet = .not.ibsen

   end function hamlet
