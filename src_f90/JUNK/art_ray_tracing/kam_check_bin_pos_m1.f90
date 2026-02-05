!**********************************************************************
! Sintef Petroleum Research subroutine kam_check_bin_pos_m1
!
! Purpose:
!    Check that bin centers fall on the global grid
! Programmed:
!    Emmanuel Causse, march 2000
! Comments:
!    Bin centers are automatically assigned the position of nodes in
!    the global grid. 
!    When the survey is described in mode m1, then the actual bin centers 
!    are assumed to really be on nodes of the global grid. The bin 
!    centers are defined with the position of the first bin and 
!    increments in the x and y directions.
!    Note: if the survey is described in mode m2, then bin centers 
!    correspond to the nearest nodes from actual bin centers and therefore 
!    still fall on the global grid (but in that case, the deviation from 
!    the actual bin centers is stored for possible interpolations). Then
!    the bins are not described by increments, so, each bin should be 
!    checked separately and another routine for mode m2 must be used. 
!**********************************************************************
subroutine kam_check_bin_pos_m1(grid, pos_bin1, dx, dy, nx, ny, lulog)

implicit none

!-- Declaration of arguments
type(kam_grids),   intent(in) :: grid     ! Global grid
type(vec_3D),      intent(in) :: pos_bin1 ! Position of first bin
real,              intent(in) :: dx, dy   ! Spatial increments of bins
integer,           intent(in) :: nx, ny   ! Number of bins in x and y dir
integer,           intent(in) :: lulog    ! Logical unit for log file

!-- Declaration of local variables
type(vec_3D)     :: sampl          ! sampling of global grid in x, y, z
type(vec_3D)     :: corner         ! corner of global grid
type(intvec_3D)  :: isize          ! size of global grid
real, parameter  :: max_rel_error = 0.001  
real             :: remainder, deltax, deltay, deltaz
real             :: xmin, xmax, ymin, ymax, zmin, zmax
integer          :: ix, iy

!-- Get sampling intervals and corner of global grid
call kam_get_grid_pars(grid, i=1, corner=corner, isize=isize, sampl=sampl)

!-- Check that first and last bins are inside spatial ranges of grid
xmin = min(corner%x, corner%x + isize%x * sampl%x)
xmax = max(corner%x, corner%x + isize%x * sampl%x)
ymin = min(corner%y, corner%y + isize%y * sampl%y)
ymax = max(corner%y, corner%y + isize%y * sampl%y)
zmin = min(corner%z, corner%z + isize%z * sampl%z)
zmax = max(corner%z, corner%z + isize%z * sampl%z)
if (pos_bin1%x < xmin .or. pos_bin1%x > xmax) then
   write(lulog,*) 'ERROR: first bin outside x-range of global grid'
   write(lulog,*) 'xbin, ybin, zbin = ',pos_bin1%x,pos_bin1%y,pos_bin1%z
   write(lulog,*) 'xmin, ymin, zmin = ',xmin, ymin, zmin
   write(lulog,*) 'xmax, ymax, zmax = ',xmax, ymax, zmax
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop   
end if
if (pos_bin1%x +(nx-1)*dx < xmin .or. pos_bin1%x +(nx-1)*dx > xmax) then
   write(lulog,*) 'ERROR: last bin outside x-range of global grid'
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop   
end if
if (pos_bin1%y < ymin .or. pos_bin1%y > ymax) then
   write(lulog,*) 'ERROR: first bin outside y-range of global grid'
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop   
end if
if (pos_bin1%y +(ny-1)*dy < ymin .or. pos_bin1%y + (ny-1)*dy > ymax) then
   write(lulog,*) 'ERROR: last bin outside y-range of global grid'
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop   
end if
if (pos_bin1%z < zmin .or. pos_bin1%z > zmax) then
   write(lulog,*) 'ERROR: first bin outside z-range of global grid'
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop   
end if

!-- Check that bin increments are multiples of the spatial 
!-- sampling lengths in the global grid (or equal to zero)
remainder = dx - sampl%x * nint( dx / sampl%x )
if (nx > 1 .and. abs(remainder) > abs(sampl%x) * max_rel_error) then
   write(lulog,*) 'ERROR: x increment in bin position is not a multiple ',&
                  'of x sampling of global grid'
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop
end if

remainder = dy - sampl%y * nint( dy / sampl%y )
if (ny > 1 .and. abs(remainder) > abs(sampl%y) * max_rel_error) then
   write(lulog,*) 'ERROR: y increment in bin position is not a multiple ',&
                  'of y sampling of global grid'
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop
end if

!-- Check that first bin is on the global grid
deltax = pos_bin1%x - corner%x
remainder = deltax - sampl%x * nint( deltax / sampl%x )
if (abs(remainder) > abs(sampl%x) * max_rel_error) then
   write(lulog,*) 'ERROR: x position of first bin not on x grid '
   write(lulog,*) 'xbin, ybin, zbin = ',pos_bin1%x,pos_bin1%y,pos_bin1%z
   write(lulog,*) 'xcrn, ycrn, zcrn = ',corner%x,corner%y,corner%z
   write(lulog,*) 'dxgd, dygd, dzgd = ',sampl%x,sampl%y,sampl%z
   write(lulog,*) 'deltax,remainder = ',deltax,remainder
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop
end if

deltay = pos_bin1%y - corner%y
remainder = deltay - sampl%y * nint( deltay / sampl%y )
if (abs(remainder) > abs(sampl%y) * max_rel_error) then
   write(lulog,*) 'ERROR: y position of first bin not on y grid '
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop
end if

deltaz = pos_bin1%z - corner%z
remainder = deltaz - sampl%z * nint( deltaz / sampl%z )
if (abs(remainder) > abs(sampl%z) * max_rel_error) then
   write(lulog,*) 'ERROR: z position of first bin not on z grid '
   write(lulog,*) 'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   write(6,*)     'STOP THE PROGRAM from routine kam_check_bin_pos_m1'   
   stop
end if

!----------------------------------------------------------------------
end subroutine kam_check_bin_pos_m1
!----------------------------------------------------------------------

