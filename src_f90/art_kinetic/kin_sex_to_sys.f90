!*********************************************************************         
!
!  IKU Seismic subroutine kin_sex_to_sys
!
!
!  Purpose : Load kinetic raytracing data in double 
!            precission arrays.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad November 1999 
!
!**********************************************************************
    
subroutine kin_sex_to_sys(ksys,jr,ksex,ir)

   implicit none

   !--- External variables: 
   type(art_kin_sys),intent(inout) :: ksys    ! Kinetic ray data
   type(art_kin_sex),intent(in)    :: ksex    ! Kinetic ray data
   integer          ,intent(in)    :: ir,jr

   !--- Internal variables:  
   integer :: k,iel

   !----------------------------------------------------------
   !  Store kinetic ray tracing data in single precission
   !----------------------------------------------------------

   k = ksex%kmode

   ksys%nel(jr) = ksex%nel(ir)

   do iel=1,ksex%nel(ir)
      ksys%tray (    iel,jr) = real(ksex%time(  iel,ir),kind=kry)
      ksys%xray (:  ,iel,jr) = real(ksex%xray(:,iel,ir),kind=kry)
      ksys%pray (:  ,iel,jr) = real(ksex%pray(:,iel,ir),kind=kry)
      ksys%gvray(:,k,iel,jr) = real(ksex%gray(:,iel,ir),kind=kry)
   enddo

!-----------------------------------------------------------------------
end subroutine kin_sex_to_sys
!-----------------------------------------------------------------------


