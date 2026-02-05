!*********************************************************************         
!
!  IKU Seismic subroutine alloc_geo_mod
!
!  Purpose : Allocate memory for elastic model on a regular grid.
!
!  Programmed  :   Ketil Hokstad November 1999 
!  Modified    :   Emmanuel Causse, march 2000 (old version stored
!                  in file alloc_geo_mode.f90.290300). I introduced
!                  the extra optional parameter flag. If this is 
!                  present, the allocation will be done using flag 
!                  rather than nelk. In not present, the routine 
!                  works like before
!                  Emmanuel Causse, april 2000: the allocated arrays
!                  are initialized with zero just after allocation.
!**********************************************************************
    
subroutine alloc_geo_mod(gmod,nx,ny,nz,nelk,stat,flag)

   implicit none

   !--- External variables: 
   type(art_geo_mod),intent(inout) :: gmod     ! Elastic model
   integer          ,optional      :: nx,ny,nz ! Model size
   integer          ,optional      :: nelk     ! No of elastic coeff.
   integer          ,optional      :: stat     ! Status variable
   type(art_geo_ctrl),intent(in), optional :: flag ! flag

   !--- Internal variables:  
   integer        ::  ls, ls0
   integer        ::  mx,my,mz,melk,ielk, melk_alloc
   integer, parameter :: nelkmax = 21

   !----------------------------------------------------------
   !   Check for optional parameters
   !----------------------------------------------------------

   if (present(nelk)) then
      melk         = nelk
      gmod%nelk    = nelk
   else
      melk         = gmod%nelk
   end if

   if (present(nx)) then
      mx         = nx
      gmod%nx    = nx
   else
      mx         = gmod%nx
   end if

   if (present(ny)) then
      my         = ny
      gmod%ny    = ny
   else
      my         = gmod%ny
   end if

   if (present(nz)) then
      mz         = nz
      gmod%nz    = nz
   else
      mz         = gmod%nz
   end if

   if (melk == 2) then
      melk_alloc = 3
   else
      melk_alloc = melk
   end if

   write(6,*) 'KH:alloc_geo: melk_alloc = ',melk_alloc

   !---------------------------------------------------------
   !   Allocate memory to pointers in type art_geo_mod
   !---------------------------------------------------------

   if (present(flag)) then
      ls = 0
      do ielk = 1, nelkmax
         if (flag%lelk(ielk)) then
            allocate (gmod%elk(1:mx,1:my,1:mz,ielk), stat=ls0)
            gmod%elk(1:mx,1:my,1:mz,ielk) = 0.
            ls = ls + ls0
         end if
      end do
      if (flag%lrho) then
         allocate (gmod%rho(1:mx,1:my,1:mz), stat=ls0)
         gmod%rho(1:mx,1:my,1:mz) = 1.
         ls = ls + ls0
      end if
   else 
      allocate ( gmod%elk(1:mx,1:my,1:mz,1:melk_alloc), &
                 gmod%rho(1:mx,1:my,1:mz       ), stat=ls )
      gmod%elk(1:mx,1:my,1:mz,1:melk_alloc) = 0.
      gmod%rho(1:mx,1:my,1:mz)        = 1.
   end if
   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine alloc_geo_mod
!-----------------------------------------------------------------------

!*********************************************************************         
!
!  IKU Seismic subroutine dealloc_geo_mod
!
!
!  Purpose : Deallocate memeory for elastic model on a regular grid.
!
!  Programmed  :   Ketil Hokstad November 1999 
!
!**********************************************************************
    
subroutine dealloc_geo_mod(gmod,stat)

   implicit none

   !--- External variables: 
   type(art_geo_mod),intent(inout) :: gmod     ! Elastic model
   integer          ,optional      :: stat     ! Status variable

   !--- Internal variables:  
   integer        ::  ls

   !---------------------------------------------------------
   !  Deallocate memeory to pointers in type art_geo_mod
   !---------------------------------------------------------

   deallocate ( gmod%elk, &
                gmod%rho, stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine dealloc_geo_mod
!-----------------------------------------------------------------------


