!**************************************************************         
!
!  art_runge_kutta_module
!
!  Type definitions for Runge-Kutta integration of 
!  kinetic and dynamic raytracing systems.
!  Here are some GUIDELINES for setting the 
!  Runge-Kutta control parameters:
!     * h1     : The fixed or initial trial steplength used.  
!                Usually h1=0.01 will do the job if adaptive
!                steplenght is used
!     * hmin   : The minimum acceptabel step size. May be
!                set equal to zero. hmin=0.01*h1 is OK.
!     * dtsave : Time intervall for storing raypath. Do not
!                set it to small if you want to use the data 
!                for futher computations. dtsave=0.0 saves 
!                everything.
!     * accur  : Max relative error that is tolerated. This
!                parameter is used to adjust the step size. A
!                reasonable value is accur=0.001.
!
!  The dynamic raytracing are performed by the
!  f77 routines in src_f77/dynamic
!
!  References:
!       1. Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          chapters 2.2, 3.6 and 4.14. Lecture notes, 
!          University of Trondheim, 1995.
!       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
!
!  Version 1.0
!
!  Modules used       :   art_ray_control_inc 
!                         art_kind_real_module
!
!  Programmed         :   Ketil Hokstad November 1999 
!
!**************************************************************         

module art_runge_kutta_module

   use art_ray_control_inc
   use art_kind_real_module

   implicit none

   public  :: art_rk_pars, &  ! Type definitions 
              rk_error,    &  ! Subroutines
              krk             ! Parameters

   integer, parameter :: krk = kind_real_single

   !--- Runge-Kutta control parameters:
   type art_rk_pars
      real(krk)  :: t0      ! Start time
      real(krk)  :: t1      ! Final time
      real(krk)  :: dtsave  ! Time interval to store results
      real(krk)  :: h0      ! Initial or fixed steplength
      real(krk)  :: hmin    ! Minimum steplength
      real(krk)  :: accur   ! Required accuracy (adaptive steplength)
   end type art_rk_pars

   contains

     include 'rk_error.f90'

end module art_runge_kutta_module
