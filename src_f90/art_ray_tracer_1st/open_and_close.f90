!********************************************************************* !
!  IKU Seismic subroutine open_ray_files
!
!  Purpose : Open disk files for ray tracing data
!
!  Programmed  :   Ketil Hokstad January 2000
!
!**********************************************************************
    
subroutine open_ray_files(files,flag,name_kin,name_hd,action,form,nrecl)

   type(art_ray_files) ,intent(out) :: files
   type(art_ray_ctrl)  ,intent(in)  :: flag
   character(len=*)    ,intent(in)  :: name_kin(3)
   character(len=*)    ,intent(in)  :: name_hd(3)
   character(len=*)    ,intent(in)  :: action    ! Read/write
   character(len=*)    ,intent(in)  :: form      ! dir/seq for ray
   integer             ,optional    :: nrecl     ! Rec length (dir only)

   !--- Internal variables:
   integer :: mrecl
   integer :: j

   !-----------------------------------------------------------------
   !   Check optional parameters
   !-----------------------------------------------------------------

   if (present(nrecl)) mrecl = nrecl

   !--------------------------------------------------------------------
   !   Open ray data and ray header file
   !--------------------------------------------------------------------

   do j=1,3
      if (flag%lmode(j)) then
         call iku_open(files%kin(j),name_kin(j),action,form,mrecl)
         call iku_open(files%hd (j),name_hd (j),action,'ascii')
      end if
   end do

!-----------------------------------------------------------------------
end subroutine open_ray_files
!-----------------------------------------------------------------------

!*********************************************************************  !
!  IKU Seismic subroutine close_ray_files
!
!  Purpose : Close disk files for ray tracing data
!
!  Programmed  :   Ketil Hokstad January 2000
!
!**********************************************************************
    
subroutine close_ray_files(files,flag)

   type(art_ray_files) ,intent(out) :: files
   type(art_ray_ctrl)  ,intent(in)  :: flag

   !--- Internal variables:
   integer :: j

   !--------------------------------------------------------------------
   !   Close geological model files
   !--------------------------------------------------------------------

   do j=1,3
      if (flag%lmode(j)) then
         call iku_close(files%kin(j))
         call iku_close(files%hd (j))
      end if
   end do

!-----------------------------------------------------------------------
end subroutine close_ray_files
!-----------------------------------------------------------------------

