!**************************************************************         
!
!  art_ray_tracing_module
!
!  Top routine for 3D kinetic and dynamic anisotropic ray tracing.
!  The module is designed to generate ray data bases for the
!  multicomponent Kirchhoff migration software kam.
!
!  References:
!       1. Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          chapters 2.2, 3.6 and 4.14. Lecture notes, 
!          University of Trondheim, 1995.
!       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
!
!  Modules used      : art_jobfile_module
!                      art_kin_interp_module
!                      art_raiuno_module
!                      art_kin_interp_module
!                      kam_survey_module
!                      kam_grids_module
!                      kam_models_module
!                      kam_ray_module
!                      kam_constant_module
!
!
!  Modules inherited : art_dynamic_module
!                      art_kinetic_module
!                      art_ray_control_inc
!                      art_runge_kutta_inc
!                      art_geo_model_inc
!                      art_geo_model_module
!                      art_lagrange_interp_module
!                      art_runge_kutta_module
!                      iku_io_module
!                      iku_vector_module
!
!  Programmed : Emmanuel Causse  January 2000
!               Ketil Hokstad    July    2001
!
!**************************************************************         

module art_ray_tracing_module

   use art_jobfile_module
   use art_raiuno_module
   use art_kin_interp_module
   use kam_survey_module
   use kam_grids_module
   use kam_models_module
   use kam_ray_module
   use kam_constant_module
!!$   use art_ray_control_inc
!!$   use art_geo_model_module
!!$   use iku_vector_module
!!$   use iku_io_module
   
   implicit none

   public  :: art_ray_tracing                ! Routines 

   private :: art_trace_rays,       &
              distribute_user_pars, &
              check_user_names,     &
              kam_check_bin_pos_m1, &
              write_debug

   !----------------------------------------------------------------------
   ! Routines 
   !----------------------------------------------------------------------
 contains
   include 'art_ray_tracing.f90'
   include 'art_trace_rays.f90'
   include 'distribute_user_pars.f90'
   include 'check_user_names.f90'
   include 'kam_check_bin_pos_m1.f90'
   include 'write_debug.f90'

!----------------------------------------------------------------------
end module art_ray_tracing_module
!----------------------------------------------------------------------





