!********************************************************************* 
!
!  IKU Seismic subroutine interp_kam_3d
!
!
!  Purpose : Interpolate 3D extended kinetic raytracing 
!            system on a regular grid.
!            Adapted fro use  with the kam migration program
!
!  Subroutines called : three_corners
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!                  Ketil Hokstad August 2001
!
!**********************************************************************
    
subroutine interp_kam_3d(rayfan,ksex_cz,ksex, &
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

   !--- Parameters:
   integer   ,parameter :: nedge   = 3
   integer   ,parameter :: ncomp   = 2
   real(krx) ,parameter :: rdymin  = 0.1

   !--- Internal variables: 
   logical   :: lwrite
   logical   :: lred,lblack
   integer   :: jinsect,ninsect
   integer   :: jtrek,ntrek
   integer   :: ip,npol,naz2
   integer   :: ir1,ir2,jr1,jr2,kr1,kr2,kr3
   integer   :: ie1,ie2,ie3,kp
   integer   :: ix,iy,iz,ix1,ix2,iy1,iy2
   integer   :: nx,ny
   integer   :: isort(nedge)
   real(krx) :: vtail(ncomp,nedge),vhead(ncomp,nedge),vertx(ncomp,nedge)
   real(krx) :: wgt(nedge),wx(nedge),wy(nedge)
   real(krx) :: xgrid(ncomp),x1(ncomp),x2(ncomp)
   real(krx) :: x0grid(ncomp),dxgrid(ncomp)
   real(krx) :: dymin

   character(len=5) :: color

   !-------------------------------------------------------------------
   !  Initialize
   !-------------------------------------------------------------------

!!$   kgrid%npat = 0
!!$   kgrid%time = 0.0
!!$   kgrid%xrec = 0.0
!!$   kgrid%prec = 0.0
!!$   kgrid%grec = 0.0
!!$   kgrid%gdiv = 1.0
!!$   kgrid%kmah = 0
!!$
!!$   dymin = rdymin*kgrid%dx(2)
!!$   nx    = kgrid%nx
!!$   ny    = kgrid%ny

   dymin = rdymin*sampl%y
   nx    = isize%x
   ny    = isize%y

   !--- For compatibility with routines called:
   x0grid(1) = corner%x
   x0grid(2) = corner%y
   dxgrid(1) = sampl%x
   dxgrid(2) = sampl%y

   npol = ksex_cz%npol
   naz2 = ksex_cz%nazi(2)

   write(6,1) 'interp_kam_3d: npol,naz2 = ',npol,naz2 

   !-------------------------------------------------------------------
   !
   !  LOOP OVER OUTPUT DEPTH AND INITIAL POLAR AND AZIMUTH ANGLES. 
   !   * Outer loop over depth levels (iz) runs in paralell. 
   !   * The loop must be parallelized by hand.
   !
   !-------------------------------------------------------------------

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(DYNAMIC,1)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (rayfan,ksex_cz,ksex,               &
   !$OMP            isize,corner,sampl,                &
   !$OMP            dymin,npol,naz2,nx,ny)             &
   !$OMP    PRIVATE(iz,ip,ir1,ir2,jr1,jr2,kr1,kr2,kr3, &
   !$OMP            lred,lblack,ntrek,jtrek,isort,     &
   !$OMP            jinsect,ninsect,vertx,vtail,vhead, &
   !$OMP            ie1,ie2,ie3,iy,iy1,iy2,ix,ix1,ix2, &
   !$OMP            kp,xgrid,wgt)
   do iz=1,isize%z

!!$      lwrite = (iz.eq.isize%z/2+1) ! For debugging
      lwrite = .false.

!!$      write(6,*) 'iz = ',iz

      !-------------------------------------------------------------
      !   Loop over initial polar angles 
      !-------------------------------------------------------------

      ir2 = 1

      do ip=1,npol-1

         ir1 = ir2
         ir2 = ir1 + ksex_cz%nazi(ip)

         jr1 = ir1
         jr2 = ir2

         ninsect = 2*ip-1
         jinsect = ninsect
         ntrek   = naz2*ninsect

         if (lwrite) write(6,2) 'ip,ninsect,ntrek = ',ip,ninsect,ntrek

         !--------------------------------------------------------
         !   Loop over triangles at current polar angle
         !--------------------------------------------------------

         do jtrek=1,ntrek

            !--------------------------------------------------
            !  Find vertices of the current triangle 
            !  OK to run this in paralell (tested)
            !--------------------------------------------------
            call three_corners(kr1,kr2,kr3,lred,lblack,jr1,jr2,     &
                               jinsect,ninsect,ir1,ir2,jtrek,ntrek)

            vertx(1:2,1) = ksex_cz%xray(1:2,iz,kr1)  
            vertx(1:2,2) = ksex_cz%xray(1:2,iz,kr2)  
            vertx(1:2,3) = ksex_cz%xray(1:2,iz,kr3)  

            !################# For debugging: #############
            if (lwrite) then 
               if     (lred)   then
                  color = 'RED'
               elseif (lblack) then
                  color = 'BLACK'
               else
                  color = 'GREEN'
               end if
               write(6,3) ' # ip,jtrek,COLOR,kr1,kr2,kr3 = ', &
                       ip,jtrek,' ',color,kr1,kr2,kr3
            endif
            !##############################################

            !--------------------------------------------------
            !  Get head and tail of the edge vectors.
            !  Sort y-coord. of the tails in ascending order.
            !--------------------------------------------------

            call three_edges(isort,vhead,vtail,vertx,ncomp,nedge)

            ie1 = 1
            ie2 = 2
            ie3 = 3

            !--------------------------------------------------
            !   Loop over iy inside polygon
            !--------------------------------------------------

            !--- First and last iy inside triangle:
            call iy_in_trek(iy1,iy2,ny,x0grid,dxgrid, &
                            vhead,vtail,ncomp,nedge)

            if(lwrite) write(6,8) '   * iy1,iy2,ie1,ie2 = ',iy1,iy2,ie1,ie2
               
            do iy=iy1,iy2

               if (iy.lt.1)        write(6,*) 'Error: Too small iy = ',iy
               if (iy.gt.isize%y)  write(6,*) 'Error: Too big   iy = ',iy

               xgrid(2) = x0grid(2) + real(iy-1,kind=krx)*dxgrid(2)

               !--- Throw 1st activ edge to the dogs?
               if (xgrid(2) .gt. vhead(2,ie1)) then
                  if (lwrite) write(6,7) '         $$$ Junked: ie1 = ',ie1
                  ie1 = ie2
                  ie2 = ie3
               end if

               !--------------------------------------------
               !   Loop over ix inside polygon
               !--------------------------------------------

               !--- First and last ix inside polygon:
               call ix_in_trek(ix1,ix2,nx,x0grid,dxgrid,xgrid, &
                               ie1,ie2,vhead,vtail,ncomp,nedge)
               
               if(lwrite) write(6,9) '     + iy,ix1,ix2 = ',iy,ix1,ix2

               do ix=ix1,ix2

                  if (ix.lt.1)        write(6,*) 'Error: ix = ',ix
                  if (ix.gt.isize%x)  write(6,*) 'Error: ix = ',ix
                  
                  xgrid(1) = x0grid(1) + real(ix-1,kind=krx)*dxgrid(1)

                  !--- Compute the weights for interpolation:
                  call three_weights(wgt,xgrid,vertx,ncomp,nedge)
                  
                  !--- Update multipathing counter:
                  kp = min(rayfan%npat(ix,iy,iz)+1,rayfan%maxpat)
                  rayfan%npat(ix,iy,iz) = kp
                  
                  !################# For debugging: #############
                  if (lwrite) then
                     write(6,4) '       - iy,ix, kp = ',iy,ix,kp
                     write(6,5) '       - xgrid, weights  = ',   &
                                        xgrid(1),xgrid(2),       &
                                        wgt(1),wgt(2),wgt(3)
                     write(6,6) '       - vertx_1, xoff_1 = ',   &
                                        vertx(1,1),vertx(2,1),   &
                                        xgrid(1)-vertx(1,1),xgrid(2)-vertx(2,1)
                     write(6,6) '       - vertx_2, xoff_2 = ',   &
                                        vertx(1,2),vertx(2,2),   &
                                        xgrid(1)-vertx(1,2),xgrid(2)-vertx(2,2)
                     write(6,6) '       - vertx_3, xoff_3 = ',   &
                                        vertx(1,3),vertx(2,3),   &
                                        xgrid(1)-vertx(1,3),xgrid(2)-vertx(2,3)
                  end if
                  !##############################################
                  
                  !--- Interpolation (Puh!!):
                  rayfan%g_surf(kp,ix,iy,iz)%x = & 
                        wgt(1)*ksex%gray(   1, 1,kr1) + &
                        wgt(2)*ksex%gray(   1, 1,kr2) + &
                        wgt(3)*ksex%gray(   1, 1,kr3)
                  rayfan%g_surf(kp,ix,iy,iz)%y = & 
                        wgt(1)*ksex%gray(   2, 1,kr1) + &
                        wgt(2)*ksex%gray(   2, 1,kr2) + &
                        wgt(3)*ksex%gray(   2, 1,kr3)
                  rayfan%g_surf(kp,ix,iy,iz)%z = & 
                        wgt(1)*ksex%gray(   3, 1,kr1) + &
                        wgt(2)*ksex%gray(   3, 1,kr2) + &
                        wgt(3)*ksex%gray(   3, 1,kr3)
                  rayfan%p_surf(kp,ix,iy,iz)%x = & 
                        wgt(1)*ksex%pray(   1, 1,kr1) + &
                        wgt(2)*ksex%pray(   1, 1,kr2) + &
                        wgt(3)*ksex%pray(   1, 1,kr3)
                  rayfan%p_surf(kp,ix,iy,iz)%y = & 
                        wgt(1)*ksex%pray(   2, 1,kr1) + &
                        wgt(2)*ksex%pray(   2, 1,kr2) + &
                        wgt(3)*ksex%pray(   2, 1,kr3)
                  rayfan%p_surf(kp,ix,iy,iz)%z = & 
                        wgt(1)*ksex%pray(   3, 1,kr1) + &
                        wgt(2)*ksex%pray(   3, 1,kr2) + &
                        wgt(3)*ksex%pray(   3, 1,kr3)
                  rayfan%p_down(kp,ix,iy,iz)%x = & 
                        wgt(1)*ksex_cz%pray(1,iz,kr1) + &
                        wgt(2)*ksex_cz%pray(1,iz,kr2) + &
                        wgt(3)*ksex_cz%pray(1,iz,kr3)
                  rayfan%p_down(kp,ix,iy,iz)%y = & 
                        wgt(1)*ksex_cz%pray(2,iz,kr1) + &
                        wgt(2)*ksex_cz%pray(2,iz,kr2) + &
                        wgt(3)*ksex_cz%pray(2,iz,kr3)
                  rayfan%p_down(kp,ix,iy,iz)%z = & 
                        wgt(1)*ksex_cz%pray(3,iz,kr1) + &
                        wgt(2)*ksex_cz%pray(3,iz,kr2) + &
                        wgt(3)*ksex_cz%pray(3,iz,kr3)
                  rayfan%time(  kp,ix,iy,iz)   = & 
                        wgt(1)*ksex_cz%time(  iz,kr1) + &
                        wgt(2)*ksex_cz%time(  iz,kr2) + &
                        wgt(3)*ksex_cz%time(  iz,kr3)
                  rayfan%gdiv(  kp,ix,iy,iz)   = & 
                        wgt(1)*ksex_cz%gdiv(1,iz,kr1) + &
                        wgt(2)*ksex_cz%gdiv(1,iz,kr2) + &
                        wgt(3)*ksex_cz%gdiv(1,iz,kr3)
                  rayfan%kmah(  kp,ix,iy,iz)   = & 
                        min(   ksex_cz%kmah(  iz,kr1) , &
                               ksex_cz%kmah(  iz,kr2) , &
                               ksex_cz%kmah(  iz,kr3) )

               end do ! ix

            end do ! iy

         end do ! jtrek

      end do ! ip

   enddo ! iz

1  format(A,2I6)
2  format(A,3I6)
3  format(A,2I5,2A5,3I5)
4  format(A,3I6)
5  format(A,2F9.3,3F9.5)
6  format(A,4F9.3)
7  format(A,I4)
8  format(A,2I6,2I4)
9  format(A,3I6)

!-----------------------------------------------------------------------
 end subroutine interp_kam_3d
!-----------------------------------------------------------------------

