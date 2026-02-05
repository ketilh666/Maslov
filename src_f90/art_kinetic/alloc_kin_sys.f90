!*********************************************************************         
!
!  IKU Seismic subroutine alloc_kin_sys
!
!
!  Purpose : Allocate memory for kinetic raytracing system.
!
!  Programmed  :   Ketil Hokstad October  1999 
!                  Ketil Hokstad November 1999 
!                  Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine alloc_kin_sys(ksys,maxel,maxray,stat)

   implicit none

   !--- External variables: 
   type(art_kin_sys),intent(inout) :: ksys    ! Kinetic ray data
   integer          ,optional      :: maxel   ! Max no of ray elements
   integer          ,optional      :: maxray  ! Max no of rays
   integer          ,optional      :: stat    ! Status variable

   !--- Internal variables:  
   integer        ::  ls
   integer        ::  mel,mray

   !----------------------------------------------------------
   !   Check for optional parameters
   !----------------------------------------------------------

   if (present(maxel)) then
      mel        = maxel
      ksys%maxel = maxel
   else
      mel        = ksys%maxel
   end if

   if (present(maxray)) then
      mray        = maxray
      ksys%maxray = maxray
   else
      mray        = ksys%maxray
   end if

   !---------------------------------------------------------
   !   Allocate memory to pointers in type art_kin_sys
   !---------------------------------------------------------

   allocate ( ksys%nel  (              1:mray),   &
              ksys%tray (        1:mel,1:mray),   &
              ksys%xray (    1:3,1:mel,1:mray),   &
              ksys%pray (    1:3,1:mel,1:mray),   &
              ksys%vgray(    1:3,1:mel,1:mray),   &
              ksys%etray(    1:3,1:mel,1:mray),   &
              ksys%gnray(    1:3,1:mel,1:mray),   &
              ksys%gvray(1:3,1:3,1:mel,1:mray), stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine alloc_kin_sys
!-----------------------------------------------------------------------

!*********************************************************************         
!
!  IKU Seismic subroutine dealloc_kin_sys
!
!
!  Purpose : Deallocate memory for kinetic raytracing system.
!
!  Programmed  :   Ketil Hokstad October  1999 
!                  Ketil Hokstad November 1999 
!                  Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine dealloc_kin_sys(ksys,stat)

   implicit none

   !--- External variables: 
   type(art_kin_sys),intent(inout) :: ksys    ! Kinetic ray data
   integer          ,optional      :: stat    ! Status variable

   !--- Internal variables:  
   integer        ::  ls

   !---------------------------------------------------------
   !  Deallocate memory to pointers in type art_kin_sys
   !---------------------------------------------------------

   deallocate ( ksys%nel  ,   &
                ksys%tray ,   &
                ksys%xray ,   &
                ksys%pray ,   &
                ksys%vgray,   &
                ksys%etray,   &
                ksys%gnray,   &
                ksys%gvray, stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine dealloc_kin_sys
!-----------------------------------------------------------------------






