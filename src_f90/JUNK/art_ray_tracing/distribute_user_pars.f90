!**********************************************************************
!
!  Sintef Petroleum Research subroutine distribute_user_pars
!
!  Purpose: Distribute parameters from the jobfile 
!            
!  Subroutines called :   none
!  Functions called   :   none
! 
!  Programmed         :   Ketil Hokstad January 2000
!                         Ketil Hokstad July    2001
!     
!**********************************************************************

subroutine distribute_user_pars(upars,kini,flag_ray,gmod,gint,rkpar,  &
                                station_type,wmod_sor,N_wmod_sor,     &
                                point_glob,sampl_glob,isize_glob,     &
                                approx_medium_sor,mode_rays,dim_gdiv, &
                                inmode_survey,inmode_models,          &
                                fio_models,fio_rays)

   implicit none

   !--- External variables:
   type(art_user_pars),intent(in)    :: upars        ! Pars from jobfile
   type(art_kin_ini)  ,intent(inout) :: kini         ! Initial conditions 
   type(art_ray_ctrl) ,intent(inout) :: flag_ray     ! Flag for raytracing
   type(art_geo_mod)  ,intent(inout) :: gmod         ! Geological model 
   type(art_lag_int)  ,intent(inout) :: gint         ! Lagrange int pars
   type(art_rk_pars)  ,intent(inout) :: rkpar        ! Runge Kutta pars
   ! From EC:
   character(len=*)   ,intent(inout) :: station_type ! SOURCE or RECIEVER
   integer            ,intent(inout) :: N_wmod_sor
   character(len=*)   ,intent(inout) :: wmod_sor(3)
   type(vec_3D)       ,intent(inout) :: point_glob   ! Corner of global grid
   type(vec_3D)       ,intent(inout) :: sampl_glob   ! Sampl. of global grid
   type(intvec_3D)    ,intent(inout) :: isize_glob   ! Size   of global grid
   character(len=*)   ,intent(inout) :: approx_medium_sor ! anis/elas/acou
   character(len=*)   ,intent(inout) :: mode_rays    ! Input mode for rays
   integer            ,intent(inout) :: dim_gdiv     ! Dim. og geom. spread.
   character(len=*)   ,intent(inout) :: inmode_survey! Input mode for bins
   character(len=*)   ,intent(inout) :: inmode_models! Input mode for models
   character(len=*)   ,intent(inout) :: fio_models   ! File format geo model
   character(len=*)   ,intent(inout) :: fio_rays     ! File format ray data

   !--- Internal variables:
   integer          :: i
   character(len=1) :: ctmp1
   character(len=2) :: ctmp2
   character(len=3) :: ctmp3

   !------------------------------------------------------
   !  Get user defined parameters
   !------------------------------------------------------

   !--- General parameters:
   ctmp1 = adjustl(upars%station_type)
   select case (ctmp1)
   case('S','s') 
      station_type = 'SOURCE  ' ! Note: 8-character string
   case('R','r') 
      station_type = 'RECEIVER' ! Note: 8-character string
   end select
   N_wmod_sor   = upars%N_wmod_sor
   do i=1,N_wmod_sor
      wmod_sor(i) = adjustl(upars%wmod_sor(i))
   end do
   point_glob   = upars%point_glob
   sampl_glob   = upars%sampl_glob
   isize_glob   = upars%isize_glob
   
   !--- Survey:
   inmode_survey     = adjustl(upars%inmode_survey)
   approx_medium_sor = adjustl(upars%approx_medium_sor)

   !--- Illumination grids:

   !--- Rays: 
   mode_rays = adjustl(upars%mode_rays)
   dim_gdiv  = upars%dim_gdiv
   fio_rays  = adjustl(upars%fio_rays)

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
   inmode_models = adjustl(upars%inmode_model)
   fio_models    = adjustl(upars%fio_models)
   gmod%nx       = upars%isize_glob%x
   gmod%ny       = upars%isize_glob%y
   gmod%nz       = upars%isize_glob%z
   gmod%x0(1)    = real(upars%point_glob%x,kind=kr4)
   gmod%x0(2)    = real(upars%point_glob%y,kind=kr4)
   gmod%x0(3)    = real(upars%point_glob%z,kind=kr4)
   gmod%dx(1)    = real(upars%sampl_glob%x,kind=kr4)
   gmod%dx(2)    = real(upars%sampl_glob%y,kind=kr4)
   gmod%dx(3)    = real(upars%sampl_glob%z,kind=kr4)

   !--- Input model parameterization:
   ctmp2 = adjustl(upars%inmode_model)
   select case (ctmp2)
   case('TH','Th','th','m1')
      gmod%modpar = k_thomsen
   case('VO','Vo','vo','m2')
      gmod%modpar = k_voigt
   case('TS','Ts','ts','m3')
      gmod%modpar = k_tsvankin
   case default
      gmod%modpar = k_thomsen
   end select

   !--- Anisotropic symmetry:
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

   !--- Lagrange interpolation:
   gint%npx = min(upars%npoly,gmod%nx)
   gint%npy = min(upars%npoly,gmod%ny)
   gint%npz = min(upars%npoly,gmod%nz)

!-----------------------------------------------------------------------
end subroutine distribute_user_pars
!-----------------------------------------------------------------------



