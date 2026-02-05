!**********************************************************************
!
!  SINTEF Petroleum Research subroutine art_trace_rays
!
! Purpose:
!    Trace rays from source or receiver bin locations for a given
!    wave mode, and store them in the ray data base. 
!
!  Subroutines called : many
!  Functions called   : none
!
!  Programmed  :  Emmanuel Causse  March 2000
!                 Ketil Hokstad    July  2001
!                 
! Comments:
!    Each ray data base actually consists of several ray data bases,
!    corresponding to the different components of the ray fans.
!
!**********************************************************************

subroutine art_trace_rays(wmod_ray, bins, grids_illum, grid_glob,    &
                          geomod, inmode_models, mode_rays,   &
                          dim_gdiv, name_base, fio_rays,         &
                          kini, flag_ray, rkpar, gint,           &
                          lulog, luerr)

   implicit none

   !-- Declarations of arguments
   character(len=2),  intent(in) :: wmod_ray      ! Wave mode (P0, S1 or S2)
   type(kam_bins),    intent(in) :: bins          ! Source or receiver bins
   type(kam_grids),   intent(in) :: grids_illum   ! Illumination grids
   type(kam_grids),   intent(in) :: grid_glob     ! Global grid
   type(art_geo_mod), intent(in) :: geomod        ! Geological models
   character(len=40), intent(in) :: inmode_models ! Input mode for geo model
   character(len=40), intent(in) :: mode_rays     ! Ray mode
   integer,           intent(in) :: dim_gdiv      ! Dimension geom spread
   character(len=40), intent(in) :: name_base     ! Root name of ray data base
   character(len=40), intent(in) :: fio_rays      ! Format ray data base
   integer,           intent(in) :: lulog         ! Logical unit log file
   integer,           intent(in) :: luerr         ! Logical unit errors
   type(art_ray_ctrl),intent(in) :: flag_ray      ! Flag for raytracing
   type(art_rk_pars), intent(in) :: rkpar         ! Runge Kutta pars
   type(art_kin_ini), intent(inout) :: kini       ! Initial conditions for rays
   type(art_lag_int), intent(inout) :: gint       ! Lagrange int pars
   
   !-- Declaration of local variables
   type(art_kin_sex)  :: ksex, ksex_cz  ! Kinetic ray tracing system
   type(art_dyn_sex)  :: dsex1, dsex2   ! Dynamic ray tracing system
   type(art_kin_grid) :: kgrid          ! Kinetic system on grid
   type(kam_ray_fan)  :: rayfan         ! Ray fan     
   integer            :: ind_m3_mod(4)  ! Indexes for models in mode m3
   type(vec_3D)       :: corner_glob    ! Position of corner of global grid
   type(vec_3D)       :: sampl_glob     ! Sampling of global grid
   type(vec_3D)       :: pos_bin        ! Position of survey bin center
   type(vec_3D)       :: corner_illum   ! Position of corner of illum grid
   type(vec_3D)       :: sampl_illum    ! Sampling of illum grid
   type(intvec_3D)    :: isize_illum    ! Size of illum grid in x, y, z dirs
   integer            :: ibin, nbin     ! bin index and number of bins
   real               :: vpv_bin, vsv_bin,  &      ! Thomsen parameters
                         eps_bin, del_bin, gam_bin ! at bin location
   character(len=40)  :: medium                    ! Medium at bin: an/el/ac
   integer            :: ls                        ! Mem alloc error flag
   integer            :: maxpat, nx, ny, nz, nrecl ! Dimensions for rays
   integer            :: ksort                     ! Multipathing sort order
   type(file_type)    :: data_bases(ncomp)         ! Ray data bases
   logical            :: data_base_flag(ncomp)     ! Flag for ray components  
   integer            :: nx_kgrid,ny_kgrid,nz_kgrid,maxray

   !--- Debugging:
   integer            :: k_debug,i
   type(file_type)    :: file_ascii  ,file_npat
   type(file_type)    :: file_ray_xy ,file_ray_xz ,file_ray_yz 
   type(file_type)    :: file_time_cz,file_time_cy,file_time_cx
   type(file_type)    :: file_gdiv_cz,file_gdiv_cy,file_gdiv_cx
   type(file_type)    :: file_pvec_cz,file_pvec_cy,file_pvec_cx

   !----------------------------------------------------------------------
   !   Multipathing: Currently hardcoded
   !----------------------------------------------------------------------

   k_debug = 1

   maxpat = 5             ! Max multipathing (for memory allocation)
   ksort  = k_min_time    ! Multipathing sort order

   !----------------------------------------------------------------------
   !   Allocate memory and open ray data bases
   !----------------------------------------------------------------------

   !-- Allocate memory to ray fan
   call kam_get_grid_pars(grids_illum, isize=isize_illum)
   call kam_allocate_ray_fan(rayfan, mode_rays, isize_illum, &
                             lulog, dim_gdiv, maxpat, ksort)

   !-- Get position of corner of global grid
   call kam_get_grid_pars(grid_glob, i=1, corner=corner_glob)

   !-- Get sampling of global and illumination grids
   call kam_get_grid_pars(grid_glob, sampl=sampl_glob)
   call kam_get_grid_pars(grids_illum, sampl=sampl_illum)

   kgrid%dx(1)  = sampl_illum%x
   kgrid%dx(2)  = sampl_illum%y
   kgrid%dx(3)  = sampl_illum%z
   kgrid%ksort  = ksort

   !-- Open ray data bases
   call kam_get_ray_pars(rayfan, maxpat)

   nrecl  = maxpat*isize_illum%x*isize_illum%y*isize_illum%z
   call kam_open_ray_bases(data_bases, data_base_flag, mode_rays,    &
                           name_base, fio_rays, nrecl, 'write', lulog)

   !--- Kinetic ray tracing arrays:
   ls = 0
   maxray = kini%npol + kini%naz2*kini%npol*(kini%npol-1)/2
   call alloc_kin_sex(ksex   ,kini%maxel   ,maxray,kini%npol,ls)
   call alloc_kin_sex(ksex_cz,isize_illum%z,maxray,kini%npol,ls)
   call alloc_kin_grid(kgrid,maxpat,isize_illum%x,    &
                       isize_illum%y,isize_illum%z,ls)

   !--- Dynamic ray tracing arrays: NOT STORED AT PRESENT
                                          
   if (ls.ne.0) then
      write(6,*) 'Subroutine art_trace_rays: Memory allocation 1 failed.'
      stop
   end if
   
   !----------------------------------------------------------------------
   !   Open files for debugging
   !----------------------------------------------------------------------  

   if (k_debug>0) then
      call iku_open(file_ascii  ,'DB_DUMP.ASCII'  ,'write','ascii')
      call iku_open(file_npat   ,'DB_NPAT.DIR'    ,'write','dir',isize_illum%x)
      call iku_open(file_ray_xy ,'DB_RAY_XY.DIR'  ,'write','dir',2)
      call iku_open(file_ray_xz ,'DB_RAY_XZ.DIR'  ,'write','dir',2)
      call iku_open(file_ray_yz ,'DB_RAY_YZ.DIR'  ,'write','dir',2)
      call iku_open(file_time_cz,'DB_TIME_CZ.DIR' ,'write','dir',2)
      call iku_open(file_time_cy,'DB_TIME_CY.DIR' ,'write','dir',2)
      call iku_open(file_time_cx,'DB_TIME_CX.DIR' ,'write','dir',2)
      call iku_open(file_gdiv_cz,'DB_GDIV_CZ.DIR' ,'write','dir',2)
      call iku_open(file_gdiv_cy,'DB_GDIV_CY.DIR' ,'write','dir',2)
      call iku_open(file_gdiv_cx,'DB_GDIV_CX.DIR' ,'write','dir',2)
      call iku_open(file_pvec_cz,'DB_PVEC_CZ.DIR' ,'write','dir',2)
      call iku_open(file_pvec_cy,'DB_PVEC_CY.DIR' ,'write','dir',2)
      call iku_open(file_pvec_cx,'DB_PVEC_CX.DIR' ,'write','dir',2)
   endif

   !--------------------------------------------------
   !   Wave modes in cyclic order
   !--------------------------------------------------
   
   select case(wmod_ray)
   case('P0')
      kini%kmode(1) = K_QP
      kini%kmode(2) = K_QS1
      kini%kmode(3) = K_QS2
   case('S1')
      kini%kmode(1) = K_QS1
      kini%kmode(2) = K_QS2
      kini%kmode(3) = K_QP
   case('S2')
      kini%kmode(1) = K_QS2
      kini%kmode(2) = K_QP
      kini%kmode(3) = K_QS1
   case default
      write(lulog,*) 'Subroutine art_trace_rays: wavemode = ',wmod_ray
      write(lulog,*) 'Wavemode not recognized'
      stop
   end select
     
   !-----------------------------------------------------------------
   !  Dump shot independent variables to logfile
   !-----------------------------------------------------------------

   if(k_debug>0) then
      write(lulog,1) ' + RAY TRACING:'
      write(lulog,4) '   - kmode        = ',(kini%kmode(i),i=1,3)
      write(lulog,2) '   - kdir         = ',kini%kdir
      write(lulog,2) '   - kevin        = ',kini%kevin
      write(lulog,2) '   - maxel        = ',kini%maxel
      write(lulog,3) '   - npol , naz2  = ',kini%npol,kini%naz2
      write(lulog,6) '   - apol1, apol2 = ',kini%apol1,kini%apol2
      write(lulog,6) '   - aazi1, aazi2 = ',kini%aazi1,kini%aazi2
      write(lulog,1) ' + RAY DATA ON REGULAR GRID:'
      write(lulog,2) '   - maxpat      = ',kgrid%maxpat
      write(lulog,4) '   - nx,ny,nz    = ',kgrid%nx,kgrid%ny,kgrid%nz
      write(lulog,7) '   - dx,dy,dz    = ',(kgrid%dx(i),i=1,3)
      write(lulog,1) ' + GEOLOGICAL MODEL:'
      write(lulog,2) '   - modpar      = ',geomod%modpar
      write(lulog,2) '   - kasino      = ',geomod%kasino
      write(lulog,2) '   - nelk        = ',geomod%nelk
      write(lulog,4) '   - nx,ny,nz    = ',geomod%nx, &
                                           geomod%ny,geomod%nz
      write(lulog,7) '   - dx,dy,dz    = ',(geomod%dx(i),i=1,3)
      write(lulog,7) '   - x0,y0,z0    = ',(geomod%x0(i),i=1,3)
      write(lulog,1) ' + RUNGE KUTTA:'
      write(lulog,5) '   - t0          = ',rkpar%t0
      write(lulog,5) '   - t1          = ',rkpar%t1
      write(lulog,8) '   - dtsave      = ',rkpar%dtsave
      write(lulog,8) '   - h0          = ',rkpar%h0
      write(lulog,8) '   - hmin        = ',rkpar%hmin
      write(lulog,8) '   - accur       = ',rkpar%accur
      write(lulog,1) ' + LAGRANGE INTERPOLATION:'
      write(lulog,4) '   - npx,npy,npz = ',gint%npx,gint%npy,gint%npz
      write(lulog,*) '   - lkin        = ',flag_ray%lkin
      write(lulog,*) '   - ldyn1       = ',flag_ray%ldyn1
      write(lulog,*) '   - ldyn2       = ',flag_ray%ldyn2
      write(lulog,*) '   - lmode(1:3)  = ',(flag_ray%lmode(i),i=1,3)
   end if

1  format(A)
2  format(A,1I6)
3  format(A,2I6)
4  format(A,3I6)
5  format(A,1F10.2)
6  format(A,2F10.2)
7  format(A,3F10.2)
8  format(A,1F10.6)
9  format(A,A)

   !----------------------------------------------------------------------
   !                       LOOP OVER SURVEY BINS
   !             this loop should be parallelized manually
   !----------------------------------------------------------------------

   call kam_get_survey_pars(bins, bin_nr=nbin)
   do ibin = 1, nbin

      !-- Get pos of bin centers, model param at bin, and pos of grid corners
      call kam_get_survey_pars(bins, i=ibin, pos=pos_bin, &
                               medium=medium, vpv=vpv_bin, vsv=vsv_bin,  &
                               eps=eps_bin, del=del_bin, gam=gam_bin)
      call kam_get_grid_pars(grids_illum, i=ibin, corner=corner_illum)

      kini%xsrc(1) = pos_bin%x
      kini%xsrc(2) = pos_bin%y
      kini%xsrc(3) = pos_bin%z

      kgrid%x0(1)  = corner_illum%x
      kgrid%x0(2)  = corner_illum%y
      kgrid%x0(3)  = corner_illum%z

      write(lulog,2) ' + SHOT:',ibin
      write(lulog,7) '   xsor    = ',(kini%xsrc(i),i=1,3)
      write(lulog,7) '   x0_grid = ',(kgrid%x0(i) ,i=1,3)

      select case(inmode_models(1:2))

      !--------------------------------------------------
      !   Ray tracing for depth migration
      !--------------------------------------------------

      case('m1', 'm2')

         !-----------------------------------------------------------
         !  Ray tracing for current shot position and wave mode
         !   * 1. Kinetic ray tracing (always)
         !   * 2. Dynamic ray tracing (if desired)
         !-----------------------------------------------------------
         
         write(6,*) 'Call raiuno_2000'
         call raiuno_2000(ksex,dsex1,dsex2,kini,flag_ray,  &
                          geomod,gint,rkpar,ibin,       &
                          lulog,luerr)

         !-----------------------------------------------------------
         !  Interpolation of extended kinetic system:
         !   * 1. Ray data at constant depth
         !   * 2. Ray data on regular grid
         !-----------------------------------------------------------
         
         write(6,*) 'Call interp_kin_cz'
         call interp_kin_cz(ksex_cz,ksex,kgrid,lulog,luerr)
         write(6,*) 'Call interp_kin_xy'
         call interp_kin_xy(kgrid,ksex_cz,ksex,lulog,luerr)
         write(6,*) 'Call interp_kam_xy'
         call interp_kam_xy(rayfan,ksex_cz,ksex,                  &
                            isize_illum,corner_illum,sampl_illum, &
                            lulog,luerr)
         
         !-----------------------------------------------------------
         !  Write debugging info
         !-----------------------------------------------------------
         
         write(6,*) 'Call write_debug'
         if (k_debug>0) then
            call write_debug(ibin,file_ascii,file_npat,              &
                             file_ray_xz ,file_ray_yz ,file_ray_xy,  &
                             file_time_cz,file_time_cy,file_time_cx, &
                             file_pvec_cz,file_pvec_cy,file_pvec_cx, &
                             file_gdiv_cz,file_gdiv_cy,file_gdiv_cx, &
                             ksex,ksex_cz,kgrid,incray=4)
         end if

      !--------------------------------------------------
      !   Pseudo ray tracing for time migration
      !--------------------------------------------------

      case('m3')

         write(lulog,*) 'Ray tracing for time migration is ',& 
                        'implemented by Emmanuel.'

      case default
         write(lulog,*) 'ERROR: invalid mode for models', inmode_models(1:2)
         write(lulog,*) 'STOP THE PROGRAM from routine art_trace_rays'   
         write(6,*)     'STOP'   
         stop
      end select

      !----------------------------------------------------------------------
      !   Store ray fan in data base
      !----------------------------------------------------------------------

      call kam_store_ray_fan(rayfan, data_bases, data_base_flag, &
                             ibin, lulog)

   !-- end of loop over bins
   end do

   !----------------------------------------------------------------------
   !   Close ray data bases and deallotopcate memory
   !----------------------------------------------------------------------

   call kam_close_ray_bases(data_bases, data_base_flag, lulog)
   call kam_deallocate_ray_fan(rayfan, mode_rays, lulog)
   call dealloc_kin_sex(ksex)
   call dealloc_kin_sex(ksex_cz)
   call dealloc_kin_grid(kgrid)

   !----------------------------------------------------------------------
   !   Close files for debugging
   !----------------------------------------------------------------------  

   if (k_debug>0) then
      call iku_close(file_ascii  )
      call iku_close(file_npat   )
      call iku_close(file_ray_xy )
      call iku_close(file_ray_xz )
      call iku_close(file_ray_yz )
      call iku_close(file_time_cz)
      call iku_close(file_time_cy)
      call iku_close(file_time_cx)
      call iku_close(file_gdiv_cz)
      call iku_close(file_gdiv_cy)
      call iku_close(file_gdiv_cx)
      call iku_close(file_pvec_cz)
      call iku_close(file_pvec_cy)
      call iku_close(file_pvec_cx)
   endif

!----------------------------------------------------------------------
end subroutine art_trace_rays
!----------------------------------------------------------------------

