!**************************************************************         
!
!  IKU Seismic subroutine ray_tracer
!
!  Purpose: Driver routine for  kinetic and, optionally, dynamic 
!           ray tracing for a set of selected initial phase angles. 
!
!  References:
!       1. Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          chapters 2.2, 3.6 and 4.14. Lecture notes, 
!          University of Trondheim, 1995.
!       2. Numerical Receipes in Fortran, chapters 11.1 and 16.2.
!
!  Subroutines called : alloc_kin_sex, alloc_dyn_sex
!                       raiuno_2000,
!  Functions called   : none
!
!  Programmed  :  Ketil Hokstad January  2000 
!                 Ketil Hokstad April    2000
!                 
!**********************************************************************
    
subroutine ray_tracer(upars,uname,lulog)

   implicit none 

   !--- External variables: 
   type(art_user_pars)  ,intent(in) :: upars  ! Parameters from the jobfile
   type(art_user_names) ,intent(in) :: uname  ! File names from jobfile
   integer              ,intent(in) :: lulog  ! Log file unit number

   !--- Internal variables:
   type(art_kin_ini)   :: kini            ! Initial conditions for kinetic rt
   type(art_ray_ctrl)  :: flag_ray        ! Flag for raytracing (kin/dyn/modes)
   type(art_kin_sex)   :: ksex, ksex_cz   ! Kinetic ray tracing system
   type(art_dyn_sex)   :: dsex1, dsex2    ! Dynamic ray tracing system
   type(art_kin_grid)  :: kgrid           ! Kinetic system on grid
   type(art_geo_mod)   :: gmod            ! Geological model on grid
   type(art_geo_ctrl)  :: flag_gmod       ! Flag for anisotropic symmetry type
   type(art_lag_int)   :: gint            ! Lagrange int parameters
   type(art_rk_pars)   :: rkpar           ! Runge Kutta parameters
 
   integer             :: is_frst,is_last ! Loop counters
   integer             :: ishot,is_step   ! Loop counters
   integer             :: kmode1,kmode(3) ! Wave modes
   integer             :: maxel,maxray
   integer             :: ls
   integer             :: luerr,nrecl
   logical             :: ldebug          ! Write debugging info on/off

   integer  :: maxpat,nx_kgrid,ny_kgrid,nz_kgrid

   !--- I/O file formats:
   character(len=20)   :: fio_cube        ! File format local/image cube
   character(len=20)   :: fio_head        ! File format headers
   character(len=20)   :: fio_gmod        ! File format TIV grids
   character(len=20)   :: fio_ray         ! File format raytor data

   !--- I/O files (unit numbers etc.)
   type(art_geo_files) :: files_gmod
   type(file_type)     :: file_cube
   type(file_type)     :: file_sor_hd
   type(file_type)     :: file_rec_hd
   type(file_type)     :: file_err

   !--- Debugging:
   type(file_type)     :: file_ascii  ,file_npat
   type(file_type)     :: file_ray_xy ,file_ray_xz ,file_ray_yz 
   type(file_type)     :: file_time_cz,file_time_cy,file_time_cx
   type(file_type)     :: file_gdiv_cz,file_gdiv_cy,file_gdiv_cx
   type(file_type)     :: file_pvec_cz,file_pvec_cy,file_pvec_cx
   type(file_type)     :: file_sor_pos

   real    :: rwrk(2)
   real    :: qheat, vclay
   integer :: lut,izut,kwrk,ip,lsor
   integer :: i,j,k,jx,jy,incx,incy
   integer :: ind1st
   integer :: nsor   ! Number of sources
   real    :: x0(3)  ! Origion of the Coordinate system
   real    :: xsor(3,10000), qsf(10000), qscl


   !----------------------------------------------------------------------
   !   JOB SETUP:
   !    * Distribute user defined parameters
   !    * Check existence of user files (from names on jobfile)
   !----------------------------------------------------------------------   

   call distribute_user_pars(upars,kini,flag_ray,gmod,flag_gmod, &
                             gint,rkpar,is_frst,is_last,is_step, &
                             fio_cube,fio_head,fio_gmod,fio_ray    )
   call check_user_names(uname,upars,flag_ray,flag_gmod,gmod%kasino)

   ldebug      = .true.

   !**************************
   !  Hardcoded output grid
   !**************************

   maxpat      = 3
   nx_kgrid    = upars%nxglb(1)
   ny_kgrid    = upars%nxglb(2)
   nz_kgrid    = upars%nxglb(3)

   kgrid%x0(1) = 0.0
   kgrid%x0(2) = 0.0
   kgrid%x0(3) = 0.0

   kgrid%dx(1) = upars%dxglb(1)
   kgrid%dx(2) = upars%dxglb(2)
   kgrid%dx(3) = upars%dxglb(3)

   kgrid%ksort = k_min_time

   incx = 5
   incy = 5

   !----------------------------------------------------------------------
   !   Open files for debugging
   !----------------------------------------------------------------------  

   if (ldebug) then
      call iku_open(file_ascii  ,'DB_DUMP.ASCII'  ,'write','ascii')
      call iku_open(file_npat   ,'DB_NPAT.DIR'    ,'write','dir',nx_kgrid)
      call iku_open(file_ray_xy ,'DB_RAY_XY.DIR'  ,'write','dir',2)
      call iku_open(file_ray_xz ,'DB_RAY_XZ.DIR'  ,'write','dir',2)
      call iku_open(file_ray_yz ,'DB_RAY_YZ.DIR'  ,'write','dir',2)
      call iku_open(file_time_cz,'DB_TIME_CZ.DIR' ,'write','dir',2)
      call iku_open(file_time_cy,'DB_TIME_CY.DIR' ,'write','dir',2)
      call iku_open(file_time_cx,'DB_TIME_CX.DIR' ,'write','dir',2)
      call iku_open(file_gdiv_cz,'DB_GDIV_CZ.DIR' ,'write','dir',2)
      call iku_open(file_gdiv_cy,'DB_GDIV_CY.DIR' ,'write','dir',2)
      call iku_open(file_gdiv_cx,'DB_GDIV_CX.DIR' ,'write','dir',2)
      call iku_open(file_pvec_cz,'DB_PVEC_CZ.DIR' ,'write','dir',2)
      call iku_open(file_pvec_cy,'DB_PVEC_CY.DIR' ,'write','dir',2)
      call iku_open(file_pvec_cx,'DB_PVEC_CX.DIR' ,'write','dir',2)
!      call iku_open(file_sor_pos,'SeaFloor_for_3DRT_CoarseDown_varQ.ascii','write','ascii') ! 
      call iku_open(file_sor_pos,'SeaFloor_for_3DRT_CoarseUp_varQ.ascii','write','ascii') ! 
      !call iku_open(file_sor_pos,'SeaFloor_3D_varQ_Olav.ascii','write','ascii') ! 
      !call iku_open(file_sor_pos,'SeaFloor_3D_varyingQ.ascii','write','ascii') ! 
      !call iku_open(file_sor_pos,'SeaFloor_for_2DRT_Dense.ascii','write','ascii') ! 
      !call iku_open(file_sor_pos,'SeaFloor_for_2DRT.ascii','write','ascii') ! 
      !call iku_open(file_sor_pos,'SeaFloor_for_3DRT.ascii','write','ascii') ! 3D
   endif

   !----------------------------------------------------------------------
   !   Open I/O files 
   !   Files are not opened if filename is set to NONE on jobfile
   !----------------------------------------------------------------------  

   !--- Error messages:
   call iku_open(file_err,uname%errmsg,'write','ascii')
   luerr = iku_get_file_unit(file_err)

   !--- Geological model:
   nrecl = gmod%nx*gmod%ny*gmod%nz
   call open_geo_files(files_gmod,flag_gmod,uname%elk, &
                       uname%rho,'read',fio_gmod,nrecl)
      
   !--- Local model and image cube:
   !--- Source/receiver header files:

   !-----------------------------------------------------------------------
   !   Get position and size of Local model and image cube
   !-----------------------------------------------------------------------
   
   !-----------------------------------------------------------------------
   !   Get number of shot positions
   !-----------------------------------------------------------------------   
   
   !-----------------------------------------------------------------------
   !   Memory allocation: Shot independent arrays
   !-----------------------------------------------------------------------   
   
   ls = 0

   !--- Geological model:
   call alloc_geo_mod(gmod,stat=ls)

   !--- Kinetic ray tracing arrays:
   maxray = kini%npol + kini%naz2*kini%npol*(kini%npol-1)/2
   call alloc_kin_sex(ksex   ,kini%maxel,maxray,kini%npol,ls)
   call alloc_kin_sex(ksex_cz,nz_kgrid  ,maxray,kini%npol,ls)
   call alloc_kin_grid(kgrid,maxpat,nx_kgrid,ny_kgrid,nz_kgrid,ls)

   !--- Dynamic ray tracing arrays: NOT STORED AT PRESENT
                                          
   !--- Shot positions: HARD CODED SO FAR

   if (ls.ne.0) then
      write(6,*) 'SUBROUTINE RAY_TRACER: Memory allocation failed. Stop.'
      stop
   end if
   
   !-----------------------------------------------------------------------
   !  Read source positions
   !-----------------------------------------------------------------------

   lsor = iku_get_file_unit(file_sor_pos)

   x0(3) = 0.0 ! Reference for the z-axis
   read(lsor,*) nsor,x0(1),x0(2)
   
   write(6,*)'KH: nsor,x0,y0=',nsor,x0(1),x0(2)
   do j=1,nsor
      !read(lsor,*) (xsor(i,j),i=1,3) ! for only position
      read(lsor,*) (xsor(i,j),i=1,3), qsf(j) ! for position and variable q
   end do

   !-----------------------------------------------------------------------
   !  Read 3D model grid and convert to Love parameters
   !-----------------------------------------------------------------------
 
   ind1st = 3 ! order is (z,x,y) on file
   call read_geo_mod(files_gmod,gmod,flag_gmod,ind1st)
   

   !--- Faking heatflow: This must be changed to use laterally varying q
   !qheat = 35.0   ! Heat flow in mW/m2
   !qheat = 42.0   ! Heat flow in mW/m2
   !gmod%elk(:,:,:,1) = (1.0/qheat)*gmod%elk(:,:,:,1)

   ! Isotropic: gmod%elk(:,:,:,1) = Lam and gmod%elk(:,:,:,2) = Mu
   call convert_geo_mod(gmod,flag_gmod)
   ! Store a copy of Lam without scaling for q in gmod%elk(:,:,:,3)
   ! VP/VS=2 => Lam/Mu = 2 
   if (gmod%nelk == 2) then
      write(lulog,*) 'Store a copy of Lam in elk(:,:,:,3)'
      gmod%elk(:,:,:,3) = gmod%elk(:,:,:,1)
   end if

   !kini.kdir = K_DN ! Shoot down
   kini.kdir = K_UP ! Shoot up

   !-----------------------------------------------------------------
   !  Dump shot independent variables to logfile
   !-----------------------------------------------------------------

   write(lulog,1) ' + RAY TRACING:'
   write(lulog,2) '   - kdir         = ',kini%kdir
   write(lulog,2) '   - kevin        = ',kini%kevin
   write(lulog,2) '   - maxel        = ',kini%maxel
   write(lulog,3) '   - npol , naz2  = ',kini%npol,kini%naz2
   write(lulog,6) '   - apol1, apol2 = ',kini%apol1,kini%apol2
   write(lulog,6) '   - aazi1, aazi2 = ',kini%aazi1,kini%aazi2
   write(lulog,1) ' + RAY DATA ON REGULAR GRID:'
   write(lulog,4) '   - nx,ny,nz    = ',kgrid%nx,kgrid%ny,kgrid%nz
   write(lulog,7) '   - dx,dy,dz    = ',(kgrid%dx(i),i=1,3)
   write(lulog,7) '   - x0,y0,z0    = ',(kgrid%x0(i),i=1,3)
   write(lulog,1) ' + GEOLOGICAL MODEL:'
   write(lulog,2) '   - modpar      = ',gmod%modpar
   write(lulog,2) '   - kasino      = ',gmod%kasino
   write(lulog,2) '   - nelk        = ',gmod%nelk
   write(lulog,4) '   - nx,ny,nz    = ',gmod%nx,gmod%ny,gmod%nz
   write(lulog,7) '   - dx,dy,dz    = ',(gmod%dx(i),i=1,3)
   write(lulog,7) '   - x0,y0,z0    = ',(gmod%x0(i),i=1,3)
   write(lulog,1) ' + RUNGE KUTTA:'
   write(lulog,5) '   - t0          = ',rkpar%t0
   write(lulog,5) '   - t1          = ',rkpar%t1
   write(lulog,8) '   - dtsave      = ',rkpar%dtsave
   write(lulog,8) '   - h0          = ',rkpar%h0
   write(lulog,8) '   - hmin        = ',rkpar%hmin
   write(lulog,8) '   - accur       = ',rkpar%accur
   write(lulog,1) ' + LAGRANGE INTERPOLATION:'
   write(lulog,4) '   - npx,npy,npz = ',gint%npx,gint%npy,gint%npz
   write(lulog,*) '   - lkin        = ',flag_ray%lkin
   write(lulog,*) '   - ldyn1       = ',flag_ray%ldyn1
   write(lulog,*) '   - ldyn2       = ',flag_ray%ldyn2
   write(lulog,*) '   - lmode(1:3)  = ',(flag_ray%lmode(i),i=1,3)
   write(lulog,*) '   - lrho        = ',flag_gmod%lrho
   write(lulog,*) '   - lelk(1:21)  = ',(flag_gmod%lelk(i),i=1,21)

   !-----------------------------------------------------------------------
   !
   !  LOOP OVER COMMON SHOT/RECEIVER/OFFSET GATHERS
   !   
   !-----------------------------------------------------------------------

   !do ishot = is_frst,is_last,is_step
   do ishot = 1,nsor

      !--- For thermal modeling
      kini%xsrc(1) = xsor(1,ishot)
      kini%xsrc(2) = xsor(2,ishot)
      kini%xsrc(3) = xsor(3,ishot)

      !--- Adjust the model for current q
      qscl = 1.0 ! Extra q scale factor
      qheat = qscl*qsf(ishot)
      gmod%elk(:,:,:,1) = gmod%elk(:,:,:,3)/(qheat*qheat)
      gmod%elk(:,:,:,2) = gmod%elk(:,:,:,1)*0.5 ! vp/vs=2 => Lam/Mu=2

      write(6,*) 'KH: ishot,xs,ys,zs,qsf',ishot,(kini%xsrc(i),i=1,3),qsf(ishot)      

      !-----------------------------------------------------------------
      !  Dump shot dependent variables to logfile
      !-----------------------------------------------------------------

      write(lulog,2) ' + SHOT:',ishot

      !-----------------------------------------------------------------
      !  Loop over wave modes
      !-----------------------------------------------------------------

      do kmode1=1,3

         if (flag_ray%lmode(kmode1)) then

            !-----------------------------------------------------------
            !  Wave modes for a complete basis of eigenraytors
            !  of the Christoffel tensor.
            !   * KMODE(1) = Current wave mode
            !   * KMODE(2) = 2nd wave mode
            !   * KMODE(3) = 3rd wave mode
            !-----------------------------------------------------------

            kini%kmode(1) = kmode1
            if     (kmode1.eq.K_QS1) then
               kini%kmode(2) = K_QS2
               kini%kmode(3) = K_QP
            elseif (kmode1.eq.K_QS2) then
               kini%kmode(2) = K_QP
               kini%kmode(3) = K_QS1
            elseif (kmode1.eq.K_QP ) then
               kini%kmode(2) = K_QS1
               kini%kmode(3) = K_QS2
            endif

            write(lulog,4) '   - kmode = ',(kini%kmode(i),i=1,3)
            
            !-----------------------------------------------------------
            !  Ray tracing for current shot position and wave mode
            !   * 1. Kinetic ray tracing (always)
            !   * 2. Dynamic ray tracing (if desired)
            !-----------------------------------------------------------

            call raiuno_2000(ksex,dsex1,dsex2,kini,flag_ray,  &
                             gmod,gint,rkpar,ishot,lulog,luerr)

 !           write(6,2) 'KH: After raiuno_2000: nray = ',ksex%nray

            !-----------------------------------------------------------
            !  Interpolation of extended kinetic system:
            !   * 1. Ray data at constant depth
            !   * 2. Ray data on regular grid
            !-----------------------------------------------------------

 !           call interp_kin_cz(ksex_cz,ksex,kgrid,lulog,luerr)
 !           call interp_kin_xy(kgrid,ksex_cz,ksex,lulog,luerr)

            !-----------------------------------------------------------
            !  Write debugging info
            !-----------------------------------------------------------

            if (ldebug) then
!!$               write(6,1) 'Writing debugging info.'
               call write_debug(ishot,file_ascii,file_npat,             &
                                file_ray_xz ,file_ray_yz ,file_ray_xy,  &
                                file_time_cz,file_time_cy,file_time_cx, &
                                file_pvec_cz,file_pvec_cy,file_pvec_cx, &
                                file_gdiv_cz,file_gdiv_cy,file_gdiv_cx, &
                                ksex,ksex_cz,kgrid)
            end if

            !-----------------------------------------------------------
            !  Output to disk
            !-----------------------------------------------------------


         end if

      end do

 !  end do ! Loop over jx
 !  end do ! Loop over jy

   end do ! Loop over CSG/CRG/COG

   !-----------------------------------------------------------------
   !  Memory deallocation
   !-----------------------------------------------------------------

   !--- Geological model:
   call dealloc_geo_mod(gmod)

   !--- Kinetic ray tracing arrays:
   call dealloc_kin_sex(ksex)
   call dealloc_kin_sex(ksex_cz)
   call dealloc_kin_grid(kgrid)
   
   !--- Dynamic ray tracing arrays: NOT STORED AT PRESENT
                                          
   !--- Shot positions: HARD CODED SO FAR

   !-----------------------------------------------------------------
   !  Close I/O files
   !-----------------------------------------------------------------

   !--- Error messages:
   call iku_close(file_err)

   !--- Geological model:
   call close_geo_files(files_gmod,flag_gmod)

   !--- Local model and image cube:
!!$   call iku_close(file_cube)

   !--- Source/receiver header files:
!!$   call iku_close(file_sor_hd)
!!$   call iku_close(file_rec_hd)

   !----------------------------------------------------------------------
   !   Close files for debugging
   !----------------------------------------------------------------------  

   if (ldebug) then
      call iku_close(file_ascii  )
      call iku_close(file_npat   )
      call iku_close(file_ray_xy )
      call iku_close(file_ray_xz )
      call iku_close(file_ray_yz )
      call iku_close(file_time_cz)
      call iku_close(file_time_cy)
      call iku_close(file_time_cx)
      call iku_close(file_gdiv_cz)
      call iku_close(file_gdiv_cy)
      call iku_close(file_gdiv_cx)
      call iku_close(file_pvec_cz)
      call iku_close(file_pvec_cy)
      call iku_close(file_pvec_cx)
      call iku_close(file_sor_pos)
   endif

1  format(A)
2  format(A,1I6)
3  format(A,2I6)
4  format(A,3I6)
5  format(A,1F10.2)
6  format(A,2F10.2)
7  format(A,3F10.2)
8  format(A,1F10.6)
9  format(A,A)

!-----------------------------------------------------------------------
end subroutine ray_tracer
!-----------------------------------------------------------------------





