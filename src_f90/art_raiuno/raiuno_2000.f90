!*********************************************************************         
!
!  IKU Seismic subroutine raiuno_2000
!
!  Purpose: Top routine for  kinetic and, optionally, dynamic 
!           ray tracing for a set of selected initial phase angles 
!           by the 4th order (adaptive) Runge-Kutta method.
!
!  References:
!       1. Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          chapters 2.2, 3.6 and 4.14. Lecture notes, 
!          University of Trondheim, 1995.
!       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
!
!  Subroutines called : alloc_kin_sys    alloc_dyn_sys
!                       dealloc_kin_sys  dealloc_dyn_sys
!                       kin_sys_to_sex   kin_sex_to_sys
!                       dyn_sys_to_sex   kin_gdiv_to_sex
!                       kinrat_2000      dynrat_2000
!                       jelway_2000      bfavre_2000
!                       rk_error
!  Functions called   : none
!
!  Programmed  :  Ketil Hokstad January  2000 
!                 Ketil Hokstad March    2000 
!                 
!
!**********************************************************************
    
subroutine raiuno_2000(ksex,dsex1,dsex2,kini,flag,        &
                       gmod,gint,rkpar,ishot,lulog,luerr)

   implicit none

   !--- External variables: 
   type(art_kin_sex)  ,intent(inout) :: ksex    ! Kinetic raytracing
   type(art_dyn_sex)  ,intent(inout) :: dsex1   ! Dynamic plane wave 
   type(art_dyn_sex)  ,intent(inout) :: dsex2   ! Dynamic point source
   type(art_kin_ini)  ,intent(in)    :: kini    ! Initial cond. for kinetic rt
   type(art_ray_ctrl) ,intent(in)    :: flag    ! Ray tracing control flags
   type(art_geo_mod)  ,intent(in)    :: gmod    ! Elastic model
   type(art_lag_int)  ,intent(inout) :: gint    ! Lagrange int parameters
   type(art_rk_pars)  ,intent(in)    :: rkpar   ! Runge Kutta parameters
   integer            ,intent(in)    :: ishot   ! Current shot number
   integer            ,intent(in)    :: luerr   ! Error message file
   integer            ,intent(in)    :: lulog   ! Log file

   !--- Internal variables:  
   type(art_kin_sys) :: ksys
   type(art_dyn_sys) :: dsys1,dsys2

   integer   ::  ir,jr,ip,ia
   integer   ::  maxel,maxry
   integer   ::  ls
   integer   ::  ierr,jerr,i

   real(krx) ::  apol,aazi

   !--- Allocatebale work arrays:
   real(kry), allocatable :: gsray(:,:,:)
   integer  , allocatable :: kindx(  :,:)

   !-----------------------------------------------------------------------
   !   Write header to error message file
   !-----------------------------------------------------------------------

   write(luerr,1) '# SHOT:',ishot,               &
                  '  MODE:',kini%kmode(1),       &
                  '  X0_i=',(kini%xsrc(i),i=1,3)
1  format(A,I6,A,I4,A,3F10.2)

   !-----------------------------------------------------------------------
   !   Allocate memory for kinetic and dynamic work variables (real*8)
   !-----------------------------------------------------------------------

   !--- Size of real*8 work arrays:
   maxel = ksex%maxel
   maxry = ksex%maxray

   ls = 0
   call alloc_kin_sys(ksys,maxel,maxry,stat=ls)
   if (flag%ldyn1) call alloc_dyn_sys(dsys1,maxel,maxry,stat=ls)
   if (flag%ldyn2) call alloc_dyn_sys(dsys2,maxel,maxry,stat=ls)
   allocate(gsray(1:2,1:maxel,1:maxry), &
            kindx(    1:maxel,1:maxry), stat=ls)

   if (ls.ne.0) then
      write(luerr,*) 'Subroutine raiuno_2000: Memory allocation failed. Stop.'
      stop
   end if

!   write(6,*) 'SUBROUTINE: raiuno_2000'
!   write(6,*) ' * raiuno_2000: Real*8 mem alloc: maxel,maxry = ',maxel,maxry

   !-----------------------------------------------------------------------
   !   Initialize
   !-----------------------------------------------------------------------

   call init_kin_sex(ksex,kini)

   !-----------------------------------------------------------------------
   !
   !   LOOP OVER INITIAL PHASE ANGLES:
   !   * ip, apol =>  Polar   angle with the z-axis 
   !   * ia, aazi =>  Azimuth angle in the (x,y)-plane
   !
   !-----------------------------------------------------------------------
   
!!$   write(6,*) ' * Paralell loop:'

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(DYNAMIC,1)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (ksex,dsex1,dsex2,kini,gmod,gint,   &
   !$OMP            rkpar,ksys,dsys1,dsys2,gsray,      &
   !$OMP            kindx,flag,luerr,lulog)            &
   !$OMP    PRIVATE(ir,jr,ia,ip,apol,aazi,ierr,jerr)
   do ir=1,ksex%nray

      !-------------------------------------------------------------
      !   Initialize
      !-------------------------------------------------------------

      apol = ksex%apol(ir) 
      aazi = ksex%aazi(ir) 
      jr   = ir
      ip   = ir  ! Not correct, but not important
      ia   = 1   ! Not correct, but not important

!!$      write(6,*) 'raiuno_2000: ir = ',ir

      !-------------------------------------------------------------
      !   Kinetic raytracing
      !-------------------------------------------------------------

      if (flag%lkin) then
         call kinrat_2000(ksys,jr,kini,gmod,gint,           &
                          rkpar,apol,aazi,ierr,jerr)
         call kin_sys_to_sex(ksex,ir,ksys,jr)
         call rk_error(luerr,'KINZRO',ip,ia,ksys%nel(jr),ierr)
         call rk_error(luerr,'KININT',ip,ia,ksys%nel(jr),jerr)
      else
         call kin_sex_to_sys(ksys,jr,ksex,ir)
      end if

      !-------------------------------------------------------------
      !   Dynamic raytracing 1: Plane wave
      !-------------------------------------------------------------

      !--- Currently not of interest.

      !-------------------------------------------------------------
      !   Dynamic raytracing 2: Point source
      !-------------------------------------------------------------

      if (flag%ldyn2) then
         call dynrat_2000(dsys2,ksys,jr,kini,KPOINT,gmod,gint, &
                          rkpar,apol,aazi,ierr,jerr)
         call rk_error(luerr,'DYNZRO',ip,ia,ksys%nel(jr),ierr)
         call rk_error(luerr,'DYNINT',ip,ia,ksys%nel(jr),jerr)
      end if

      !-------------------------------------------------------------
      !  Geometrical spreading along the ray
      !-------------------------------------------------------------

      if (flag%ldyn2) then
         call jelway_2000(ksys,dsys2,jr,gsray,kindx)
      else
         call bfavre_2000(ksys,jr,gsray,kindx)
      endif
      call kin_gdiv_to_sex(ksex,ir,ksys,jr,gsray,kindx)

   enddo

   !-----------------------------------------------------------------------
   !   Deallocate memory for kinetic and dynamic work variables (real*8)
   !-----------------------------------------------------------------------

   ls = 0
   deallocate(kindx,gsray,stat=ls)
   call alloc_kin_sys(ksys,stat=ls)
   if (flag%ldyn1) call dealloc_dyn_sys(dsys1,stat=ls)
   if (flag%ldyn2) call dealloc_dyn_sys(dsys2,stat=ls)

!-----------------------------------------------------------------------
 end subroutine raiuno_2000
!-----------------------------------------------------------------------




