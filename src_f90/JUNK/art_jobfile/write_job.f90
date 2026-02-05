!**********************************************************************
!
!  IKU Seismic subroutine write_job
!
!
!  Purpose : Write jobfile for TIV elastic Kirchhoff migration
!            
!  Subroutines called :   none
!  Functions called   :   none
! 
!  Programmed         :   Ketil Hokstad October 1997 
!     
!**********************************************************************

subroutine write_job(lu,upars)

   implicit none

   !--- External variables:
   integer              ,intent(in) :: lu
   type(art_user_pars)  ,intent(in) :: upars
!CUT   type(art_user_names) ,intent(in) :: uname

   !--- Internal variables:
   integer :: i

   !-----------------------------------------------------------------
   !    Input formats
   !-----------------------------------------------------------------

1  format(a40,x,a35)
2  format(a40,x,3a3)
3  format(a40,x,3f9.1)
4  format(a40,x,a2,x,a2,x,a2)
5  format(a40,x,a2)
6  format(a40,x,6i9)
8  format(a40,x,i9)
9  format(a40,x,f9.1)
10 format(a40,x,f9.5)
11 FORMAT(a40,a35)
12 FORMAT(a40,i8)
13 FORMAT(a40,f12.6)
14 FORMAT(a)
  
   !-----------------------------------------------------------------
   !    Start writing job file
   !-----------------------------------------------------------------

   WRITE(lu,14)'************************************************************'
   WRITE(lu,14)'* JOBFILE FOR IKU ANISOTROPIC RAY TRACER Version 1.0       *'
   WRITE(lu,14)'************************************************************'
   write(lu,14)'****************************************'
   write(lu,14)'* GENERAL USER PARAMETERS              *'
   write(lu,14)'****************************************'
   write(lu,1) 'RAY TRACING MODE      (SOURCE/RECEIVER):', upars%station_type
   write(lu,2) 'ONE-WAY WAVE MODES          (P0 S1 S2) :', &
                                            upars%wavemode(1:upars%N_wmod_sor)   
   write(lu,3) 'CORNER GLOBAL GRID        (x,y,z) in m :', upars%point_glob
   write(lu,3) 'SAMPLING GLOBAL GRID   (dx,dy,dz) in m :', upars%sampl_glob
   write(lu,6) 'SIZE GLOBAL GRID            (nx,ny,nz) :', upars%isize_glob
   write(lu,1) 'LOG FILE              (file name/none) :', upars%name_log_file
   write(lu,14)'****************************************'
   write(lu,14)'* SURVEY                               *'
   write(lu,14)'* m1: regular bins (Thomsen param)     *'
   write(lu,14)'* m2: irregular bins                   *'
   write(lu,14) '****************************************'
   write(lu,1) 'INPUT MODE                             :', upars%inmode_survey
   write(lu,1) 'DESCRIPTION FILE FOR SOURCE BINS       :', upars%name_survey_sor_file
   write(lu,1) 'MEDIUM AT SOR BINS    (anis/elas/acou) :', upars%approx_medium_sor   
   write(lu,1) 'DATA BASE FOR SOURCE BINS              :', upars%name_survey_sor_data_base
   write(lu,14)'****************************************'
   write(lu,14)'* ILLUMINATION GRIDS                   *'
   write(lu,14)'****************************************'
   write(lu,1) 'DESCRIPTION FILE                       :', upars%name_illum_file
   write(lu,1) 'DATA BASE FOR P0 SOURCE GRIDS          :', upars%name_illum_sor_P0_data_base
   write(lu,1) 'DATA BASE FOR S1 SOURCE GRIDS          :', upars%name_illum_sor_S1_data_base
   write(lu,1) 'DATA BASE FOR S2 SOURCE GRIDS          :', upars%name_illum_sor_S2_data_base
   write(lu,14)'****************************************'
   write(lu,14)'* GEOLOGICAL MODEL                     * '
   write(lu,14)'* m1: Thomsen parameters               * '
   write(lu,14)'* m2: Voigt parameters                 * '
   write(lu,14)'* m3: Tsvankin parameters (A2, A4, A5) * '
   write(lu,14)'****************************************'
   write(lu,1) 'INPUT MODE                             :', upars%inmode_model
   write(lu,1) 'DESCRIPTION FILE                       :', upars%name_model_file
   write(lu,1) 'FORMAT MODEL FILES           (dir/seq) :', upars%fio_models
   WRITE(lu,11)'Anis. symmetry    (TIV/TIH/TIG/ORV/ORG):', upars%casino
   WRITE(lu,12)'Order of interpol. polynomial   (NPOLY):', upars%npoly
   write(lu,14)'****************************************'
   write(lu,14)'* RAYS                                 * '
   write(lu,14)'* m1: traveltime only (and maxpat=1)   * '
   write(lu,14)'* m2: time, gdiv, p_surf               * '
   write(lu,14)'* m3: kmah, time, gdiv, p_surf, g_surf * '
   write(lu,14)'* m4: same as m3 + p_down              * '
   write(lu,14)'****************************************'
   write(lu,1) 'RAY MODE                               :', upars%mode_rays 
   write(lu,1) 'FORMAT RAY FILES             (dir/seq) :', upars%fio_rays
   write(lu,8) 'DIMENSION GEOM SPREADING       (1/2/3) :', upars%dim_gdiv
   write(lu,1) 'ROOT NAME P0 SOURCE RAY DATA BASE      :', upars%name_ray_sor_P0_data_base
   write(lu,1) 'ROOT NAME S1 SOURCE RAY DATA BASE      :', upars%name_ray_sor_S1_data_base
   write(lu,1) 'ROOT NAME S2 SOURCE RAY DATA BASE      :', upars%name_ray_sor_S2_data_base
   WRITE(lu,14)'****************************************'
   WRITE(lu,14)'* SHOOTING DIRECTIONS                  *'
   WRITE(lu,14)'****************************************'
   WRITE(lu,12)'No of phase angles               (NPOL):', upars%npol
   WRITE(lu,12)'No of azimuth angles             (NAZ2):', upars%naz2
   WRITE(lu,13)'Min polar angle (-90,90)        (PANG1):', upars%apol1
   WRITE(lu,13)'Max polar angle (-90,90)        (PANG2):', upars%apol2
   WRITE(lu,13)'Min azimuth angle (0,360)       (AZIM1):', upars%aazi1
   WRITE(lu,13)'Max azimuth angle (0,360)       (AZIM2):', upars%aazi2
   WRITE(lu,14)'****************************************'
   WRITE(lu,14)'* ADAPTIVE 4TH ORDER RUNGE KUTTA       *'
   WRITE(lu,14)'****************************************'
   WRITE(lu,12)'Max no of ray elements          (MAXEL):', upars%maxel
   WRITE(lu,13)'Initial time      (s)              (TO):', upars%t0
   WRITE(lu,13)'Max traveltime    (s)              (T1):', upars%t1
   WRITE(lu,13)'Initial time step (s)              (H0):', upars%h0
   WRITE(lu,13)'Min time step     (s)            (HMIN):', upars%hmin
   WRITE(lu,13)'Required accuracy               (ACCUR):', upars%accur
   WRITE(lu,14)'****************************************'
   WRITE(lu,14)'* RAY TRACING OPTIONS                  *'
   WRITE(lu,14)'****************************************'
   WRITE(lu,11)'Kinetic ray tracing (ON/OFF)           :', upars%ckin
   WRITE(lu,11)'Dynamic ray tracing (ON/OFF)           :', upars%cdyn2
   WRITE(lu,11)'Initial ray direction (UP/DOWN)        :', upars%cdir
   WRITE(lu,11)'Sol. of Christoffel eq. (FAST/JACOBI)  :', upars%cevin
   WRITE(lu,14)'****************************************'
   WRITE(lu,14)'* LOGFILE AND SCRATCH DIRECTORIES      *'
   WRITE(lu,14)'****************************************'
   WRITE(lu,11)'Error messages                  (ascii):', upars%errmsg
   WRITE(lu,11)'Scratch/Work directory 1      (WRKDIR1):', upars%wrkdir1
   WRITE(lu,11)'Scratch/Work directory 2      (WRKDIR2):', upars%wrkdir2
   WRITE(lu,14)'************************************************************'
   WRITE(lu,14)'*                   END OF JOB FILE                        *'
   WRITE(lu,14)'************************************************************'

!------------------------------------------------------
end subroutine write_job
!------------------------------------------------------





