!*********************************************************************         
!
!  IKU Seismic subroutine dyn_sys_to_sex
!
!
!  Purpose : Store kinetic raytracing data in single 
!            precission arrays. The dynamic system is extended
!            with group velocity in Qx_i3 and dp_i/dt in Px_i3
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed : Ketil Hokstad  November 1999 
!               Ketil Hokstad  March   2000
!
!**********************************************************************
    
subroutine dyn_sys_to_sex(dsex,ir,dsys,ksys,jr)

   implicit none

   !--- External variables: 
   type(art_dyn_sex),intent(inout) :: dsex    ! Dynamic ray data
   type(art_dyn_sys),intent(in)    :: dsys    ! Dynamic ray data
   type(art_kin_sys),intent(in)    :: ksys    ! Kinetic ray data
   integer          ,intent(in)    :: ir,jr   

   !--- Internal variables:  
   integer :: k,iel

   !----------------------------------------------------------
   !  Store kinetic ray tracing data in single precission
   !----------------------------------------------------------

   do iel=1,ksys%nel(jr)
      dsex%qxray(:,1,iel,ir) = real(dsys%qxray(:,1,iel,jr),kind=krx)
      dsex%qxray(:,2,iel,ir) = real(dsys%qxray(:,2,iel,jr),kind=krx)
      dsex%qxray(:,3,iel,ir) = real(ksys%vgray(:  ,iel,jr),kind=krx)
      dsex%pxray(:,1,iel,ir) = real(dsys%pxray(:,1,iel,jr),kind=krx)
      dsex%pxray(:,2,iel,ir) = real(dsys%pxray(:,2,iel,jr),kind=krx)
      dsex%pxray(:,3,iel,ir) = real(ksys%etray(:  ,iel,jr),kind=krx)
   enddo

!-----------------------------------------------------------------------
end subroutine dyn_sys_to_sex
!-----------------------------------------------------------------------


