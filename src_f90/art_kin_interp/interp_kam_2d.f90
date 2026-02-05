!********************************************************************* 
!
!  IKU Seismic subroutine interp_kam_2d
!
!
!  Purpose : Interpolate 2D extended kinetic raytracing 
!            system on a regular grid
!            Adapted fro use  with the kam migration program
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!                  Ketil Hokstad July   2001
!                  Ketil Hokstad August 2001
!
!**********************************************************************
    
subroutine interp_kam_2d(rayfan,ksex_cz,ksex, &
                         isize,corner,sampl,luerr)

   implicit none

   !--- External variables: 
   type(kam_ray_fan) ,intent(inout) :: rayfan   ! Ray fan
   type(art_kin_sex) ,intent(in)    :: ksex_cz  ! ray data at const. z
   type(art_kin_sex) ,intent(in)    :: ksex     ! Kinetic ray data (raw)
   type(intvec_3D)   ,intent(in)    :: isize    ! Size of illum grid in x,y,z
   type(vec_3D)      ,intent(in)    :: corner   ! Corner   of illum grid
   type(vec_3D)      ,intent(in)    :: sampl    ! Sampling of illum grid
   integer           ,intent(in)    :: luerr    ! Error message file

   !--- Internal variables: 
   integer   :: kp,ix,iy,iz,ix1,ix2
   integer   :: ir,ir1,ir2
   real(krx) :: w1,w2(2)
   real(krx) :: xgrid,x1,x2
   real(krx) :: r1(2),wgt(2)
   integer   :: i,iz1,iz2

   !-------------------------------------------------------------------
   !  Initialize on-grid ray data
   !-------------------------------------------------------------------

1  format(A)
2  format(A,i6)
3  format(A,3i6)
4  format(A,3f10.1)
5  format(A,3f10.3)
11  format(A,2i6)
12  format(A,4f10.1)
21  format(A,I6)

   write(6,1) 'interp_kam_2d:'
   write(6,2) 'ksex_cz%npol = ',ksex_cz%npol
   write(6,2) 'ksex_cz%naz2 = ',ksex_cz%nazi(2)
   write(6,3) 'isize        = ',isize%x,isize%y,isize%z
   write(6,4) 'corner       = ',corner%x,corner%y,corner%z
   write(6,5) 'sampl        = ',sampl%x,sampl%y,sampl%z
   write(6,2) 'maxpat       = ',rayfan%maxpat
   write(6,1) 'Initialize:'

!!$   rayfan%npat     = 0
!!$   rayfan%g_surf%x = 0.0
!!$   rayfan%g_surf%y = 0.0
!!$   rayfan%g_surf%z = 0.0
!!$   rayfan%p_surf%x = 0.0
!!$   rayfan%p_surf%y = 0.0
!!$   rayfan%p_surf%z = 0.0
!!$   rayfan%p_down%x = 0.0
!!$   rayfan%p_down%y = 0.0
!!$   rayfan%p_down%z = 0.0
!!$   rayfan%time     = 0.0
!!$   rayfan%gdiv     = 0.0
!!$   rayfan%kmah     = 0

   !-------------------------------------------------------------------
   !  Loop over output depth and initial polar angles. 
   !  The number of azimuths is j=1.
   !  NOTE: The loop must be parallelized by hand
   !-------------------------------------------------------------------

   iy  = 1

!!$   write(6,2) 'Paralell loop: iy = ',iy

   !$OMP PARALLEL DO                                     &
   !$OMP    SCHEDULE(DYNAMIC,1)                          &
   !$OMP    DEFAULT(PRIVATE)                             &
   !$OMP    SHARED (rayfan,isize,corner,sampl,           &
   !$OMP            ksex,ksex_cz,iy)                     &
   !$OMP    PRIVATE(ir,ir1,ir2,ix,ix1,ix2,iz,kp,         &
   !$OMP            xgrid,x1,x2,r1,wgt,w1,w2)
   do iz=1,isize%z

      write(6,2) ' * interp_kam_2d: Start iz = ',iz

      do ir=1,ksex_cz%npol-1

         !--- Find the grid nodes between rays ith and ith+1:
         ir1    = ir
         ir2    = ir+1
         w2(1) = ksex_cz%xray(1,iz,ir1)
         w2(2) = ksex_cz%xray(1,iz,ir2)
         x1    = minval(w2)
         x2    = maxval(w2)
         ix1   = max(int((x1-corner%x)/sampl%x) + 2,1)
         ix2   = min(int((x2-corner%x)/sampl%x) + 1,isize%x)

!!$         write(6,11) '   + ir1,ir2 = ',ir1,ir2
!!$         write(6,12) '   + xr1,xr2 = ',x1,x2,w2(1),w2(2)
!!$         write(6,11) '   + ix1,ix2 = ',ix1,ix2

         !--- Loop over nodes at depth iz:
         do ix = ix1,ix2
            
!!$            write(6,21) '     - ix = ',ix
            
            !--- Compute the weights for interpolation:
            xgrid  = corner%x + real(ix-1)*sampl%x
            r1(1)  = abs(xgrid-ksex_cz%xray(1,iz,ir1))
            r1(2)  = abs(xgrid-ksex_cz%xray(1,iz,ir2))
            w1     = 1.0/(r1(1)+r1(2))
            w2(1)  = r1(2)
            w2(2)  = r1(1)
            wgt(1) = w1*w2(1)
            wgt(2) = w1*w2(2)

            !--- Update multipathing counter:
            kp = min(rayfan%npat(ix,iy,iz)+1,rayfan%maxpat)
            rayfan%npat(ix,iy,iz) = kp

            iz1 =  1
            iz2 = iz

            !--- Linear interpolation:
            rayfan%g_surf(kp,ix,iy,iz)%x = wgt(1)*ksex%gray(   1,iz1,ir1) + &
                                           wgt(2)*ksex%gray(   1,iz1,ir2) 
            rayfan%g_surf(kp,ix,iy,iz)%y = wgt(1)*ksex%gray(   2,iz1,ir1) + &
                                           wgt(2)*ksex%gray(   2,iz1,ir2) 
            rayfan%g_surf(kp,ix,iy,iz)%z = wgt(1)*ksex%gray(   3,iz1,ir1) + &
                                           wgt(2)*ksex%gray(   3,iz1,ir2) 
            rayfan%p_surf(kp,ix,iy,iz)%x = wgt(1)*ksex%pray(   1,iz1,ir1) + &
                                           wgt(2)*ksex%pray(   1,iz1,ir2) 
            rayfan%p_surf(kp,ix,iy,iz)%y = wgt(1)*ksex%pray(   2,iz1,ir1) + &
                                           wgt(2)*ksex%pray(   2,iz1,ir2) 
            rayfan%p_surf(kp,ix,iy,iz)%z = wgt(1)*ksex%pray(   3,iz1,ir1) + &
                                           wgt(2)*ksex%pray(   3,iz1,ir2) 
            rayfan%p_down(kp,ix,iy,iz)%x = wgt(1)*ksex_cz%pray(1,iz2,ir1) + &
                                           wgt(2)*ksex_cz%pray(1,iz2,ir2) 
            rayfan%p_down(kp,ix,iy,iz)%y = wgt(1)*ksex_cz%pray(2,iz2,ir1) + &
                                           wgt(2)*ksex_cz%pray(2,iz2,ir2) 
            rayfan%p_down(kp,ix,iy,iz)%z = wgt(1)*ksex_cz%pray(3,iz2,ir1) + &
                                           wgt(2)*ksex_cz%pray(3,iz2,ir2) 
            rayfan%time(  kp,ix,iy,iz)   = wgt(1)*ksex_cz%time(  iz2,ir1) + &
                                           wgt(2)*ksex_cz%time(  iz2,ir2)
            rayfan%gdiv(  kp,ix,iy,iz)   = wgt(1)*ksex_cz%gdiv(1,iz2,ir1) + &
                                           wgt(2)*ksex_cz%gdiv(1,iz2,ir2) 
            rayfan%kmah(  kp,ix,iy,iz)   = min(   ksex_cz%kmah(  iz2,ir1),  &
                                                  ksex_cz%kmah(  iz2,ir2))

         end do ! ix

      end do ! ir
!!$      write(6,2) '                End   iz = ',iz
   end do ! iz

!-----------------------------------------------------------------------
 end subroutine interp_kam_2d
!-----------------------------------------------------------------------

