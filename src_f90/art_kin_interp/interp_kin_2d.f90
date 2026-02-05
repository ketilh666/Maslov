!********************************************************************* 
!
!  IKU Seismic subroutine interp_kin_2d
!
!
!  Purpose : Interpolate 2D extended kinetic raytracing 
!            system on a regular grid
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!                  Ketil Hokstad July   2001
!
!**********************************************************************
    
subroutine interp_kin_2d(kgrid,ksex_cz,ksex,luerr)

   implicit none

   !--- External variables: 
   type(art_kin_grid),intent(inout) :: kgrid    ! Kinetic ray data on grid
   type(art_kin_sex) ,intent(in)    :: ksex_cz  ! ray data at const. z
   type(art_kin_sex) ,intent(in)    :: ksex     ! Kinetic ray data (raw)
   integer           ,intent(in)    :: luerr    ! Error message file

   !--- Internal variables: 
   integer   :: kp,ix,iy,iz,ix1,ix2
   integer   :: ir,ir1,ir2
   real(krx) :: w1,w2(2)
   real(krx) :: xgrid,x1,x2
   real(krx) :: r1(2),wgt(2)
   integer   :: i

   !-------------------------------------------------------------------
   !  Initialize on-grid ray data
   !-------------------------------------------------------------------

!!$1  format(A)
!!$2  format(A,i6)
!!$3  format(A,3i6)
!!$4  format(A,3f10.1)
!!$5  format(A,3f10.3)
!!$11  format(A,2i6)
!!$12  format(A,4f10.1)
!!$21  format(A,I6)

!!$   write(6,1) 'interp_kin_2d:'
!!$   write(6,2) 'ksex_cz%npol   = ',ksex_cz%npol
!!$   write(6,2) 'ksex_cz%naz2   = ',ksex_cz%nazi(2)
!!$   write(6,3) 'kgrid%nx,ny,nz = ',kgrid%nx,kgrid%ny,kgrid%nz
!!$   write(6,4) 'kgrid%x0       = ',(kgrid%x0(i),i=1,3)
!!$   write(6,5) 'kgrid%dx       = ',(kgrid%dx(i),i=1,3)
!!$   write(6,1) 'Initialize:'
   kgrid%npat = 0
   kgrid%time = 0.0
   kgrid%xrec = 0.0
   kgrid%prec = 0.0
   kgrid%grec = 0.0
   kgrid%gdiv = 1.0
   kgrid%kmah = 0

   !-------------------------------------------------------------------
   !  Loop over output depth and initial polar angles. 
   !  The number of azimuths is j=1.
   !  NOTE: The loop must be parallelized by hand
   !-------------------------------------------------------------------

   iy  = 1

!!$   write(6,2) 'Paralell loop: iy = ',iy

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(DYNAMIC,1)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (kgrid,ksex_cz,iy)                  &
   !$OMP    PRIVATE(ir,ir1,ir2,ix,ix1,ix2,iz,kp,       &
   !$OMP            xgrid,x1,x2,r1,wgt,w1,w2)
   do iz=1,kgrid%nz

!!$      write(6,*) ' * interp_kin_2d: Start iz = ',iz

      do ir=1,ksex_cz%npol-1

         !--- Find the grid nodes between rays ith and ith+1:
         ir1    = ir
         ir2    = ir+1
         w2(1) = ksex_cz%xray(1,iz,ir1)
         w2(2) = ksex_cz%xray(1,iz,ir2)
         x1    = minval(w2)
         x2    = maxval(w2)
         ix1   = max(int((x1-kgrid%x0(1))/kgrid%dx(1)) + 2,1)
         ix2   = min(int((x2-kgrid%x0(1))/kgrid%dx(1)) + 1,kgrid%nx)

!!$         write(6,11) '   + ir1,ir2 = ',ir1,ir2
!!$         write(6,12) '   + xr1,xr2 = ',x1,x2,w2(1),w2(2)
!!$         write(6,11) '   + ix1,ix2 = ',ix1,ix2

         !--- Loop over nodes at depth iz:
         do ix = ix1,ix2
            
!!$            write(6,21) '     - ix = ',ix
            
            !--- Compute the weights for interpolation:
            xgrid  = kgrid%x0(1) + real(ix-1)*kgrid%dx(1)
            r1(1)  = abs(xgrid-ksex_cz%xray(1,iz,ir1))
            r1(2)  = abs(xgrid-ksex_cz%xray(1,iz,ir2))
            w1     = 1.0/(r1(1)+r1(2))
            w2(1)  = r1(2)
            w2(2)  = r1(1)
            wgt(1) = w1*w2(1)
            wgt(2) = w1*w2(2)

            !--- Update multipathing counter:
            kp = min(kgrid%npat(ix,iy,iz)+1,kgrid%maxpat)
            kgrid%npat(ix,iy,iz) = kp

            !--- Linear interpolation:
            kgrid%time(    kp,ix,iy,iz) = wgt(1)*ksex_cz%time(    iz,ir1) + &
                                          wgt(2)*ksex_cz%time(    iz,ir2)
            kgrid%xrec(1:3,kp,ix,iy,iz) = wgt(1)*ksex_cz%xray(1:3,iz,ir1) + &
                                          wgt(2)*ksex_cz%xray(1:3,iz,ir2) 
            kgrid%prec(1:3,kp,ix,iy,iz) = wgt(1)*ksex_cz%pray(1:3,iz,ir1) + &
                                          wgt(2)*ksex_cz%pray(1:3,iz,ir2) 
            kgrid%grec(1:3,kp,ix,iy,iz) = wgt(1)*ksex_cz%gray(1:3,iz,ir1) + &
                                          wgt(2)*ksex_cz%gray(1:3,iz,ir2) 
            kgrid%gdiv(  1,kp,ix,iy,iz) = wgt(1)*ksex_cz%gdiv(  1,iz,ir1) + &
                                          wgt(2)*ksex_cz%gdiv(  1,iz,ir2) 
            kgrid%gdiv(  2,kp,ix,iy,iz) = 0.0
            kgrid%kmah(    kp,ix,iy,iz) = min(ksex_cz%kmah(   iz,ir1),      &
                                              ksex_cz%kmah(   iz,ir2))

         end do ! ix

      end do ! ir
!!$      write(6,*) '                End   iz = ',iz
   end do ! iz

!-----------------------------------------------------------------------
 end subroutine interp_kin_2d
!-----------------------------------------------------------------------

