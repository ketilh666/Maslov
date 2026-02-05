!********************************************************************* !
!  IKU Seismic subroutine interp_kam_xy
!
!
!  Purpose : Interpolate extended kinetic raytracing system on
!            a regular grid for use in migration.
!            The subroutines is adapted to be interfaced with
!            modules and type definitions in the kam software package.
!
!  Subroutines called : interp_kam_2d interp_kam_3d
!                       sort_kin_grid
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!                  Ketil Hokstad August 2001
!
!**********************************************************************
    
subroutine interp_kam_xy(rayfan,ksex_cz,ksex, &
                         isize,corner,sampl,  &
                         lulog,luerr)

   implicit none

   !--- External variables: 
   type(kam_ray_fan) ,intent(inout) :: rayfan   ! Ray fan     
   type(art_kin_sex) ,intent(in)    :: ksex_cz  ! Kinetic data at const. z
   type(art_kin_sex) ,intent(in)    :: ksex     ! Kinetic ray data (raw)
   type(intvec_3D)   ,intent(in)    :: isize    ! Size     of illum grid
   type(vec_3D)      ,intent(in)    :: corner   ! Corner   of illum grid
   type(vec_3D)      ,intent(in)    :: sampl    ! Sampling of illum grid
   integer           ,intent(in)    :: luerr    ! Error message file
   integer           ,intent(in)    :: lulog    ! Log file

   !--- Internal variables:  

   !------------------------------------------------------------------
   !  Interpolate kinetic ray tracing data on a regular grid
   !  Input data must be pre-interpolated to constant depth z.
   !------------------------------------------------------------------
   
   if (ksex_cz%nazi(2) .lt. 3) then
      !--- 2D interpolation
      write(lulog,1) '   - Interpolation #2 (rayfan on grid): 2D'
      write(    6,1) '   - Interpolation #2 (rayfan on grid): 2D'
      call interp_kam_2d(rayfan,ksex_cz,ksex, &
                         isize,corner,sampl,luerr)
   else
      !--- 3D interpolation
      write(lulog,1) '   - Interpolation #2 (rayfan on grid): 3D'
      write(    6,1) '   - Interpolation #2 (rayfan on grid): 3D'
      call interp_kam_3d(rayfan,ksex_cz,ksex, &
                         isize,corner,sampl,luerr)
   endif

1  format(A)
   !------------------------------------------------------------------
   !  Multipathing: Sort on min traveltime or max amplitude etc.
   !------------------------------------------------------------------

   write(6,*) 'interp_kam_xy: Shell sort'
   call sort_kam_grid(rayfan,isize)

!-----------------------------------------------------------------------
 end subroutine interp_kam_xy
!-----------------------------------------------------------------------









