!**************************************************************         
!
!  art_kin_interp_module
!
!  Purpose: Interpolation of ray tracing data from 
!           initialvalue ray tracing on a regular grid.
!
!  References:
!
!  Version 1.0
!
!  Modules used       :   art_kinetic_module
!                         kam_ray_module
!                         iku_vector_module
!                         
!  Modules inherited  :   art_kind_real_module
!                         art_ray_control_inc
!                         art_lagrange_interp_module
!        
!  Programmed         :   Ketil Hokstad March 2000
!
!**************************************************************         

module art_kin_interp_module

!CUT   use iku_vector_module
   use art_kinetic_module
!CUT   use kam_ray_module
!!$   use art_kind_real_module
!!$   use art_ray_control_inc

   implicit none

   public  :: art_kin_grid,                        & ! Type definitions
              alloc_kin_grid, dealloc_kin_grid,    & ! Subroutines 
              interp_kin_cz, interp_kin_xy,        & ! Subroutines
              k_no_sort, k_min_time, k_max_amp!,    & ! Parameters
!              interp_kam_xy                          ! Subroutines for kam

!!$   private :: interp_kin_2d, interp_kin_3d,        & ! Subroutines 
!!$              sort_kin_grid, klimz_cz,             & ! Subroutines
!!$              three_corners, three_edges,          & ! Subroutines
!!$              interp_kam_2d, interp_kam_3d,        & ! Subroutines for kam
!!$              sort_kam_grid                          ! Subroutines for kam

   !--- Parameters controling the handling of multipahing:
   integer ,parameter :: k_no_sort  = 1 ! Sort by min traveltime
   integer ,parameter :: k_min_time = 2 ! Sort by min traveltime
   integer ,parameter :: k_max_amp  = 5 ! Sort by max amplitude

   type art_kin_grid
      integer            :: kdir            ! Initial direction Up/Down
      integer            :: kmode           ! Wave mode
      integer            :: ksort           ! Multipathing sort order
      integer            :: maxpat          ! Max multipathing order
      integer            :: nx,ny,nz        ! Size of the grid
      real               :: x0(3),dx(3)
      !--- Dimension (:,:,:) is (nx,ny,nz):
      integer  ,pointer  :: npat(:,:,:)     ! Multipathing counter
      !--- Dimension (:,:,:,:) is (maxpat,nx,ny,nz):
      real(krx),pointer  :: time(:,:,:,:)   ! Traveltime
      integer  ,pointer  :: kmah(:,:,:,:)   ! KMAH index
      !--- Dimension (:,:,:,:) is (2,maxpat,nx,ny,nz):
      real(krx),pointer  :: gdiv(:,:,:,:,:) ! Complex geometrical spreading
      !--- Dimension (:,:,:,:) is (3,maxpat,nx,ny,nz):
      real(krx),pointer  :: xrec(:,:,:,:,:) ! Ray trajectory
      real(krx),pointer  :: prec(:,:,:,:,:) ! Ray slowness
      real(krx),pointer  :: grec(:,:,:,:,:) ! Ray polarization
   end type art_kin_grid
contains

   include 'interp_kin_cz.f90'
   include 'alloc_kin_grid.f90'
   include 'interp_kin_xy.f90'
   include 'interp_kin_2d.f90'
   include 'interp_kin_3d.f90'
   include 'sort_kin_grid.f90'
   include 'interp_aux_3d.f90'   ! Private routines for  3D interp.
!   include 'interp_kam_xy.f90'   ! Public  routine for kam
!   include 'interp_kam_2d.f90'   ! Private routine for kam
!   include 'interp_kam_3d.f90'   ! Private routine for kam
!   include 'sort_kam_grid.f90'   ! Private routine for kam


end module art_kin_interp_module








