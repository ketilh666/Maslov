!*********************************************************************         
!
!  IKU Seismic subroutine kin_sys_to_sex
!
!
!  Purpose : Store kinetic raytracing data in single 
!            precission arrays.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed : Ketil Hokstad  November 1999 
!               Ketil Hokstad  March   2000
!
!**********************************************************************
    
subroutine kin_sys_to_sex(ksex,ir,ksys,jr)

   implicit none

   !--- External variables: 
   type(art_kin_sex),intent(inout) :: ksex    ! Kinetic ray data
   type(art_kin_sys),intent(in)    :: ksys    ! Kinetic ray data
   integer          ,intent(in)    :: ir,jr   

   !--- Internal variables:  
   integer :: k,iel

   !----------------------------------------------------------
   !  Store kinetic ray tracing data in single precission
   !----------------------------------------------------------

   k   = ksex%kmode

   ksex%nel(ir) = min(ksex%maxel,ksys%nel(jr)) 
!!$   write(6,*)'kin_sys_to_sex: ir,jr,nel = ',ir,jr,ksex%nel(ir)

   do iel=1,ksys%nel(jr)
      ksex%time(  iel,ir) = real(ksys%tray (    iel,jr),kind=krx)
      ksex%xray(:,iel,ir) = real(ksys%xray (:  ,iel,jr),kind=krx)
      ksex%pray(:,iel,ir) = real(ksys%pray (:  ,iel,jr),kind=krx)
      ksex%gray(:,iel,ir) = real(ksys%gvray(:,k,iel,jr),kind=krx)
   enddo

!-----------------------------------------------------------------------
end subroutine kin_sys_to_sex
!-----------------------------------------------------------------------







