!************************************************************************
!
! Subroutine bfavre_2000
!
! Purpose: Compute a simple approximation to geometrical spreading
!          based on quantities from kinetic raytracing only.
!
! References: 
!          Hokstad, K., 1999: Geometrical spreading in a transverse 
!          isotropic medium with vertical symmetry axis. 
!          Brett Favre is the QB of Green Bay Packers.
!          Superbowl looser 1998.
!
! Subroutines called : none
! Functions called   : none
!
! Programmed : Ketil Hokstad  January 1999
!              Ketil Hokstad  March   2000
!
!************************************************************************

subroutine bfavre_2000(ksys,jr,gsray,kindx)

   implicit none

   !---  External variables:
   type(art_kin_sys) ,intent(in)  :: ksys          ! Kinetic ray system
   integer           ,intent(in)  :: jr            ! Current ray index
   real(kry)         ,intent(out) :: gsray(:,:,:)  ! Geom. spread.
   integer           ,intent(out) :: kindx(  :,:)  ! KMAH index

   !---  Internal variables:
   integer      ::  k

   !-----------------------------------------------------------------------
   !  Initialize
   !-----------------------------------------------------------------------
   
!!$   write(6,*) 'bfavre_2000: jr = ',jr
   
   !-----------------------------------------------------------------------
   !  Compute complex geometrical spreading and KMAH index along the ray:
   !   * Magnitude   in gsray(1,k,jr)
   !   * Phase angle in gsray(2,k,jr) is set to zero
   !-----------------------------------------------------------------------
   
   !---  Loop over ray elements for current ray:
   
   do k=1,ksys%nel(jr)
      
      !--- Approximate geometrical spreading:
      gsray(1,k,jr) = ksys%tray(k,jr)
      gsray(2,k,jr) = 0.0
      
      !--- KMAH index is set to zero:
      kindx(k,jr)   = 0
      
   enddo

!-----------------------------------------------------------------------
   end subroutine bfavre_2000
!-----------------------------------------------------------------------





