!**************************************************************         
!
!  art_raiuno_module
!
!  Top routine for kinetic and dynamic ray tracing. The f90
!  subroutine raiuno_2000 replaces the f77 routine RAIUNO
!
!  The kinetic raytracing are performed by the
!  f77 routines in src_f77/kinetic
!
!  References:
!       1. Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          chapters 2.2, 3.6 and 4.14. Lecture notes, 
!          University of Trondheim, 1995.
!       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
!
!  Modules used      : art_dynamic_module
!
!  Modules inherited : art_kinetic_module
!                      art_runge_kutta_inc
!                      art_geo_model_inc
!                      art_ray_control_inc
!                      art_geo_model_module
!                      art_lagrange_interp_module
!                      art_runge_kutta_module
!
!  Programmed : Ketil Hokstad  January 2000
!               Ketil Hokstad  March   2000
!               Ketil Hokstad  July    2001
!
!**************************************************************         

module art_raiuno_module

   use art_dynamic_module
!!$   use art_kinetic_module
!!$   use art_runge_kutta_inc
!!$   use art_geo_model_inc
!!$   use art_ray_control_inc
!!$   use art_geo_model_module
!!$   use art_lagrange_interp_module
!!$   use art_runge_kutta_module

   implicit none

   public  :: art_ray_ctrl,     & ! Type definitions
              raiuno_2000         ! Subroutines

   type art_ray_ctrl
      logical :: lkin     ! Kinetic raytracing
      logical :: ldyn1    ! Plane wave dynamic
      logical :: ldyn2    ! Point source dynamic
      logical :: lmode(3) ! Wave modes
   end type art_ray_ctrl

contains

   include 'raiuno_2000.f90'

end module art_raiuno_module





