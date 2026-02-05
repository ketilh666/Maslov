!*********************************************************************         
!
!  IKU Seismic subroutine alloc_dyn_sex
!
!
!  Purpose : Allocate memory for extended dynamic raytracing system.
!            Extended means that dx/dt and dp/dt are included
!            in in the third column of matrices Q,P.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed : Ketil Hokstad October  1999 
!               Ketil Hokstad November 1999 
!               Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine alloc_dyn_sex(dsex,maxel,maxray,stat)

   implicit none

   !--- External variables: 
   type(art_dyn_sex),intent(inout) :: dsex    ! Kinetic ray data
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
   !   Allocate memeory to pointers in type art_dyn_sex
   !---------------------------------------------------------

   allocate ( dsex%qxray(1:3,1:3,1:mel,1:mray),   &
              dsex%pxray(1:3,1:3,1:mel,1:mray), stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine alloc_dyn_sex
!-----------------------------------------------------------------------

!*********************************************************************         
!
!  IKU Seismic subroutine dealloc_dyn_sex
!
!
!  Purpose : Deallocate memory for extended dynamic raytracing system.
!            Extended means that dx/dt and dp/dt are included
!            in in the third column of matrices Q,P.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed : Ketil Hokstad October  1999 
!               Ketil Hokstad November 1999 
!
!**********************************************************************
    
subroutine dealloc_dyn_sex(dsex,stat)

   implicit none

   !--- External variables: 
   type(art_dyn_sex),intent(inout) :: dsex    ! Kinetic ray data
   integer          ,optional      :: stat    ! Status variable

   !--- Internal variables:  
   integer        ::  ls

   !---------------------------------------------------------
   !  Deallocate memeory to pointers in type art_dyn_sex
   !---------------------------------------------------------

   deallocate ( dsex%qxray,   &
                dsex%pxray, stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine dealloc_dyn_sex
!-----------------------------------------------------------------------


