!*********************************************************************         
!
!  IKU Seismic subroutine alloc_kin_sex
!
!
!  Purpose : Allocate memeory for extended kinetic raytracing system.
!            Extended means that geometrical spreading is included.
!
!  Programmed  :   Ketil Hokstad October  1999 
!                  Ketil Hokstad November 1999 
!                  Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine alloc_kin_sex(ksex,maxel,maxray,maxpol,stat)

   implicit none

   !--- External variables: 
   type(art_kin_sex),intent(inout) :: ksex    ! Kinetic ray data
   integer          ,optional      :: maxel   ! Max no of ray elements
   integer          ,optional      :: maxray  ! Max no of rays
   integer          ,optional      :: maxpol  ! No of Polar angles
   integer          ,optional      :: stat    ! Status variable

   !--- Internal variables:  
   integer        ::  ls
   integer        ::  mel,mray,mapol

   !----------------------------------------------------------
   !   Check for optional parameters
   !----------------------------------------------------------

   if (present(maxel)) then
      mel        = maxel
      ksex%maxel = maxel
   else
      mel        = ksex%maxel
   end if

   if (present(maxray)) then
      mray        = maxray
      ksex%maxray = maxray
   else
      mray        = ksex%maxray
   end if

   if (present(maxpol)) then
      mapol       = maxpol
      ksex%npol   = maxpol
   else
      mapol       = mray
   end if

   !---------------------------------------------------------
   !   Allocate memeory to pointers in type art_kin_sex
   !---------------------------------------------------------

   allocate ( ksex%nazi(        1:mapol), &    
              ksex%nel (          1:mray), &
              ksex%apol(          1:mray), &
              ksex%aazi(          1:mray), &
              ksex%time(    1:mel,1:mray), &
              ksex%kmah(    1:mel,1:mray), &
              ksex%gdiv(1:2,1:mel,1:mray), &
              ksex%xray(1:3,1:mel,1:mray), &
              ksex%pray(1:3,1:mel,1:mray), &
              ksex%gray(1:3,1:mel,1:mray), stat=ls)

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine alloc_kin_sex
!-----------------------------------------------------------------------

!*********************************************************************         
!
!  IKU Seismic subroutine dealloc_kin_sex
!
!  Purpose : Deallocate memeory for extended kinetic raytracing system.
!            Extended means that geometrical spreading is included.
!
!  Programmed  :   Ketil Hokstad October  1999 
!                  Ketil Hokstad November 1999 
!                  Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine dealloc_kin_sex(ksex,stat)

   implicit none

   !--- External variables: 
   type(art_kin_sex),intent(inout) :: ksex    ! Kinetic ray data
   integer          ,optional      :: stat    ! Status variable

   !--- Internal variables:  
   integer        ::  ls

   !---------------------------------------------------------
   !  Deallocate memeory to pointers in type art_kin_sex
   !---------------------------------------------------------

   deallocate ( ksex%nazi, &
                ksex%nel  , &
                ksex%apol , &
                ksex%aazi , &
                ksex%time , &
                ksex%kmah , &
                ksex%gdiv , &
                ksex%xray , &
                ksex%pray , &
                ksex%gray , stat=ls )

   if(present(stat)) stat=ls

!-----------------------------------------------------------------------
end subroutine dealloc_kin_sex
!-----------------------------------------------------------------------


