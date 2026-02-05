!**************************************************************         
!
!  art_jobfile_1st_module
!
!  Type definitions and subroutine for reading jobfile
!  
!  Modules used       :   iku_io_module  
!                         
!  Programmed         :   Ketil Hokstad January 2000
!                         Ketil Hokstad July    2001
!
!**************************************************************         

module art_jobfile_1st_module

   use iku_io_module
   
   implicit none
   
   public  :: art_user_pars, art_user_names, & ! Type definitions
 	      read_job, write_job              ! Subroutines

   integer, parameter :: max_elk_fil = 7 ! Max no of elastic grid files

type art_user_pars
   !--- General parameters:
   integer           :: is_frst      ! First   shot
   integer           :: is_last      ! Last    shot
   integer           :: is_step      ! Step in shot
   !--- Shooting directions:
   integer           :: npol         ! No of phase angles           
   integer           :: naz2         ! No of azimuth at iapol=2         
   real              :: apol1        ! Min polar angle (-90,90)     
   real              :: apol2        ! Max polar angle (-90,90)     
   real              :: aazi1        ! Min azimuth angle (0,360)    
   real              :: aazi2        ! Max azimuth angle (0,360)     
   !--- Adaptive 4th order Runge Kutta:
   integer           :: maxel        ! Max no of ray elements
   real              :: t0           ! Initial time      (s)   
   real              :: t1           ! Max traveltime    (s)   
   real              :: h0           ! Initial time step (s)   
   real              :: hmin         ! Min time step     (s) 
   real              :: accur        ! Required accuracy    
   !--- Ray tracing options:
   character(len=40) :: ckin         ! Kinetic ray tracing     (ON/OFF)
   character(len=40) :: cdyn2        ! Dynamic ray tracing     (ON/OFF) 
   character(len=40) :: cdir         ! Initial ray direction  (UP/DOWN)   
   character(len=40) :: cevin        ! Sol. of Christ.eq. (FAST/JACOBI)
   !--- Geological model:
   character(len=40) :: casino       ! Anis. symmetry system
   character(len=40) :: cmodpar      ! Model parameterization
   integer           :: nxglb(3)     ! Size of global model  
   real              :: dxglb(3)     ! Node spacing in global grid
   integer           :: npoly        ! Order of interpol. polynomial
   !--- File formats:
   character(len=40) :: fio_cube     ! Migration image window
   character(len=40) :: fio_head     ! Source receiver headers
   character(len=40) :: fio_gmod     ! Geological model
   character(len=40) :: fio_ray      ! Ray tracing data
end type art_user_pars

type art_user_names
   !--- Ray data files
   character(len=lnm) :: sor_pos     ! Source positions    
   character(len=lnm) :: rec_pos     ! Receiver positions  
   character(len=lnm) :: ray_qs1     ! Ray data   file qS1 
   character(len=lnm) :: head_qs1    ! Ray header file qS1 
   character(len=lnm) :: ray_qs2     ! Ray data   file qS2 
   character(len=lnm) :: head_qs2    ! Ray header file qS2 
   character(len=lnm) :: ray_qp      ! Ray data   file qP  
   character(len=lnm) :: head_qp     ! Ray header file qP  
   !--- Geological model:
   character(len=lnm) :: rho         ! Density      grid file      
   character(len=lnm) :: elk(21)     ! Velocities, Thomsen pars and angles 
   !--- Logfile and scratch directories
   character(len=lnm) :: joblog      ! Logfile     
   character(len=lnm) :: errmsg      ! Error messages
   character(len=lnm) :: wrkdir1     ! Scratch/work directory 1
   character(len=lnm) :: wrkdir2     ! Scratch/work directory 2
end type art_user_names

contains
  include 'read_job.f90'
  include 'write_job.f90'

end module art_jobfile_1st_module






