!**************************************************************         
!
!  art_dynamic_module
!
!  Type definitions for dynamic raytracing
!
!  The dynamic raytracing are performed by the
!  f77 routines in src_f77/dynamic
!
!  References:
!       1. Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          chapters 2.2, 3.6 and 4.14. Lecture notes, 
!          University of Trondheim, 1995.
!
!  Modules used      : art_kinetic_module
!                         
!  Modules inherited : art_geo_model_module
!                      art_geo_model_inc
!                      art_lagrange_interp_module
!                      art_runge_kutta_module
!                      art_ray_control_inc
!
!  Programmed :   Ketil Hokstad October  1999 
!                 Ketil Hokstad November 1999 
!                 Ketil Hokstad March    2000
!
!**************************************************************         

module art_dynamic_module

   use art_kinetic_module
!!$   use art_ray_control_inc
!!$   use art_kind_real_module
!!$   use art_geo_model_inc
!!$   use art_ray_control_inc
!!$   use art_geo_model_module
!!$   use art_lagrange_interp_module
!!$   use art_runge_kutta_module

   implicit none

!!$   public  :: art_dyn_sex  , art_dyn_sys,      & ! Type definitions
!!$              alloc_dyn_sex, dealloc_dyn_sex,  & ! Subroutines
!!$              alloc_dyn_sys, dealloc_dyn_sys,  & ! Subroutines
!!$              dynrat_2000,jelway_2000,         & ! Subroutines
!!$              dyn_sys_to_sex         ! Subroutines

   !--- Dynamic ray data: Extended with
   !---  * Group velocity in Qx_i3
   !---  * dp_i/dt        in Px_i3
   type art_dyn_sex
      !--- Dimension (:,:,:,:) is (3,3,maxel,maxray)
      !--- The 3rd column of qx is dx_i/dt
      !--- The 3rd column of px is dp_i/dt
      real(krx),pointer  :: qxray(:,:,:,:) ! Qx_ij Cartesian
      real(krx),pointer  :: pxray(:,:,:,:) ! Px_ij Cartesian
   end type art_dyn_sex

   !--- We need an auxilliary variable of type art_dyn_sys 
   !--- because both the kinetic and dynamic raytracing 
   !--- must be performed in double precission.
   type art_dyn_sys
      !--- Dimension (:,:,:,:) is (3,2,maxel,maxray):
      real(kry),pointer  :: qxray(:,:,:,:) ! Qx_iK Cartesian
      real(kry),pointer  :: pxray(:,:,:,:) ! Px_iK Cartesian
   end type art_dyn_sys

contains

   include 'alloc_dyn_sex.f90'
   include 'alloc_dyn_sys.f90'
   include 'dynrat_2000.f90'
   include 'jelway_2000.f90'
   include 'dyn_sys_to_sex.f90'

end module art_dynamic_module

