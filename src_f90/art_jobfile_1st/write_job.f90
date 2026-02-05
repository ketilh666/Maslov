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

subroutine write_job(lu,upars,uname)

   implicit none

   !--- External variables:
   integer              ,intent(in) :: lu
   type(art_user_pars)  ,intent(in) :: upars
   type(art_user_names) ,intent(in) :: uname

   !--- Internal variables:
   integer :: i

   !-----------------------------------------------------------------
   !    Input formats
   !-----------------------------------------------------------------

1 FORMAT(a41,a35)
2 FORMAT(a41,i8)
3 FORMAT(a41,f12.6)
4 FORMAT(a)
  
   !-----------------------------------------------------------------
   !    Start writing job file
   !-----------------------------------------------------------------

   WRITE(lu,4)'************************************************************'
   WRITE(lu,4)'* JOBFILE FOR IKU ANISOTROPIC RAY TRACER Version 0.9       *'
   WRITE(lu,4)'************************************************************'
   WRITE(lu,4)'****************************************'
   WRITE(lu,4)'* GENERAL PARAMETERS                   *'
   WRITE(lu,4)'****************************************'  
   WRITE(lu,2)'FIRST   SHOT                  (IS_FRST):',upars%is_frst
   WRITE(lu,2)'LAST    SHOT                  (IS_LAST):',upars%is_last
   WRITE(lu,2)'STEP IN SHOT                  (IS_STEP):',upars%is_step
   WRITE(lu,4)'****************************************'
   WRITE(lu,4)'* SHOOTING DIRECTIONS                  *'
   WRITE(lu,4)'****************************************'
   WRITE(lu,2)'No of phase angles               (NPOL):',upars%npol
   WRITE(lu,2)'No of azimuth angles             (NAZ2):',upars%naz2
   WRITE(lu,3)'Min polar angle (-90,90)        (PANG1):',upars%apol1
   WRITE(lu,3)'Max polar angle (-90,90)        (PANG2):',upars%apol2
   WRITE(lu,3)'Min azimuth angle (0,360)       (AZIM1):',upars%aazi1
   WRITE(lu,3)'Max azimuth angle (0,360)       (AZIM2):',upars%aazi2
   WRITE(lu,4)'****************************************'
   WRITE(lu,4)'* ADAPTIVE 4TH ORDER RUNGE KUTTA       *'
   WRITE(lu,4)'****************************************'
   WRITE(lu,2)'Max no of ray elements          (MAXEL):',upars%maxel
   WRITE(lu,3)'Initial time      (s)              (TO):',upars%t0
   WRITE(lu,3)'Max traveltime    (s)              (T1):',upars%t1
   WRITE(lu,3)'Initial time step (s)              (H0):',upars%h0
   WRITE(lu,3)'Min time step     (s)            (HMIN):',upars%hmin
   WRITE(lu,3)'Required accuracy               (ACCUR):',upars%accur
   WRITE(lu,4)'****************************************'
   WRITE(lu,4)'* RAY TRACING OPTIONS                  *'
   WRITE(lu,4)'****************************************'
   WRITE(lu,1)'Kinetic ray tracing (ON/OFF)           :',upars%ckin
   WRITE(lu,1)'Dynamic ray tracing (ON/OFF)           :',upars%cdyn2
   WRITE(lu,1)'Initial ray direction (UP/DOWN)        :',upars%cdir
   WRITE(lu,1)'Sol. of Christoffel eq. (FAST/JACOBI)  :',upars%cevin
   WRITE(lu,1)'Source positions                (ascii):',uname%sor_pos
   WRITE(lu,1)'Receiver positions              (ascii):',uname%rec_pos
   WRITE(lu,1)'Ray data   file qS1 (Slow S-wave) (bin):',uname%ray_qs1
   WRITE(lu,1)'Ray header file qS1 (Slow S-wave) (bin):',uname%head_qs1
   WRITE(lu,1)'Ray data   file qS2 (Fast S-wave) (bin):',uname%ray_qs2
   WRITE(lu,1)'Ray header file qS2 (Fast S-wave) (bin):',uname%head_qs2
   WRITE(lu,1)'Ray data   file qP                (bin):',uname%ray_qp
   WRITE(lu,1)'Ray header file qP                (bin):',uname%head_qp
   WRITE(lu,4)'****************************************'
   WRITE(lu,4)'* GRIDDED GEOLOGICAL MODEL             *'
   WRITE(lu,4)'****************************************'
   WRITE(lu,1)'Anis. symmetry (TIV/TIH/TIG/ORV/ORG)   :',upars%casino
   WRITE(lu,1)'Model parameterization (THOMSEN/VOIGT) :',upars%cmodpar
   WRITE(lu,2)'X-size of global  grid on disk     (NX):',upars%nxglb(1)
   WRITE(lu,2)'Y-size of global  grid on disk     (NY):',upars%nxglb(2)
   WRITE(lu,2)'Z-size of global  grid on disk     (NZ):',upars%nxglb(3)
   WRITE(lu,3)'X-sampl. of 2D/3D grid on disk (m) (DX):',upars%dxglb(1)
   WRITE(lu,3)'Y-sampl. of 2D/3D grid on disk (m) (DY):',upars%dxglb(2)
   WRITE(lu,3)'Z-sampl. of 2D/3D grid on disk (m) (DZ):',upars%dxglb(3)
   WRITE(lu,2)'Order of interpol. polynomial   (NPOLY):',upars%npoly
   WRITE(lu,1)'2D/3D Density      grid file      (bin):',uname%rho
   do i=1,max_elk_fil
      WRITE(lu,1)'2D/3D Elastic grid file           (bin):',uname%elk(i)
   end do
   WRITE(lu,4)'****************************************'
   WRITE(lu,4)'* LOGFILE AND SCRATCH DIRECTORIES      *'
   WRITE(lu,4)'****************************************'
   WRITE(lu,1)'Joblog                          (ascii):',uname%joblog
   WRITE(lu,1)'Error messages                  (ascii):',uname%errmsg
   WRITE(lu,1)'Scratch/Work directory 1      (WRKDIR1):',uname%wrkdir1
   WRITE(lu,1)'Scratch/Work directory 2      (WRKDIR2):',uname%wrkdir2
   WRITE(lu,4)'****************************************'
   WRITE(lu,4)'* FILE FORMATS OF BIN/ASCII FILES      *'
   WRITE(lu,4)'****************************************'
   WRITE(lu,1)'Image cube file         (iku/hyb/2d/3d):',upars%fio_cube
   WRITE(lu,1)'Source header file      (iku/hyb/2d/3d):',upars%fio_head
   WRITE(lu,1)'Geo model grid  files         (dir/seq):',upars%fio_gmod
   WRITE(lu,1)'Ray data output files         (dir/seq):',upars%fio_ray
   WRITE(lu,4)'************************************************************'
   WRITE(lu,4)'*                   END OF JOB FILE                        *'
   WRITE(lu,4)'************************************************************'

!------------------------------------------------------
end subroutine write_job
!------------------------------------------------------





