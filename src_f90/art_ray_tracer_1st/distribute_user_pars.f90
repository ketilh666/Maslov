!**********************************************************************
!
!  IKU Seismic distribute_user_pars
!
!
!  Purpose : 
!            
!  Subroutines called :   none
!  Functions called   :   none
! 
!  Programmed         :   Ketil Hokstad January 2000
!     
!**********************************************************************

subroutine distribute_user_pars(upars,kini,flag_ray,gmod,flag_gmod, &
                                gint,rkpar,is_frst,is_last,is_step, &
                                fio_cube,fio_head,fio_gmod,fio_ray)

   implicit none

   !--- External variables: 
   type(art_user_pars),intent(in)    :: upars      ! Pars from jobfile
   type(art_kin_ini)  ,intent(inout) :: kini       ! Initial conditions 
   type(art_ray_ctrl) ,intent(inout) :: flag_ray   ! Flag for raytracing
   type(art_geo_mod)  ,intent(inout) :: gmod       ! Geological model 
   type(art_geo_ctrl) ,intent(inout) :: flag_gmod  ! Flag for geo model
   type(art_lag_int)  ,intent(inout) :: gint       ! Lagrange int pars
   type(art_rk_pars)  ,intent(inout) :: rkpar      ! Runge Kutta pars
   integer            ,intent(inout) :: is_frst    ! First   shot
   integer            ,intent(inout) :: is_last    ! Last    shot
   integer            ,intent(inout) :: is_step    ! Step in shot
   character(len=*)   ,intent(inout) :: fio_cube   ! File format local mod
   character(len=*)   ,intent(inout) :: fio_head   ! File format headers
   character(len=*)   ,intent(inout) :: fio_gmod   ! File format geo model
   character(len=*)   ,intent(inout) :: fio_ray    ! File tracing data

   !--- Internal variables: 
   character(len=1) :: ctmp1
   character(len=2) :: ctmp2
   character(len=3) :: ctmp3
   character(len=4) :: ctmp4

   !------------------------------------------------------
   !  Get user defined parameters
   !------------------------------------------------------

   !--- Shot/receiver/offset counter:
   is_frst      = upars%is_frst
   is_last      = upars%is_last
   is_step      = upars%is_step 

   !--- Initial conditions for ray tracing:
   ctmp1 = adjustl(upars%cdir)
   select case (ctmp1)
   case('U','u') 
      kini%kdir   = K_UP   ! Up-going
   case('D','d') 
      kini%kdir   = K_DN   ! Down-going
   case default
      kini%kdir   = K_DN   ! Down-going
   end select
   ctmp1 = adjustl(upars%cevin)
   select case (ctmp1)
   case('F','f') 
      kini%kevin = KFAST   ! Fast method
   case('J','j') 
      kini%kevin = KBRUT   ! Jacobi iteration
   case default
      kini%kevin = KBRUT   ! Jacobi iteration
   end select
   kini%maxel = upars%maxel
   kini%npol  = upars%npol
   kini%naz2  = upars%naz2
   kini%apol1 = real(upars%apol1,kind=kri)
   kini%apol2 = real(upars%apol2,kind=kri)
   kini%aazi1 = real(upars%aazi1,kind=kri)
   kini%aazi2 = real(upars%aazi2,kind=kri)

   !--- Ray tracing control:
   flag_ray%lkin  = .true.
   flag_ray%ldyn1 = .false.
   ctmp2 = adjustl(upars%cdyn2)
   select case (ctmp2)
   case('ON','On','on')
      flag_ray%ldyn2 = .true.
   case('OF','Of','of') 
      flag_ray%ldyn2 = .false.
   case default
      flag_ray%ldyn2 = .false.
   end select

   !--- 4th order Runge Kutta:
   rkpar%t0     = real(upars%t0   ,kind=krk)
   rkpar%t1     = real(upars%t1   ,kind=krk)
   rkpar%dtsave = real(upars%h0   ,kind=krk)
   rkpar%h0     = real(upars%h0   ,kind=krk)
   rkpar%hmin   = real(upars%hmin ,kind=krk)
   rkpar%accur  = real(upars%accur,kind=krk)

   !--- Geological model:
   ctmp3 = adjustl(upars%cmodpar)
   select case (ctmp3)
   case('THO','Tho','tho')
      gmod%modpar = k_thomsen
   case('VOI','Voi','voi')
      gmod%modpar = k_voigt
   case('TSV','Tsv','tsv')
      gmod%modpar = k_tsvankin
   case default
      gmod%modpar = k_thomsen
   end select
   ctmp3 = adjustl(upars%casino)
   select case (ctmp3)
   case('ISO','Iso','iso')
      gmod%kasino = K_ISO
      gmod%nelk   = 2
   case('TIV','Tiv','tiv')
      gmod%kasino = K_TIV
      gmod%nelk   = 5
   case('TIH','Tih','tih')
      gmod%kasino = K_TIH
      gmod%nelk   = 6
   case('TIG','Tig','tig')
      gmod%kasino = K_TIG
      gmod%nelk   = 7
   case('ORV','Orv','orv')
      gmod%kasino = K_ORV
      gmod%nelk   = 9
   case('ORG','Org','org')
      gmod%kasino = K_ORG
      gmod%nelk   = 11
   case default
      gmod%kasino = K_TIV
      gmod%nelk   = 5
   end select
   gmod%nx = upars%nxglb(1)
   gmod%ny = upars%nxglb(2)
   gmod%nz = upars%nxglb(3)
   gmod%x0 = real(0.0        ,kind=kr4)
   gmod%dx = real(upars%dxglb,kind=kr4)

   !--- Lagrange interpolation:
   gint%npx = min(upars%npoly,gmod%nx)
   gint%npy = min(upars%npoly,gmod%ny)
   gint%npz = min(upars%npoly,gmod%nz)

   !--- File formats:
   fio_cube     = adjustl(upars%fio_cube)
   fio_head     = adjustl(upars%fio_head)
   fio_gmod     = adjustl(upars%fio_gmod)
   fio_ray      = adjustl(upars%fio_ray)

!-----------------------------------------------------------------------
end subroutine distribute_user_pars
!-----------------------------------------------------------------------



