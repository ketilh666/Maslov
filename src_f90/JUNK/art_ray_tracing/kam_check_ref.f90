!**********************************************************************
! Sintef Petroleum Research subroutine kam_check_ref
!
! Purpose:
!    Check that the reference depth z_ref falls on the global grid
! Programmed:
!    Emmanuel Causse, april 2000
!**********************************************************************
subroutine kam_check_ref(grid, lulog)

implicit none

!-- Declaration of arguments
type(kam_grids),   intent(in) :: grid     ! Global grid
integer,           intent(in) :: lulog    ! Logical unit for log file

!-- Declaration of local variables
type(vec_3D)     :: sampl          ! sampling of global grid in x, y, z
type(vec_3D)     :: corner         ! corner of global grid
type(intvec_3D)  :: isize          ! size of global grid
real, parameter  :: max_rel_error = 0.001  
real             :: remainder, deltaz

!-- Get sampling intervals and corner of global grid
call kam_get_grid_pars(grid, i=1, corner=corner, isize=isize, sampl=sampl)

!-- Check that z_ref is on the global grid
deltaz = z_ref - corner%z
remainder = deltaz - sampl%z * nint( deltaz / sampl%z )
if (abs(remainder) > abs(sampl%z) * max_rel_error) then
   write(lulog,*) 'ERROR: z_ref is not on z grid '
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_ref'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_ref'   
   stop
end if

!----------------------------------------------------------------------
end subroutine kam_check_ref
!----------------------------------------------------------------------
