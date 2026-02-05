!**************************************************************         
!
!  art_kinetic_module
!
!  Type definitions for kinetic raytracing
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
!  Modules used      : art_ray_control_inc 
!                      art_kind_real_module
!                      art_geo_model_inc
!                      art_geo_model_module
!                      art_lagrange_interp_module
!                      art_runge_kutta_module
!                      iku_io_module
!
!  Modules inherited : none
!
!  Programmed   : Ketil Hokstad October  1999 
!                 Ketil Hokstad November 1999 
!                 Ketil Hokstad January  2000
!                 Ketil Hokstad February 2000
!                 Ketil Hokstad March    2000
!
!**************************************************************         

module art_kinetic_module

   use iku_io_module
   use art_kind_real_module
   use art_geo_model_inc
   use art_ray_control_inc
   use art_geo_model_module
   use art_lagrange_interp_module
   use art_runge_kutta_module

   implicit none

   public  :: art_kin_ini, art_kin_sex, art_kin_sys, & ! Type definitions
              alloc_kin_sex, dealloc_kin_sex,        & ! Subroutines
              alloc_kin_sys, dealloc_kin_sys,        & ! Subroutines
              kinrat_2000, bfavre_2000,              & ! Subroutines
              kin_sys_to_sex, kin_sex_to_sys,        & ! Subroutines
              kin_gdiv_to_sex, init_kin_sex,         & ! Subroutines
              kri,krx,kry                              ! Parameters

   private :: ladapt_dpol, jredun                      ! Parameters

   !--- Single or double precission real:
   integer   ,parameter :: kri = kind_real_single
   integer   ,parameter :: krx = kind_real_single
   integer   ,parameter :: kry = kind_real_double

   !--- Azimuth angles:
   logical   ,parameter :: ladapt_dpol = .false. ! Use adaptive dpol?
   integer   ,parameter :: jredun      = 0       ! Open: 0, closed: 1

   !--- Initial conditions:
   type art_kin_ini
      integer            :: kdir          ! Initial direction Up/Down
      integer            :: kmode(3)      ! Wave mode
      integer            :: kevin         ! How to solve the Christoffel eq.
      real(kri)          :: xsrc(3)       ! Source position   
      integer            :: maxel         ! Max no of ray elements
      integer            :: npol          ! No of initial polar angles
      integer            :: naz2          ! No of initial azimuths at ip=2
      real(kri)          :: apol1         ! 1st polar angle (deg)
      real(kri)          :: apol2         ! Increment polar angle (deg)
      real(kri)          :: aazi1         ! 1st azimuth angle (deg)
      real(kri)          :: aazi2         ! Increment azimuth at iapol=2 (deg)
   end type art_kin_ini

   !--- Extended (incl. geom. spread.) kinetic ray tracing system:
   type art_kin_sex
      integer            :: maxel         ! Max no of ray elements
      integer            :: maxray        ! Max no of rays
      integer            :: kdir          ! Initial direction Up/Down
      integer            :: kmode         ! Wave mode
      integer            :: nray          ! Total number of rays
      integer            :: npol          ! No of initial polar angles
      !--- Dimension (:) is (npol):
      integer  ,pointer  :: nazi(:)       ! No of azimuths per polar angle 
      !--- Dimension (:) is (maxray):
      integer  ,pointer  :: nel (:)       ! No of ray elements 
      real(krx),pointer  :: apol(:)       ! Initial polar angle
      real(krx),pointer  :: aazi(:)       ! Initial azimuth angle
      !--- Dimension (:,:) is (maxel,maxray):
      real(krx),pointer  :: time(:,:)     ! Traveltime
      integer  ,pointer  :: kmah(:,:)     ! KMAH index
      !--- Dimension (:,:,:) is (2,maxel,maxray):
      real(krx),pointer  :: gdiv(:,:,:)   ! Complex geometrical spreading
      !--- Dimension (:,:,:) is (3,maxel,maxray):
      real(krx),pointer  :: xray(:,:,:)   ! Ray trajectory
      real(krx),pointer  :: pray(:,:,:)   ! Ray slowness
      real(krx),pointer  :: gray(:,:,:)   ! Ray polarization
   end type art_kin_sex

   !--- We need an auxilliary variable of type art_kin_sys 
   !--- because both the kinetic and dynamic raytracing 
   !--- must be performed in double precission.
   type art_kin_sys
      integer            :: maxel          ! Max no of ray elements
      integer            :: maxray         ! Max no of rays
      !--- Dimension (:) is (maxray):
      integer  ,pointer  :: nel(:)         ! No of ray elements 
      !--- Dimension (:,:) is (maxel,maxray):
      real(kry),pointer  :: tray(:,:)      ! Traveltime
      !--- Dimension (:,:,:) is (3,maxel,maxray):
      real(kry),pointer  :: xray (:,:,:)   ! Ray trajectory
      real(kry),pointer  :: pray (:,:,:)   ! Ray slowness
      real(kry),pointer  :: vgray(:,:,:)   ! dx/dt (group velocity)
      real(kry),pointer  :: etray(:,:,:)   ! dp/dt
      real(kry),pointer  :: gnray(:,:,:)   ! Eigenvalues  of Christoffel eq.
      !--- Dimension (:,:,:,:) is (3,3,maxel,maxray):
      real(kry),pointer  :: gvray(:,:,:,:) ! Eigenraytors of Christoffel eq.
   end type art_kin_sys

contains

   include 'alloc_kin_sex.f90'
   include 'alloc_kin_sys.f90'
   include 'init_kin_sex.f90'
   include 'kinrat_2000.f90'
   include 'bfavre_2000.f90'
   include 'kin_sys_to_sex.f90'
   include 'kin_sex_to_sys.f90'
   include 'kin_gdiv_to_sex.f90'

end module art_kinetic_module








