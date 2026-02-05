!**********************************************************************
!
!  IKU Seismic subroutine read_job
!
!
!  Purpose : Read jobfile for 3D anisotropic ray tracing
!            
!  Subroutines called :   none
!  Functions called   :   none
! 
!  Programmed         :   Ketil Hokstad January 2000
!                         Ketil Hokstad July    2001
!     
!**********************************************************************

subroutine read_job(lu,upars)

   implicit none

   !--- External variables:
   integer              ,intent(in)  :: lu
   type(art_user_pars)  ,intent(out) :: upars
!CUT   type(art_user_names) ,intent(out) :: uname


   !--- Internal variables:
   integer :: i,ioerr

   !-----------------------------------------------------------------
   !    Input formats
   !-----------------------------------------------------------------

1  format(40x,a40)
2  format(40x,3a3)
3  format(40x,3f9.1)
6  format(40x,3i9)
8  format(40x,i9)
9  format(40x,f9.1)
10 format(40x,f9.5)
11 format(40x,a40)
12 format(40x,i8)
13 format(40x,f12.6)
14 format(A)

   !-----------------------------------------------------------------
   !    Read jobfile
   !-----------------------------------------------------------------

   !--- Jobfile header:
   read(lu,*)
   read(lu,*)
   read(lu,*)

   !--- General parameters:
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,1) upars%station_type           ! SOURCE or RECEIVER
   read(lu,2,iostat=ioerr) upars%wavemode  ! Wave modes (P0_P0,P0_S1,...)
   if (ioerr /= 0) then
      write(6,*) 'ERROR: Problem while reading wave modes from job file'
      write(6,*) 'STOP THE PROGRAM from routine kam_read_jobfile'
      stop
   end if
   read(lu,3) upars%point_glob    ! Corner of global grid (X,Y,Z)
   read(lu,3) upars%sampl_glob    ! Sampling of global grid (DX,DY,DZ)
   read(lu,6) upars%isize_glob    ! Integer size global grid (NX,NY,NZ)
   read(lu,1) upars%name_log_file ! Name of log file
  
   !--- Survey:
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,1) upars%inmode_survey
   read(lu,1) upars%name_survey_sor_file
   read(lu,1) upars%approx_medium_sor
   read(lu,1) upars%name_survey_sor_data_base

!--- Illumination grids:
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,1) upars%name_illum_file
   read(lu,1) upars%name_illum_sor_P0_data_base
   read(lu,1) upars%name_illum_sor_S1_data_base
   read(lu,1) upars%name_illum_sor_S2_data_base

   !--- Geological model
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,1) upars%inmode_model
   read(lu,1) upars%name_model_file
   read(lu,1) upars%fio_models
   read(lu,11)upars%casino
   read(lu,12)upars%npoly

   !--- Ray databases
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,*)
   read(lu,1) upars%mode_rays
   read(lu,1) upars%fio_rays
   read(lu,8) upars%dim_gdiv
   read(lu,1) upars%name_ray_sor_P0_data_base
   read(lu,1) upars%name_ray_sor_S1_data_base
   read(lu,1) upars%name_ray_sor_S2_data_base

   !--- Shooting directions (Initial polar and azimuth angles):
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,12)upars%npol
   read(lu,12)upars%naz2
   read(lu,13)upars%apol1
   read(lu,13)upars%apol2
   read(lu,13)upars%aazi1
   read(lu,13)upars%aazi2

   !--- Adaptive 4th order Runge Kutta: 
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,12)upars%maxel
   read(lu,13)upars%t0
   read(lu,13)upars%t1
   read(lu,13)upars%h0
   read(lu,13)upars%hmin
   read(lu,13)upars%accur

   !--- Ray tracing options:
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,11)upars%ckin
   read(lu,11)upars%cdyn2
   read(lu,11)upars%cdir
   read(lu,11)upars%cevin      ! How to solve the Christoffel equation

   !--- Logfile and scratch directories:
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,11)upars%errmsg
   read(lu,11)upars%wrkdir1
   read(lu,11)upars%wrkdir2

   !-----------------------------------------------------------------------
   !  Remove leading blanks from input character strings
   !-----------------------------------------------------------------------

   upars%station_type                = adjustl(upars%station_type)
   upars%name_log_file               = adjustl(upars%name_log_file)
   upars%name_survey_sor_file        = adjustl(upars%name_survey_sor_file)
   upars%approx_medium_sor           = adjustl(upars%approx_medium_sor)
   upars%name_survey_sor_data_base   = adjustl(upars%name_survey_sor_data_base)
   upars%inmode_survey               = adjustl(upars%inmode_survey)
   upars%name_illum_file             = adjustl(upars%name_illum_file)
   upars%name_illum_sor_P0_data_base = adjustl(upars%name_illum_sor_P0_data_base)
   upars%name_illum_sor_S1_data_base = adjustl(upars%name_illum_sor_S1_data_base)
   upars%name_illum_sor_S2_data_base = adjustl(upars%name_illum_sor_S2_data_base)
   upars%name_model_file             = adjustl(upars%name_model_file)
   upars%fio_models                  = adjustl(upars%fio_models)
   upars%inmode_model                = adjustl(upars%inmode_model)
   upars%mode_rays                   = adjustl(upars%mode_rays)
   upars%fio_rays                    = adjustl(upars%fio_rays)
   upars%name_ray_sor_P0_data_base   = adjustl(upars%name_ray_sor_P0_data_base)
   upars%name_ray_sor_S1_data_base   = adjustl(upars%name_ray_sor_S1_data_base)
   upars%name_ray_sor_S2_data_base   = adjustl(upars%name_ray_sor_S2_data_base)
   do i=1,3
      upars%wavemode(i) = adjustl(upars%wavemode(i))
   end do

   !-- Check for wrong input format
   call check_wavemodes(upars)
   call check_file_names(upars)

!-----------------------------------------------------------------------
end subroutine read_job
!-----------------------------------------------------------------------


