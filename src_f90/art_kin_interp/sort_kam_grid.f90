!********************************************************************* 
!
!  IKU Seismic subroutine sort_kam_grid
!
!
!  Purpose : Sort kinetic data on grid in the case of multipathing.
!            The ray data are sorted on min traveltime,
!            max amplitude or none.
!            
!  Subroutines called : none
!                 f77 : SHELLA SHELLD
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!
!**********************************************************************
    
subroutine sort_kam_grid(rayfan,isize)

   implicit none

   !--- External variables: 
   type(kam_ray_fan) ,intent(inout) :: rayfan   ! Ray fan     
   type(intvec_3D)   ,intent(in)    :: isize    ! Size     of illum grid

   !--- Internal variables: 
   integer ,parameter :: maxsrt = 11
   integer            :: isort(  maxsrt)        ! Sort index array
   real(krx)          :: rsort(  maxsrt)        ! Sort work array
   real(krx)          :: gsurf(3,maxsrt)        ! Permutation work array
   real(krx)          :: psurf(3,maxsrt)        ! Permutation work array
   real(krx)          :: pdown(3,maxsrt)        ! Permutation work array
   real(krx)          :: time(   maxsrt)        ! Permutation work array
   real(krx)          :: gdiv(   maxsrt)        ! Permutation work array
   integer            :: kmah(   maxsrt)        ! Permutation work array
   integer            :: kp,mp,ix,iy,iz,npat

   !-------------------------------------------------------------------
   !  Sort kinetic raytracing data
   !   * ksort = k_min_time : Sort on decending traveltime
   !   * ksort = k_max_amp  : Sort on acending  amplitude
   !   * ksort = k_no_sort  : No sorting
   !-------------------------------------------------------------------

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(DYNAMIC,1)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (rayfan,isize)                      &
   !$OMP    PRIVATE(kp,mp,ix,iy,iz,npat,isort,rsort,   &
   !$OMP            gsurf,psurf,pdown,time,gdiv,kmah)
   do iz=1,isize%z
      do iy=1,isize%y
         do ix=1,isize%x

            npat = min(rayfan%npat(ix,iy,iz),maxsrt)

            !--- Set up index array for permutations:
            if     (rayfan%ksort .eq. k_min_time) then
               do kp=1,npat
                  rsort(kp) = rayfan%time(kp,ix,iy,iz)
               enddo
               call SHELLA(npat,rsort,isort)
            elseif (rayfan%ksort .eq. k_max_amp ) then
               do kp=1,npat
                  rsort(kp) = rayfan%gdiv(kp,ix,iy,iz)
               enddo
               call SHELLD(npat,rsort,isort)
            else
               do kp=1,npat
                  isort(kp) = kp
                  rsort(kp) = 0.0
               end do
            endif

            !--- Store current order:
            do kp=1,npat
               gsurf(1,kp) = rayfan%g_surf(kp,ix,iy,iz)%x
               gsurf(2,kp) = rayfan%g_surf(kp,ix,iy,iz)%y
               gsurf(3,kp) = rayfan%g_surf(kp,ix,iy,iz)%z
               psurf(1,kp) = rayfan%p_surf(kp,ix,iy,iz)%x
               psurf(2,kp) = rayfan%p_surf(kp,ix,iy,iz)%y
               psurf(3,kp) = rayfan%p_surf(kp,ix,iy,iz)%z
               pdown(1,kp) = rayfan%p_down(kp,ix,iy,iz)%x
               pdown(2,kp) = rayfan%p_down(kp,ix,iy,iz)%y
               pdown(3,kp) = rayfan%p_down(kp,ix,iy,iz)%z
               time(   kp) = rayfan%time(  kp,ix,iy,iz)
               gdiv(   kp) = rayfan%gdiv(  kp,ix,iy,iz)
               kmah(   kp) = rayfan%kmah(  kp,ix,iy,iz)
            enddo

            !--- Reorder:
            do kp=1,npat
               mp = isort(kp)
               rayfan%g_surf(kp,ix,iy,iz)%x = gsurf(1,mp)
               rayfan%g_surf(kp,ix,iy,iz)%y = gsurf(2,mp)
               rayfan%g_surf(kp,ix,iy,iz)%z = gsurf(3,mp)
               rayfan%p_surf(kp,ix,iy,iz)%x = psurf(1,mp)
               rayfan%p_surf(kp,ix,iy,iz)%y = psurf(2,mp)
               rayfan%p_surf(kp,ix,iy,iz)%z = psurf(3,mp)
               rayfan%p_down(kp,ix,iy,iz)%x = pdown(1,mp)
               rayfan%p_down(kp,ix,iy,iz)%y = pdown(2,mp)
               rayfan%p_down(kp,ix,iy,iz)%z = pdown(3,mp)
               rayfan%time(  kp,ix,iy,iz)   = time(   mp)
               rayfan%gdiv(  kp,ix,iy,iz)   = gdiv(   mp)
               rayfan%kmah(  kp,ix,iy,iz)   = kmah(   mp)
            enddo

         end do
      end do
   end do

!-----------------------------------------------------------------------
 end subroutine sort_kam_grid
!-----------------------------------------------------------------------





