!**************************************************************         
!
!  art_geo_model_module
!
!  Type definitions elastic model representation in
!  kinetic and dynamic raytracing
!
!  The kinetic raytracing are performed by the
!  f77 routines in src_f77/kinetic
!
!  References:
!       1. Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          chapters 2.2, 3.6 and 4.14. Lecture notes, 
!          University of Trondheim, 1995.
!
!  Version 1.0
!
!  Modules used       :   iku_io_module
!                         art_ray_control_inc 
!                         art_kind_real_module
!
!  Programmed         :   Ketil Hokstad November 1999 
!
!**************************************************************         

module art_geo_model_module

   use iku_io_module
   use art_kind_real_module
   use art_geo_model_inc

   implicit none

   public  :: art_geo_mod,                           & ! Type definitions
              art_geo_files, art_geo_ctrl,           & ! Type definitions
              read_geo_mod, convert_geo_mod,         & ! Subroutines
              alloc_geo_mod, dealloc_geo_mod,        & ! Subroutines
              get_elk,                               & ! Functions
              k_thomsen,k_voigt,k_tsvankin             ! Parameters

   private :: convert_iso, convert_tiv,              & ! Subroutines
              density_norm                             ! Subroutines

   !--- Model parameterization:
   integer, parameter :: k_thomsen  = 1   ! Vertical vels and Thomsen pars.
   integer, parameter :: k_voigt    = 2   ! C_IJ matrix entries
   integer, parameter :: k_tsvankin = 3   ! A2, A4 and A5

   !--- Geological model
   type art_geo_mod
      integer            :: modpar        ! Model parameterization
      integer            :: kasino        ! Anisotropic symmetry type
      integer            :: nelk          ! Number of elastic moduli
      integer            :: nx,ny,nz      ! Size of the model
      real(kr4)          :: x0(3)         ! Coordinates of node (1,1,1)
      real(kr4)          :: dx(3)         ! Node spacing
      !--- Dimension (:,:,:,:) is (nx,ny,nz,nelk)
      real(kr4),pointer  :: elk(:,:,:,:)  ! Elastic coefficients
      !--- Dimension (:,:,:) is (nx,ny,nz)
      real(kr4),pointer  :: rho(:,:,:)    ! Density
   end type art_geo_mod

   type art_geo_files
      type(file_type) :: elk(21)
      type(file_type) :: rho
   end type art_geo_files

   type art_geo_ctrl
      logical :: lelk(21)
      logical :: lrho
   end type art_geo_ctrl

contains

   include 'convert_geo_mod.f90'
   include 'read_geo_mod.f90'
   include 'alloc_geo_mod.f90'
   include 'get_elk.f90'

end module art_geo_model_module




