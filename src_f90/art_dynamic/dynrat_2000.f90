!************************************************************************
!
! Subroutine dynrat_2000
!
! Purpose: Perform dynamic raytracing of q1x,p1x or q2x,p2x
!          for a known kinetic ray by the Runge-Kutta method.
!
! Note   : Geological model on grid is REAL*4
!
! References: 
!       1. Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          chapters 2.2 and 3.6. Lecture notes, 
!          University of Trondheim, 1995.
!       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
!
! Subroutines called : rk_error
!                f77 : DYNZRO DYNINT
! Functions called   : none
!
! Programmed         : Ketil Hokstad January   1999
!                      Ketil Hokstad September 1999
!                      Ketil Hokstad March     2000
!
!************************************************************************

subroutine dynrat_2000(dsys,ksys,jr,kini,kwave,gmod,gint, &
                       rkpar,apol,aazi,ierr,jerr)

   implicit none

   !---  External variables:
   type(art_dyn_sys) ,intent(inout) :: dsys      ! Dynamic ray system
   type(art_kin_sys) ,intent(in)    :: ksys      ! Kinetic ray system
   type(art_kin_ini) ,intent(in)    :: kini      ! Initial con. for kinetic rt
   type(art_geo_mod) ,intent(in)    :: gmod      ! Elastic model
   type(art_lag_int) ,intent(inout) :: gint      ! Lagrange int parameters
   type(art_rk_pars) ,intent(in)    :: rkpar     ! Runge Kutta parameters
   real(krx)         ,intent(in)    :: apol      ! Initial polar angle
   real(krx)         ,intent(in)    :: aazi      ! Initial azimuth angle
   integer           ,intent(in)    :: kwave     ! Plane wave or point source
   integer           ,intent(in)    :: jr        ! Current ray index
   integer           ,intent(out)   :: ierr,jerr ! Error flags

   !---  Internal variables:
   real(kry) :: t0,t1               ! Initial and max traveltime
   real(kry) :: hy(3,3)             ! Initial eigen basis
   real(kry) :: qy0(2,2),py0(2,2)   ! Initial Q and P in ray centered coord.
   real(kry) :: qx0(3,2),px0(3,2)   ! Initial Q and P in cartesian coord.
   real(krx) :: cawrk(MAXPOL+1,3)   ! Work array
   real(krx) :: dawrk(MAXPOL+1,3)   ! Work array

   !-----------------------------------------------------------------------
   !  initialize
   !-----------------------------------------------------------------------

   t0    = real(rkpar%t0 ,kind=kry)
   t1    = real(rkpar%t1 ,kind=kry)

   ierr  = 0
   jerr  = 0
   
!!$   write(6,*) 'dynrat_2000: jr = ',jr

   !-----------------------------------------------------------------------
   !  Plane wave or point source initial conditions?
   !-----------------------------------------------------------------------

   qy0 = real(0.0, kind=kry)
   py0 = real(0.0, kind=kry)

   if (kwave .eq. KPOINT) then
      !--- Point source:
      py0(1,1) = 1.0
      py0(2,2) = 1.0
   else
      !--- Plane wave:
      qy0(1,1) = 1.0
      qy0(2,2) = 1.0
   endif
   
   !-----------------------------------------------------------------------
   !  Compute initial conditions in cartesian coordinates
   !-----------------------------------------------------------------------
      
   call DYNZRO(qy0,py0,ksys%xray(1,1,jr),ksys%pray(1,1,jr),  &
               ksys%gvray(1,1,1,jr),kini%kmode,hy,qx0,px0,2, &
               gmod%kasino,gmod%elk,gmod%nx,gmod%ny,gmod%nz, &
               gmod%nelk,gmod%dx,gmod%x0,gint%npx,gint%npy,  &
               gint%npz,cawrk,dawrk,MAXPOL,ierr)

   !-----------------------------------------------------------------------
   !  Dynamic raytracing by Runge-Kutta integration 
   !-----------------------------------------------------------------------

   call DYNINT(ksys%nel(jr),ksys%tray(1,jr),                 &
               ksys%xray(1,1,jr),ksys%pray(1,1,jr),          &
               ksys%vgray(1,1,jr),ksys%etray(1,1,jr),        &
               ksys%gnray(1,1,jr),ksys%gvray(1,1,1,jr),      &
               dsys%qxray(1,1,1,jr),dsys%pxray(1,1,1,jr),    &
               ksys%maxel,qx0,px0,t0,t1,kini%kevin,          &
               kini%kmode,gmod%kasino,gmod%elk,gmod%nx,      &
               gmod%ny,gmod%nz,gmod%nelk,gmod%dx,gmod%x0,    &
               gint%npx,gint%npy,gint%npz,cawrk,dawrk,       &
               MAXPOL,jerr)

!-----------------------------------------------------------------------
   end subroutine dynrat_2000
!-----------------------------------------------------------------------




















