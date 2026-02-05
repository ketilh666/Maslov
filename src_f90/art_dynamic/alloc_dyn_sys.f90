!*********************************************************************         
!
!  IKU Seismic subroutine alloc_dyn_sys
!
!
!  Purpose : Allocate memory for dynamic raytracing system.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed : Ketil Hokstad October  1999 
!               Ketil Hokstad November 1999 
!               Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine alloc_dyn_sys(dsys,maxel,maxray,stat)

   implicit none

   !--- External variables: 
   type(art_dyn_sys),intent(inout) :: dsys    ! Kinetic ray data
   integer          ,intent(in)    :: maxel   ! Max no of ray elements
   integer          ,intent(in)    :: maxray  ! No of initial angles
   integer          ,optional      :: stat    ! Status variable

   !--- Internal variables:  
   integer        ::  ls
   integer        ::  mel,mray

   !----------------------------------------------------------
   !   Check for optional parameters
   !----------------------------------------------------------

   mray = maxray
   mel  = maxel

   !---------------------------------------------------------
   !   Allocate memeory to pointers in type art_dyn_sys
   !---------------------------------------------------------

   allocate ( dsys%qxray (1:3,1:2,1:mel,1:mray),   &
              dsys%pxray (1:3,1:2,1:mel,1:mray), stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine alloc_dyn_sys
!-----------------------------------------------------------------------

!*********************************************************************         
!
!  IKU Seismic subroutine dealloc_dyn_sys
!
!  Purpose : Deallocate memory for dynamic raytracing system.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad October  1999 
!                  Ketil Hokstad November 1999 
!
!**********************************************************************
    
subroutine dealloc_dyn_sys(dsys,stat)

   implicit none

   !--- External variables: 
   type(art_dyn_sys),intent(inout) :: dsys    ! Kinetic ray data
   integer          ,optional      :: stat    ! Status variable

   !--- Internal variables:  
   integer        ::  ls

   !---------------------------------------------------------
   !  Deallocate memeory to pointers in type art_dyn_sys
   !---------------------------------------------------------

   deallocate ( dsys%qxray,   &
                dsys%pxray, stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine dealloc_dyn_sys
!-----------------------------------------------------------------------



