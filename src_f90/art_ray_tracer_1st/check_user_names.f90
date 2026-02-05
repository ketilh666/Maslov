!**********************************************************************
!
!  IKU Seismic subroutine check_user_names
!
!
!  Purpose : 
!            
!  Subroutines called :   
!  Functions called   :   none
! 
!  Programmed         :   Ketil Hokstad January 2000
!     
!**********************************************************************

subroutine  check_user_names(uname,upars,flag_ray,flag_gmod,kasino)


   implicit none

   !--- External variables: 
   type(art_user_names),intent(in)    :: uname      ! Filenames 
   type(art_user_pars) ,intent(in)    :: upars      ! Pars from jobfile
   type(art_ray_ctrl)  ,intent(inout) :: flag_ray   ! Flag for raytracing
   type(art_geo_ctrl)  ,intent(inout) :: flag_gmod  ! Flag for geo model
   integer             ,intent(in)    :: kasino     ! Anis. symmetry type

   !--- Internal variables:
   integer          :: i
   character(len=1) :: ctmp1
   character(len=2) :: ctmp2
   character(len=3) :: ctmp3
   character(len=4) :: ctmp4

   !------------------------------------------------------------
   !  Ray tracing
   !------------------------------------------------------------

   flag_ray%lmode(1) = .false.

   ctmp4 = adjustl(uname%ray_qs1)
   flag_ray%lmode(1) = ctmp4.ne.'none' .and. ctmp4.ne.'NONE'
   ctmp4 = adjustl(uname%ray_qs2)
   flag_ray%lmode(2) = ctmp4.ne.'none' .and. ctmp4.ne.'NONE'
   ctmp4 = adjustl(uname%ray_qp)
   flag_ray%lmode(3) = ctmp4.ne.'none' .and. ctmp4.ne.'NONE'

   !------------------------------------------------------------
   !  Geological model
   !------------------------------------------------------------

   flag_gmod%lrho = .false.
   flag_gmod%lelk = .false.

   ctmp4 = adjustl(uname%rho)
   flag_gmod%lrho    = ctmp4.ne.'none' .and. ctmp4.ne.'NONE'

   do i=1,21
      ctmp4 = adjustl(uname%elk(i))
      flag_gmod%lelk(i) = ctmp4.ne.'none' .and. ctmp4.ne.'NONE'
   enddo

!-----------------------------------------------------------------------
end subroutine check_user_names
!-----------------------------------------------------------------------
