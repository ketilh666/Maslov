!************************************************************************
!
! Subroutine kinrat_2000
!
! Purpose: Trace a kinematic ray with given initial phase 
!          direction by the Runge-Kutta method.
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
!                f77 : KINZRO KININT
! Functions called   : none
!
! Programmed         : Ketil Hokstad December  1998
!                      Ketil Hokstad January   1999
!                      Ketil Hokstad September 1999
!                      Ketil Hokstad February  2000
!                      Ketil Hokstad March     2000
!
!************************************************************************

subroutine kinrat_2000(ksys,jr,kini,gmod,gint, &
                       rkpar,apol,aazi,ierr,jerr)

   implicit none

   !---  External variables:
   type(art_kin_sys) ,intent(inout) :: ksys      ! Kinetic ray system
   type(art_kin_ini) ,intent(in)    :: kini      ! Initial con. for kinetic rt
   type(art_geo_mod) ,intent(in)    :: gmod      ! Elastic model
   type(art_lag_int) ,intent(inout) :: gint      ! Lagrange int parameters
   type(art_rk_pars) ,intent(in)    :: rkpar     ! Runge Kutta parameters
   real(krx)         ,intent(in)    :: apol      ! Initial polar angle
   real(krx)         ,intent(in)    :: aazi      ! Initial azimuth angle
   integer           ,intent(in)    :: jr        ! Current ray index
   integer           ,intent(out)   :: ierr,jerr ! Error flags

   !---  Internal variables:
   real(kry) :: aazi8,apol8         ! Double precission
   real(kry) :: x0(3),vnorm(3)      ! Initial position and phase dir.
   real(kry) :: t0,t1               ! Initial and max traveltime
   real(kry) :: dtsave              ! Intervall for saving raypath
   real(kry) :: h0,hmin             ! Initial and minimum steplength
   real(kry) :: accur               ! Required accuracy
   real(kry) :: vphase              ! Phase velocity
   real(kry) :: aphase,unorm(3)     ! Phase velocity
   real(kry) :: p0(3)               ! Initial slowness
   real(kry) :: gray(3,3),gn(3)     ! Initial eigen values/raytors
   real(krx) :: cawrk(MAXPOL+1,3)
   real(krx) :: dawrk(MAXPOL+1,3)
   integer   :: ngod,nbad           ! Runge-Kutta variables

   !--- Degrees to radians:
   real(kry) ,parameter :: pi8 = 3.141592654d0
   real(kry) ,parameter :: d2r = pi8/180.0d0

   !-----------------------------------------------------------------------
   !  Initialize
   !-----------------------------------------------------------------------

   apol8  = real(apol        ,kind=kry)
   aazi8  = real(aazi        ,kind=kry)
   x0     = real(kini%xsrc   ,kind=kry)
   t0     = real(rkpar%t0    ,kind=kry)
   t1     = real(rkpar%t1    ,kind=kry)
   dtsave = real(rkpar%dtsave,kind=kry)
   h0     = real(rkpar%h0    ,kind=kry)
   hmin   = real(rkpar%hmin  ,kind=kry)
   accur  = real(rkpar%accur ,kind=kry)

   ierr   = 0
   jerr   = 0

!!$   write(6,*) 'kinrat_2000: jr = ',jr

   !-----------------------------------------------------------------------
   !  Initial phase direction
   !-----------------------------------------------------------------------

   vnorm(1) = sin(d2r*apol8)*cos(d2r*aazi8)
   vnorm(2) = sin(d2r*apol8)*sin(d2r*aazi8)
   vnorm(3) = cos(d2r*apol8)*real(kini%kdir,kind=kry)

   !-----------------------------------------------------------------------
   !  Compute initial slowness for the current ray
   !-----------------------------------------------------------------------
      
   call KINZRO(vnorm,kini%kmode,x0,p0,vphase,gn,gray,         &
               gmod%kasino,gmod%elk,gmod%nx,gmod%ny,gmod%nz,  &
               gmod%nelk,gmod%dx,gmod%x0,gint%npx,gint%npy,   &
               gint%npz,cawrk,dawrk,MAXPOL,ierr)

   !-----------------------------------------------------------------------
   !  Kinetic raytracing by Runge-Kutta integration 
   !-----------------------------------------------------------------------

   CALL KININT(ksys%nel(jr),ksys%tray(1,jr),                  &
               ksys%xray(1,1,jr),ksys%pray(1,1,jr),           &
               ksys%vgray(1,1,jr),ksys%etray(1,1,jr),         &
               ksys%gnray(1,1,jr),ksys%gvray(1,1,1,jr),       &
               ksys%maxel,x0,p0,t0,t1,dtsave,kini%kevin,      &
               kini%kmode,gmod%kasino,gmod%elk,gmod%nx,       &
               gmod%ny,gmod%nz,gmod%nelk,gmod%dx,gmod%x0,     &
               gint%npx,gint%npy,gint%npz,cawrk,dawrk,        &
               MAXPOL,accur,h0,hmin,ngod,nbad,jerr)

!-----------------------------------------------------------------------
   end subroutine kinrat_2000
!-----------------------------------------------------------------------




















