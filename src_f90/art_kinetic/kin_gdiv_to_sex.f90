!*********************************************************************         
!
!  IKU Seismic subroutine kin_gdiv_to_sex
!
!
!  Purpose : Store kinetic raytracing data in single 
!            precission arrays.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed  :  Ketil Hokstad November 1999 
!                 Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine kin_gdiv_to_sex(ksex,ir,ksys,jr,gsray,kindx)

   implicit none

   !--- External variables: 
   type(art_kin_sex),intent(inout) :: ksex         ! Kinetic ray data
   type(art_kin_sys),intent(in)    :: ksys         ! Kinetic ray data
   real(kry)        ,intent(in)    :: gsray(:,:,:) ! Geometrical spreading
   integer          ,intent(in)    :: kindx(  :,:) ! KMAH index
   integer          ,intent(in)    :: ir,jr        ! Current ray index

   !--- Internal variables:  
   integer :: k,iel

   !----------------------------------------------------------
   !  Store kinetic ray tracing data in single precission
   !----------------------------------------------------------

   do iel=1,ksex%nel(ir)
      ksex%gdiv(:,iel,ir) = real(gsray(:,iel,jr),kind=krx)
      ksex%kmah(  iel,ir) = kindx(iel,jr)
   enddo

!-----------------------------------------------------------------------
end subroutine kin_gdiv_to_sex
!-----------------------------------------------------------------------


