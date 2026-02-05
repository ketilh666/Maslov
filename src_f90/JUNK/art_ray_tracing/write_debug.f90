!*********************************************************************         
!
!  IKU Seismic subroutine write_debug
!
!  Purpose : Write ray tracing data for debugging and checking
!
!  Programmed  :   Ketil Hokstad February 2000
!                  Ketil Hokstad March    2000
!                  Ketil Hokstad April    2000
!
!**********************************************************************
    
subroutine write_debug(ishot,file_ascii,file_npat,             &
                       file_ray_xz ,file_ray_yz ,file_ray_xy,  &
                       file_time_cz,file_time_cy,file_time_cx, &
                       file_pvec_cz,file_pvec_cy,file_pvec_cx, &
                       file_gdiv_cz,file_gdiv_cy,file_gdiv_cx, &
                       ksex,ksex_cz,kgrid,incray)

   type(file_type)     ,intent(in)  :: file_ascii
   type(file_type)     ,intent(in)  :: file_ray_xy
   type(file_type)     ,intent(in)  :: file_ray_xz
   type(file_type)     ,intent(in)  :: file_ray_yz
   type(file_type)     ,intent(in)  :: file_time_cz
   type(file_type)     ,intent(in)  :: file_gdiv_cz
   type(file_type)     ,intent(in)  :: file_pvec_cz
   type(file_type)     ,intent(in)  :: file_time_cy
   type(file_type)     ,intent(in)  :: file_gdiv_cy
   type(file_type)     ,intent(in)  :: file_pvec_cy
   type(file_type)     ,intent(in)  :: file_time_cx
   type(file_type)     ,intent(in)  :: file_gdiv_cx
   type(file_type)     ,intent(in)  :: file_pvec_cx
   type(file_type)     ,intent(in)  :: file_npat
   type(art_kin_sex)   ,intent(in)  :: ksex
   type(art_kin_sex)   ,intent(in)  :: ksex_cz
   type(art_kin_grid)  ,intent(in)  :: kgrid
   integer             ,intent(in)  :: ishot
   integer             ,optional    :: incray

   !--- Internal variables:
   integer ,save :: irec0=0  ! Rays in xz- and yz-planes
   integer ,save :: irec1=0  ! Scalars   at constant z
   integer ,save :: irec2=0  ! Vectors   at constant z
   integer ,save :: jrec0=0  ! Multipat. at constant z
   integer ,save :: jrec1=0  ! Scalars   at constant z and y
   integer ,save :: jrec2=0  ! Vectors   at constant z and y
   integer ,save :: krec1=0  ! Scalars   at constant z and x
   integer ,save :: krec2=0  ! Vectors   at constant z and x
   integer       :: irec,jrec,krec
   integer       :: ip,ia,ir,i,j,k,kp,nout_cy,nout_cx
   integer       :: ix1,ix2,iy1,iy2,iz1,iz2,k0,inc
   integer       :: lua
   real(kr4)     :: ray_xy(2),ray_xz(2),ray_yz(2)
   real(kr4)     :: ray_tt(2),ray_t2(2)
   real(kr4)     :: ray_gd(2),ray_g2(2)
   real(kr4)     :: ray_pv(2),ray_p2(2)
   real(kr4)     :: zout,rpat(kgrid%nx)

   !--------------------------------------------------------------------
   !   Write info to ascii file
   !--------------------------------------------------------------------

   lua = iku_get_file_unit(file_ascii)
   
   !--- Write heading:
   write(lua,1) '============================'
   write(lua,1) '  ISHOT  KMODE NPA   NAA    '
   write(lua,2) ishot,ksex%kmode,ksex%npol,ksex%nazi(2)
   write(lua,1) '----------------------------'
   write(lua,1) '    IP   IA    NRAYEL       '

   !--- Write ray information:
   ir = 0
   do ip=1,ksex%npol
      do ia=1,ksex%nazi(ip)
         ir = ir+1
         write(lua,3) ip,ia,ksex%nel(ir)
      enddo
   end do

1  format (A)
2  format (I6,I6,2I6)
3  format (2I6,I8)

   !--------------------------------------------------------------------
   !   Initialize I/O control parameters
   !--------------------------------------------------------------------

   if (present(incray)) then
      inc   = incray
   else
      inc = 1
   endif

   iy1   = kgrid%ny/2+1 
   iy2   = kgrid%ny/2+1 

   ix1   = kgrid%nx/2+1 - 10
   ix2   = kgrid%nx/2+1 - 10

   iz1   = kgrid%nz/2+1
   iz2   = kgrid%nz/2+1

   k0    = iz1

   write(6,*) 'write_debug: ix1, ix2 = ',ix1, ix2
   write(6,*) '             iy1, iy2 = ',iy1, iy2
   write(6,*) '             iz1, iz2 = ',iz1, iz2

   !--------------------------------------------------------------------
   !   Write ray trajectory in xz- and yz-planes
   !--------------------------------------------------------------------

   irec = irec0
   do ir=1,ksex%nray,inc
      do k=1,ksex%nel(ir)
         irec = irec+1
         ray_xz(1) = real(ksex%xray(3,k,ir)) - 625.0      ! xz plane: z
         ray_xz(2) = real(ksex%xray(1,k,ir))       ! xz plane: x
         ray_yz(1) = real(ksex%xray(3,k,ir)) - 625.0       ! yz plane: z
         ray_yz(2) = real(ksex%xray(2,k,ir))       ! yz plane: y
         call iku_write(file_ray_xz,ray_xz)
         call iku_write(file_ray_yz,ray_yz)
      end do
   end do
   irec0 = irec

   !--------------------------------------------------------------------
   !   Write ray data at constant depth
   !--------------------------------------------------------------------

   !--- Scalars: Traveltime and geometrical spreading:
   irec = irec1
   do ir=1,ksex_cz%nray
      irec = irec+1
      ray_xy(1) = real(ksex_cz%xray(1,k0,ir))       ! xy plane: x
      ray_xy(2) = real(ksex_cz%xray(2,k0,ir))       ! xy plane: y
      ray_tt(1) = real(ksex_cz%time(  k0,ir)    )   ! Travel time
      ray_tt(2) = real(ksex_cz%xray(1,k0,ir)    )   ! x-coord.
      ray_gd(2) = real(1000./ksex_cz%gdiv(1,k0,ir))   ! Geom. spread.
      ray_gd(1) = real(ksex_cz%xray(1,k0,ir)    )   ! x-coord.
      call iku_write(file_ray_xy ,ray_xy)
      call iku_write(file_time_cz,ray_tt)
      call iku_write(file_gdiv_cz,ray_gd)
   end do
   irec1 = irec

   !--- Vectors: Slowness and polarization
   irec = irec2
   do ir=1,ksex_cz%nray
      irec = irec+1
      ray_pv(2) = real(ksex_cz%pray(1,k0,ir)*1.0e3) ! Slowness x-comp
      ray_pv(1) = real(ksex_cz%xray(1,k0,ir)    )   ! x-coord.
      call iku_write(file_pvec_cz,ray_pv)
   end do
   do ir=1,ksex_cz%nray
      irec = irec+1
      ray_pv(2) = real(ksex_cz%pray(3,k0,ir)*1.0e3) ! Slowness z-comp
      ray_pv(1) = real(ksex_cz%xray(1,k0,ir)    )   ! x-coord.
      call iku_write(file_pvec_cz,ray_pv)
   end do
   irec2 = irec

   !--------------------------------------------------------------------
   !   Multipathing at constant depth
   !--------------------------------------------------------------------

   !--- Multipathing:
   jrec = jrec0
   do j=1,kgrid%ny
      jrec = jrec+1
      do i=1,kgrid%nx
         rpat(i) = real(kgrid%npat(i,j,k0))
      end do
      call iku_write(file_npat,rpat)
   enddo
   jrec0 = jrec

   !--------------------------------------------------------------------
   !   Write ray data at constant z and y
   !--------------------------------------------------------------------

   !--- Scalars: Traveltime and geometrical spreading:
   jrec = jrec1
   nout_cy = 0
   do j=iy1,iy2
      do i=1,kgrid%nx
         do kp=1,kgrid%npat(i,j,k0)
            jrec = jrec+1
            nout_cy = nout_cy+1
            ray_tt(1) = real(kgrid%time(  kp,i,j,k0))
            ray_tt(2) = real(kgrid%xrec(1,kp,i,j,k0))
            ray_gd(2) = real(1000./kgrid%gdiv(1,kp,i,j,k0))
            ray_gd(1) = real(kgrid%xrec(1,kp,i,j,k0))
            call iku_write(file_time_cy,ray_tt)
            call iku_write(file_gdiv_cy,ray_gd)
         enddo
      end do
   end do
   jrec1 = jrec

   !--- Vectors: Slowness and polarization:
   jrec = jrec2
   k    = kgrid%nz/2+1
   do j=iy1,iy2
      do i=1,kgrid%nx
         do kp=1,kgrid%npat(i,j,k0)
            jrec = jrec+1
            ray_pv(2) = real(kgrid%prec(1,kp,i,j,k0))*1.0e3
            ray_pv(1) = real(kgrid%xrec(1,kp,i,j,k0))
            call iku_write(file_pvec_cy,ray_pv)
         enddo
      end do
   end do
   do j=iy1,iy2
      do i=1,kgrid%nx
         do kp=1,kgrid%npat(i,j,k0)
            jrec = jrec+1
            ray_pv(2) = real(kgrid%prec(3,kp,i,j,k0))*1.0e3
            ray_pv(1) = real(kgrid%xrec(1,kp,i,j,k0))
            call iku_write(file_pvec_cy,ray_pv)
         enddo
      end do
   end do
   jrec2 = jrec

   !--------------------------------------------------------------------
   !   Write ray data at constant x and z
   !--------------------------------------------------------------------

   !--- Scalars: Traveltime and geometrical spreading:
   krec = krec1
   nout_cx = 0
   do j=1,kgrid%ny
      do i=ix1,ix2
         do kp=1,kgrid%npat(i,j,k0)
            krec = krec+1
            nout_cx = nout_cx+1
            ray_tt(1) = real(kgrid%time(  kp,i,j,k0))
            ray_tt(2) = real(kgrid%xrec(2,kp,i,j,k0))
            ray_gd(2) = real(1000./kgrid%gdiv(1,kp,i,j,k0))
            ray_gd(1) = real(kgrid%xrec(2,kp,i,j,k0))
            call iku_write(file_time_cx,ray_tt)
            call iku_write(file_gdiv_cx,ray_gd)
         enddo
      end do
   end do
   krec1 = krec

   !--- Vectors: Slowness and polarization:
   krec = krec2
   k    = kgrid%nz/2+1
   do j=1,kgrid%ny
      do i=ix1,ix2
         do kp=1,kgrid%npat(i,j,k0)
            krec = krec+1
            ray_pv(2) = real(kgrid%prec(2,kp,i,j,k0))*1.0e3
            ray_pv(1) = real(kgrid%xrec(2,kp,i,j,k0))
            call iku_write(file_pvec_cx,ray_pv)
         enddo
      end do
   end do
   do j=1,kgrid%ny
      do i=ix1,ix2
         do kp=1,kgrid%npat(i,j,k0)
            krec = krec+1
            ray_pv(2) = real(kgrid%prec(3,kp,i,j,k0))*1.0e3
            ray_pv(1) = real(kgrid%xrec(2,kp,i,j,k0))
            call iku_write(file_pvec_cx,ray_pv)
         enddo
      end do
   end do
   krec2 = krec

   !--------------------------------------------------------------------
   !   Write info to ascii file
   !--------------------------------------------------------------------

   zout = kgrid%x0(3) + real(k0-1)*kgrid%dx(3)
   write(lua,4) 'Ray data dumped at depth: zout = ',zout
   write(lua,5) 'Total number of rays:     nray = ',ksex_cz%nray
   write(lua,6) 'Interpolation #1:     npa,naz2 = ',ksex_cz%npol,ksex_cz%nazi(2)
   write(lua,6) 'Interpolation #2:      iy1,iy2 = ',iy1,iy2
   write(lua,5) '                       nout_cy = ',nout_cy
   write(lua,6) '                       ix1,ix2 = ',ix1,ix2
   write(lua,5) '                       nout_cx = ',nout_cx
   write(  6,4) 'Ray data dumped at depth: zout = ',zout
   write(  6,5) 'Total number of rays:     nray = ',ksex_cz%nray
   write(  6,6) 'Interpolation #1:     npa,naz2 = ',ksex_cz%npol,ksex_cz%nazi(2)
   write(  6,6) 'Interpolation #2:      iy1,iy2 = ',iy1,iy2
   write(  6,5) '                       nout_cy = ',nout_cy
   write(  6,6) '                       ix1,ix2 = ',ix1,ix2
   write(  6,5) '                       nout_cx = ',nout_cx


4  format (A,F8.1)
5  format (A,I6)
6  format (A,2I6)

!-----------------------------------------------------------------------
end subroutine write_debug
!-----------------------------------------------------------------------



