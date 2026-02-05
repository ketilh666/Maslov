!*********************************************************************    
!
!  SINTEF Petroleum Research  subroutine art_ray_traceing
!
!  Purpose: Driver routine for  kinetic and, optionally, dynamic 
!           ray tracing.
!
!  Subroutines called : many
!  Functions called   : none
!
!  Programmed  :  Emmanuel Causse  January 2000
!                 Ketil Hokstad    July    2001
!                 
!**********************************************************************

subroutine art_ray_tracing (upars, lulog)

   implicit none

   !-- Declarations of arguments
   type(art_user_pars), intent(in)  :: upars  ! user parameters
   integer,             intent(in)  :: lulog  ! log. unit for log file

   !--- Declarations of local variables

   ! Survey bins:
   character(len=8)  :: station_type       ! SOURCE or RECEIVER
   character(len=40) :: name_sor_bins_file ! Description file for source bins
   character(len=40) :: approx_medium_sor  ! Medium at sor bins: an/el/ac
   character(len=40) :: name_sor_bins_base ! Data base for source bins
   character(len=40) :: inmode_survey      ! Input mode for survey bins
   type(kam_bins)    :: bins_sor           ! Source bins
   real              :: dx_sor, dy_sor     ! Increments in sor positions
   integer           :: nx_sor, ny_sor     ! No of source positions
   type(vec_3D)      :: pos_sor            ! Position of first sor/rec bin

   ! Global grid:
   type(kam_grids)   :: grid_global        ! Global grid 
   type(vec_3D)      :: corner_glob        ! Corner of global grid
   type(vec_3D)      :: sampl_glob         ! Spatial sampling of global grid
   type(intvec_3D)   :: isize_glob         ! Integer size of global grid

   ! Illumination grids:
   character(len=40) :: mode_corner        ! Fixed/variable grid corners
   character(len=40) :: name_illum_file    ! Descript. file for illum. grids
   character(len=40) :: name_sor_illum_base(3) ! Database for P0/S1/S2 grids
   type(kam_grids)   :: grids_sor(3)       ! Grids for P0/S1/S2 source rays
   character(len=11) :: ctype_grid         ! Type of grid (e.g. 'SOURCE P0')
   type(vec_3D)      :: corner             ! Corner of grid
   type(vec_3D)      :: sampl              ! Spatial sampling of grid
   type(intvec_3D)   :: isize              ! Integer size of grid

   ! Wave modes
   integer           :: N_wmod_sor         ! Nr of wave modes from source
   character(len=2)  :: wmod_sor(3)        ! Wave modes for sor. rays

   ! Geological model:
   character(len=40) :: name_model_file    ! Descript. file for geol. models
   character(len=40) :: inmode_models      ! Input mode for geological models
   character(len=40) :: fio_models         ! Format for geological model
   type(art_geo_mod) :: geomodels          ! Geological model
   type(art_lag_int) :: gint               ! Lagrange int pars

   ! Rays
   type(art_kin_ini) :: kini                ! Initial conditions for rays
   type(art_ray_ctrl):: flag_ray            ! Flag for raytracing
   type(art_rk_pars) :: rkpar               ! Runge Kutta pars
   character(len=40) :: mode_rays           ! Input mode for rays
   integer           :: dim_gdiv            ! Dimension of geom. spreading
   character(len=40) :: name_sor_ray_base(3)! Data base for sor P0/S1/S2 rays
   character(len=40) :: fio_rays            ! Format for ray data bases   
   character(len=40) :: name_errmsg         ! Error messages from ray tracing

   ! Others
   type(file_type)    :: file_errmsg
   integer            :: luerr
   integer            :: n_sor_bins, lstat, imod, ngrid
   character(len=200) :: cstring

   integer :: k_debug


   !----------------------------------------------------------------------
   !   JOB SETUP:
   !    * Distribute user defined parameters from the job file
   !    * Distribute user defined filenames from the jobfile
   !----------------------------------------------------------------------   

   k_debug = 1

   call distribute_user_pars(upars,kini,flag_ray,geomodels,gint,rkpar,  &
                             station_type,wmod_sor,N_wmod_sor,          &
                             corner_glob,sampl_glob,isize_glob,         &
                             approx_medium_sor,mode_rays,dim_gdiv,      &
                             inmode_survey,inmode_models,               &
                             fio_models,fio_rays)

   call check_user_names(upars,                                 &
                         name_sor_bins_file,name_sor_bins_base, &
                         name_illum_file,name_sor_illum_base,   &
                         name_model_file,name_sor_ray_base,     &
                         name_errmsg)

   !----------------------------------------------------------------------
   !   Open file for error messages from ray tracing
   !----------------------------------------------------------------------

   call iku_open(file_errmsg,name_errmsg,'WRITE','ASCII')
   luerr = iku_get_file_unit(file_errmsg)

   !----------------------------------------------------------------------
   !   Allocate and create global grid 
   !----------------------------------------------------------------------

   if (k_debug>0) then
      write(lulog,*) '* Create global grid'
   end if

   ngrid = 1
   call kam_make_grids(grid_global, 'none', ngrid, corner_glob, &
                       sampl_glob, isize_glob, 'fixed', lulog)

   !----------------------------------------------------------------------
   !   Allocate memory, create and store survey bins
   !----------------------------------------------------------------------

   if (k_debug>0) then
      write(lulog,*) '* Create source bins'
   end if

   call kam_make_bins(bins_sor, inmode_survey, name_sor_bins_file,   &
                      name_sor_bins_base,station_type,               &
                      approx_medium_sor, lulog,                      &
                      dx=dx_sor, dy=dy_sor, nx=nx_sor, ny=ny_sor)

   !--- Check position of sources and receivers:
   select case(inmode_survey(1:2))
   case('m1')
      call kam_get_survey_pars(bins_sor, i=1, pos=pos_sor)
      call kam_check_bin_pos_m1(grid_global, pos_sor, dx_sor, dy_sor, &
                                nx_sor, ny_sor, lulog)
   case('m2')
      write(lulog,*) 'WARNING: check of source positions not ', &
                     'implemented for other modes '
      write(lulog,*) 'than survey description mode ''m1'' '
   case default
      write(lulog,*) 'ERROR: invalid survey description mode ', &
                     inmode_survey(1:2)
      write(lulog,*) 'STOP THE PROGRAM from routine art_ray_tracing'   
      stop
   end select

   !----------------------------------------------------------------------
   !   Allocate memory, create and store illumination grids
   !----------------------------------------------------------------------

   !-- get some parameters from source and receiver bins
   call kam_get_survey_pars(bins_sor, bin_nr=n_sor_bins)

   !-- Read description file for illumination grids
   call kam_read_illum_grid_file(corner, sampl, isize, mode_corner,     &
                                 name_illum_file)

   !-- Make illumination grids from sources for different wave modes
   do imod = 1, nwmod
      if (sum(index(wmod_sor,wmod(imod))) > 0) then ! check if mode to use
         if (k_debug>0) then
            write(lulog,*) '* Create illumination grids from ',         &
                              station_type,' for mode ',wmod(imod)
         end if
         ctype_grid = wmod(imod)//station_type
         call kam_make_grids(grids_sor(imod),name_sor_illum_base(imod),  &
                             n_sor_bins,corner,sampl,isize, mode_corner, &
                             lulog,ctype_grid = ctype_grid)
                             
      end if
   end do

   !----------------------------------------------------------------------
   !   Allocate memory and read models
   !----------------------------------------------------------------------
   
   if (k_debug>0) then
      write(lulog,*) '* Read models'
   end if

   call kam_make_models(geomodels, inmode_models, fio_models, &
                        name_model_file, lulog, wmod_sor)

   !----------------------------------------------------------------------
   !   Perform ray tracing and store ray fans in data base
   !----------------------------------------------------------------------

   do imod = 1, nwmod

      if (sum(index(wmod_sor,wmod(imod))) > 0) then

         if (k_debug>0) then
            write(lulog,*) '* Trace rays from source for mode ',wmod(imod)
         end if

         call art_trace_rays(wmod(imod), bins_sor, grids_sor(imod),        &
                             grid_global, geomodels, inmode_models,        &
                             mode_rays, dim_gdiv, name_sor_ray_base(imod), &
                             fio_rays, kini, flag_ray, rkpar, gint,        &
                             lulog,luerr)

      end if

   end do

   !----------------------------------------------------------------------
   !   Deallocate memory 
   !----------------------------------------------------------------------

   !-- Global grid
   call kam_deallocate_grids(grid_global, lulog)
   
   !-- Survey bins
   call kam_deallocate_bins(bins_sor, lulog)
   
   !-- Illumination grids for the different wave modes
   do imod = 1, nwmod
      if (sum(index(wmod_sor,wmod(imod))) > 0) then
         call kam_deallocate_grids(grids_sor(imod), lulog)
      end if
   end do
   
   !-- Geological models 
   call dealloc_geo_mod(geomodels)

   call iku_close(file_errmsg)

 !----------------------------------------------------------------------
 end subroutine art_ray_tracing
 !----------------------------------------------------------------------







