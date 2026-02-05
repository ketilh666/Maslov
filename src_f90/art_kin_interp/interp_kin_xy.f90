!********************************************************************* !
!  IKU Seismic subroutine interp_kin_xy
!
!
!  Purpose : Interpolate extended kinetic raytracing system on
!            a regular grid
!
!  Subroutines called : interp_kin_2d interp_kin_3d
!                       sort_kin_grid
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!
!**********************************************************************
    
subroutine interp_kin_xy(kgrid,ksex_cz,ksex,lulog,luerr)

   implicit none

   !--- External variables: 
   type(art_kin_grid),intent(inout) :: kgrid    ! Kinetic ray data on grid
   type(art_kin_sex) ,intent(in)    :: ksex_cz  ! Kinetic data at const. z
   type(art_kin_sex) ,intent(in)    :: ksex     ! Kinetic ray data (raw)
   integer           ,intent(in)    :: luerr    ! Error message file
   integer           ,intent(in)    :: lulog    ! Log file

   !--- Internal variables:  

   !------------------------------------------------------------------
   !  Interpolate kinetic ray tracing data on a regular grid
   !  Input data must be pre-interpolated to constant depth z.
   !------------------------------------------------------------------
   
   if (ksex_cz%nazi(2) .lt. 3) then
      !--- 2D interpolation
      write(lulog,1) '   - Interpolation #2 (regular grid): 2D'
      write(    6,1) '   - Interpolation #2 (regular grid): 2D'
      call interp_kin_2d(kgrid,ksex_cz,ksex,luerr)
   else
      !--- 3D interpolation
      write(lulog,1) '   - Interpolation #2 (regular grid): 3D'
      write(    6,1) '   - Interpolation #2 (regular grid): 3D'
      call interp_kin_3d(kgrid,ksex_cz,ksex,luerr)
   endif

1  format(A)
   !------------------------------------------------------------------
   !  Multipathing: Sort on min traveltime or max amplitude etc.
   !------------------------------------------------------------------

   write(6,*) 'interp_kin_xy: Shell sort'
   call sort_kin_grid(kgrid)

!-----------------------------------------------------------------------
 end subroutine interp_kin_xy
!-----------------------------------------------------------------------


