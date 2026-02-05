!**********************************************************************
! Sintef Petroleum Research subroutine kam_trace_rays
!
! Purpose:
!    Trace rays from source or receiver bin locations for a given
!    wave mode, and store them in the ray data base. 
! Programmed:
!    Emmanuel Causse, march 2000
! Comments:
!    Each ray data base actually consists of several ray data bases,
!    corresponding to the different components of the ray fans.
!**********************************************************************
subroutine kam_trace_rays(wmod, bins, grids_illum, grid_glob,    &
                          geomodels, inmode_models, mode_rays,   &
                          dim_gdiv, name_base, fio_rays, lulog)

implicit none

!-- Declarations of arguments
character(len=2),  intent(in)  :: wmod          ! Wave mode (P0, S1 or S2)
type(kam_bins),    intent(in)  :: bins          ! Source or receiver bins
type(kam_grids),   intent(in)  :: grids_illum   ! Illumination grids
type(kam_grids),   intent(in)  :: grid_glob     ! Global grid
type(art_geo_mod), intent(in)  :: geomodels     ! geological models
character(len=40), intent(in)  :: inmode_models ! Input mode for geo model
character(len=40), intent(in)  :: mode_rays     ! Ray mode
integer,           intent(in)  :: dim_gdiv      ! Dimension geom spread
character(len=40), intent(in)  :: name_base     ! Root name of ray data base
character(len=40), intent(in)  :: fio_rays      ! Format ray data base
integer,           intent(in)  :: lulog         ! Logical unit log file

!-- Declaration of local variables
type(kam_ray_fan)              :: ray_fan       ! Ray fan     
integer, dimension(4)          :: ind_m3_mod    ! Indexes for models in mode m3
type(vec_3D)       :: corner_glob  ! Position of corner of global grid
type(vec_3D)       :: sampl_glob   ! Sampling of global grid
type(vec_3D)       :: pos_bin      ! Position of survey bin center
type(vec_3D)       :: corner_illum ! Position of corner of illum grid
type(vec_3D)       :: sampl_illum  ! Sampling of illum grid
type(intvec_3D)    :: isize_illum  ! Size of illum grid in x, y, z directions
integer            :: ibin, nbin   ! bin index and number of bins
real               :: vpv_bin, vsv_bin,  &      ! Thomsen parameters
                      eps_bin, del_bin, gam_bin ! at bin location
character(len=40)  :: medium                    ! Medium at bin: anis/elas/acou
integer            :: maxpat, nx, ny, nz, nrecl ! Dimensions for rays
type(file_type)    :: data_bases(ncomp)         ! Ray data bases
logical            :: data_base_flag(ncomp)     ! Flag for ray components  

! debugging: the following variables are used for testing the Tsvankin 
! and Thomsen parameters after depth correction
real, dimension(geomodels%nx,geomodels%ny, &    ! for debugging:
                geomodels%nz) :: A0, A2, A4, A5 ! par. after depth corr. 
type(file_type)   :: file_A0, file_A2, file_A4, file_A5 ! assoc. files
character(len=40) :: name_A0, name_A2, name_A4, name_A5 ! file names 
integer           :: nrecl_Ai

!----------------------------------------------------------------------
!   Allocate memory and open ray data bases
!----------------------------------------------------------------------
!-- Allocate memory to ray fan
call kam_get_grid_pars(grids_illum, isize=isize_illum)
call kam_allocate_ray_fan(ray_fan, mode_rays, isize_illum, lulog, dim_gdiv)

!-- Get position of corner of global grid
call kam_get_grid_pars(grid_glob, i=1, corner=corner_glob)

!-- Get sampling of global and illumination grids
call kam_get_grid_pars(grid_glob, sampl=sampl_glob)
call kam_get_grid_pars(grids_illum, sampl=sampl_illum)

!-- Open ray data bases
call kam_get_ray_pars(ray_fan, maxpat)
nx = isize_illum%x
ny = isize_illum%y
nz = isize_illum%z
nrecl  = maxpat*nx*ny*nz
call kam_open_ray_bases(data_bases, data_base_flag, mode_rays,    &
                        name_base, fio_rays, nrecl, 'write', lulog)

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

select case(inmode_models(1:2))
!----------------------------------------------------------------------
!   Ray tracing for depth migration
!----------------------------------------------------------------------
   case('m1', 'm2')
   write(lulog,*) 'Ray tracing for depth migration is currently being ',& 
                  'implemented by Ketil'

!----------------------------------------------------------------------
!   Pseudo ray tracing for time migration
!----------------------------------------------------------------------
   case('m3')
!-- Select indexes of geomodel components depending on the wave mode 
   if (wmod == 'P0') then
      ind_m3_mod = (/1, 2, 3, 4/)     ! A0, A2, A4, A5 for P waves
   elseif (wmod == 'S1') then
      ind_m3_mod = (/5, 6, 7, 8/)     ! A0, A2, A4, A5 for SV waves
   elseif (wmod == 'S2') then
      ind_m3_mod = (/9, 10, 11, 12/)  ! A0, A2, A4, A5 for SH waves
   endif



!  Call to function get_elk removed to increase speed
!-- Trace rays 
!!$   call kam_trace_rays_time(ray_fan, mode_rays, dim_gdiv, wmod,     &
!!$                            corner_glob, sampl_glob, pos_bin,       &
!!$                            corner_illum, sampl_illum, isize_illum, &
!!$                            get_elk(geomodels,(ind_m3_mod(1))),     &
!!$                            get_elk(geomodels,(ind_m3_mod(2))),     &
!!$                            get_elk(geomodels,(ind_m3_mod(3))),     &
!!$                            get_elk(geomodels,(ind_m3_mod(4))),     &
!!$                            medium,                                 &
!!$                            vpv_bin, vsv_bin,                       &
!!$                            eps_bin, del_bin, gam_bin,              &
!!$!!!!                             A0, A2, A4, A5,                         &
!!$                            lulog)
!-- Trace rays 
   call kam_trace_rays_time(ray_fan, mode_rays, dim_gdiv, wmod,     &
                            corner_glob, sampl_glob, pos_bin,       &
                            corner_illum, sampl_illum, isize_illum, &
                            geomodels%elk(:,:,:,ind_m3_mod(1)),     &
                            geomodels%elk(:,:,:,ind_m3_mod(2)),     &
                            geomodels%elk(:,:,:,ind_m3_mod(3)),     &
                            geomodels%elk(:,:,:,ind_m3_mod(4)),     &
                            medium,                                 &
                            vpv_bin, vsv_bin,                       &
                            eps_bin, del_bin, gam_bin,              &
!!!!                             A0, A2, A4, A5,                         &
                            lulog)

!-- Invalid mode
   case default
   write(lulog,*) 'ERROR: invalid mode for models', inmode_models(1:2)
   write(lulog,*) 'STOP THE PROGRAM from routine kam_trace_rays'   
   write(6,*)     'STOP'   
   stop
end select

!-- Write corrected parameters to files (debugging)
!!!! nrecl_Ai = geomodels%nx * geomodels%ny *geomodels%nz 
!!!! name_A0 = name_base(1:10) // '_A0.dir'
!!!! name_A2 = name_base(1:10) // '_A2.dir'
!!!! name_A4 = name_base(1:10) // '_A4.dir'
!!!! name_A5 = name_base(1:10) // '_A5.dir'
!!!! call iku_open(file_A0, name_A0, 'write', 'dir', nrecl_Ai, 'replace') 
!!!! call iku_open(file_A2, name_A2, 'write', 'dir', nrecl_Ai, 'replace') 
!!!! call iku_open(file_A4, name_A4, 'write', 'dir', nrecl_Ai, 'replace') 
!!!! call iku_open(file_A5, name_A5, 'write', 'dir', nrecl_Ai, 'replace') 
!!!! call iku_write(file_A0, A0, 1)
!!!! call iku_write(file_A2, A2, 1)
!!!! call iku_write(file_A4, A4, 1)
!!!! call iku_write(file_A5, A5, 1)
!!!! call iku_close(file_A0)
!!!! call iku_close(file_A2)
!!!! call iku_close(file_A4)
!!!! call iku_close(file_A5)

!----------------------------------------------------------------------
!   Store ray fan in data base
!----------------------------------------------------------------------
call kam_store_ray_fan(ray_fan, data_bases, data_base_flag, &
                       ibin, lulog)

!-- end of loop over bins
end do

!----------------------------------------------------------------------
!   Close ray data bases and deallotopcate memory
!----------------------------------------------------------------------
call kam_close_ray_bases(data_bases, data_base_flag, lulog)
call kam_deallocate_ray_fan(ray_fan, mode_rays, lulog)

!----------------------------------------------------------------------
end subroutine kam_trace_rays
!----------------------------------------------------------------------

