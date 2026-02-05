!********************************************************************* !
!  IKU Seismic subroutine alloc_kin_grid
!
!
!  Purpose : Allocate memeory for kinetic ray data on a regular grid.
!
!  Programmed  :   Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine alloc_kin_grid(kgrid,maxpat,nx,ny,nz,stat)

   implicit none

   !--- External variables: 
   type(art_kin_grid),intent(inout) :: kgrid    ! Kinetic rays on grid
   integer           ,optional      :: maxpat   ! Max multipahing order
   integer           ,optional      :: nx,ny,nz ! Grid size
   integer           ,optional      :: stat     ! Status variable

   !--- Internal variables:  
   integer        ::  ls
   integer        ::  mpat,mx,my,mz

   !----------------------------------------------------------
   !   Check for optional parameters
   !----------------------------------------------------------

   if (present(maxpat)) then
      mpat         = maxpat
      kgrid%maxpat = maxpat
   else
      mpat         = kgrid%maxpat
   end if

   if (present(nx)) then
      mx       = nx
      kgrid%nx = nx
   else
      mx       = kgrid%nx
   end if

   if (present(ny)) then
      my       = ny
      kgrid%ny = ny
   else
      my       = kgrid%ny
   end if

   if (present(nz)) then
      mz       = nz
      kgrid%nz = nz
   else
      mz       = kgrid%nz
   end if

   !---------------------------------------------------------
   !   Allocate memeory to pointers in type art_kin_grid
   !---------------------------------------------------------

   allocate ( kgrid%npat(           1:mx,1:my,1:mz), &
              kgrid%time(    1:mpat,1:mx,1:my,1:mz), &
              kgrid%kmah(    1:mpat,1:mx,1:my,1:mz), &
              kgrid%gdiv(1:2,1:mpat,1:mx,1:my,1:mz), &
              kgrid%xrec(1:3,1:mpat,1:mx,1:my,1:mz), &
              kgrid%prec(1:3,1:mpat,1:mx,1:my,1:mz), &
              kgrid%grec(1:3,1:mpat,1:mx,1:my,1:mz), stat=ls)

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine alloc_kin_grid
!-----------------------------------------------------------------------

!*********************************************************************!
!  IKU Seismic subroutine dealloc_kin_grid
!
!
!  Purpose : Allocate memeory for kinetic ray data on a regular grid.
!
!  Programmed  :   Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine dealloc_kin_grid(kgrid,stat)

   implicit none

   !--- External variables: 
   type(art_kin_grid),intent(inout) :: kgrid   ! Kinetic rays on grid
   integer           ,optional      :: stat    ! Status variable

   !--- Internal variables:  
   integer        ::  ls

   !---------------------------------------------------------
   !  Deallocate memeory to pointers in type art_kin_grid
   !---------------------------------------------------------

   deallocate ( kgrid%npat,   &
                kgrid%time,   &
                kgrid%gdiv,   &
                kgrid%kmah,   &
                kgrid%xrec,   &
                kgrid%prec,   &
                kgrid%grec, stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine dealloc_kin_grid
!-----------------------------------------------------------------------


