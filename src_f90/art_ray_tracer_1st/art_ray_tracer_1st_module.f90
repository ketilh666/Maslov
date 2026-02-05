!**************************************************************         
!
!  art_ray_tracer_1st_module
!
!  Top routine for kinetic and dynamic ray tracing. The f90
!  subroutine art_ray_tracer replaces the f77 routine RAIUNO
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
!  Modules used      : art_jobfile_1st_module
!                      art_raiuno_module
!                      art_kin_interp_module
!
!  Modules inherited : art_dynamic_module
!                      art_kinetic_module
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

module art_ray_tracer_1st_module

   use art_jobfile_1st_module
   use art_raiuno_module
   use art_kin_interp_module
!!$   use art_dynamic_module
!!$   use art_kinetic_module
!!$   use art_runge_kutta_inc
!!$   use art_geo_model_inc
!!$   use art_ray_control_inc
!!$   use art_geo_model_module
!!$   use art_lagrange_interp_module
!!$   use art_runge_kutta_module

   implicit none

   public  :: art_ray_files,                   & ! Type definitions
              ray_tracer                         ! Subroutines

   private :: distribute_user_pars,            & ! Subroutines
              check_user_names,                & ! Subroutines  
              write_debug,                     & ! Subroutines
              open_ray_files, close_ray_files    ! Subroutines

   type art_ray_files
      type(file_type) :: hd(3)
      type(file_type) :: kin(3)
   end type art_ray_files

contains

   include 'ray_tracer.f90'
   include 'distribute_user_pars.f90'
   include 'check_user_names.f90'
   include 'open_and_close.f90'
   include 'write_debug.f90'

end module art_ray_tracer_1st_module





