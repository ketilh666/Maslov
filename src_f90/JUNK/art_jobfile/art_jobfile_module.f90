!**************************************************************         
!
!  art_jobfile_module
!
!  Type definitions and subroutine for reading jobfile
!  
!  Modules used       :   iku_io_module
!                         iku_vector_module
!                         
!  Programmed         :   Ketil Hokstad January 2000
!                         Ketil Hokstad July    2001
!
!**************************************************************         

module art_jobfile_module

   use iku_io_module
   use iku_vector_module
   
   implicit none
   
   public  :: art_user_pars,          & ! Type definitions
 	      read_job, write_job       ! Subroutines

   private :: check_file_names, check_wavemodes

type art_user_pars
   !--- Shooting directions (polar and azimuth):
   integer           :: npol          ! No of phase angles           
   integer           :: naz2          ! No of azimuth at iapol=2         
   real              :: apol1         ! Min polar angle (-90,90)     
   real              :: apol2         ! Max polar angle (-90,90)     
   real              :: aazi1         ! Min azimuth angle (0,360)    
   real              :: aazi2         ! Max azimuth angle (0,360)     
   !--- Adaptive 4th order Runge Kutta:
   integer           :: maxel         ! Max no of ray elements
   real              :: t0            ! Initial time      (s)   
   real              :: t1            ! Max traveltime    (s)   
   real              :: h0            ! Initial time step (s)   
   real              :: hmin          ! Min time step     (s) 
   real              :: accur         ! Required accuracy    
   !--- Ray tracing options:
   character(len=40) :: ckin          ! Kinetic ray tracing     (ON/OFF)
   character(len=40) :: cdyn2         ! Dynamic ray tracing     (ON/OFF) 
   character(len=40) :: cdir          ! Initial ray direction  (UP/DOWN)   
   character(len=40) :: cevin         ! Sol. of Christ.eq. (FAST/JACOBI)
   !--- Geological model:
   character(len=40) :: casino        ! Anis. symmetry system
   character(len=40) :: cmodpar       ! Model parameterization
   integer           :: nxglb(3)      ! Size of global model  
   real              :: dxglb(3)      ! Node spacing in global grid
   integer           :: npoly         ! Order of interpol. polynomial
   !--- Error messages and scratch directories:
   character(len=40) :: errmsg      ! Error messages
   character(len=40) :: wrkdir1     ! Scratch/work directory 1
   character(len=40) :: wrkdir2     ! Scratch/work directory 2
   !--- General user parameters (copied from kam_jobfile_module)
   character(len=40) :: station_type  ! SOURCE or RECEIVER
   character(len=3)  :: wavemode(3)   ! Wave modes (P0 S1 S2)
   type(vec_3D)      :: point_glob    ! Corner of global grid (m)
   type(vec_3D)      :: sampl_glob    ! Sampling for global grid (m) 
   type(intvec_3D)   :: isize_glob    ! Integer size of global grid 
   character(len=40) :: name_log_file ! Name of log file
   !--- Survey parameters (copied from kam_jobfile_module)
   character(len=40) :: inmode_survey               ! Input mode for survey
   character(len=40) :: name_survey_sor_file        ! File for source bins
   character(len=40) :: approx_medium_sor           ! Medium at sor: an/el/ac
   character(len=40) :: name_survey_sor_data_base   ! File for sor data base
   !--- Illumination parameters
   character(len=40) :: name_illum_file             ! File for illum. wind.
   character(len=40) :: name_illum_sor_P0_data_base ! Data base for ill. w.
   character(len=40) :: name_illum_sor_S1_data_base ! Data base for ill. w.
   character(len=40) :: name_illum_sor_S2_data_base ! Data base for ill. w.
   !--- Model parameters
   character(len=40) :: inmode_model                ! Input mode for model
   character(len=40) :: name_model_file             ! Descr. file for model
   character(len=40) :: fio_models                  ! Format model files
   !--- Ray parameters
   character(len=40) :: mode_rays                   ! Input mode for rays
   character(len=40) :: fio_rays                    ! Format ray data base
   integer           :: dim_gdiv                    ! dim geom spread (1/2/3)
   character(len=40) :: name_ray_sor_P0_data_base   ! Data base for rays
   character(len=40) :: name_ray_sor_S1_data_base   ! Data base for rays
   character(len=40) :: name_ray_sor_S2_data_base   ! Data base for rays
   !--- Parameters defined in subroutine check_wavemodes
   character(len=2)  :: wmod_sor(3)                 ! Wave modes 
   integer           :: N_wmod_sor                  ! Nr of wave modes 
end type art_user_pars

contains
  include 'read_job.f90'
  include 'write_job.f90'
  include 'check_file_names.f90'
  include 'check_wavemodes.f90'

end module art_jobfile_module






