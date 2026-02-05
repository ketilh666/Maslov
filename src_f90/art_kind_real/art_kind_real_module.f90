!**************************************************************         
!
!  art_kind_real_module
!
!  Define length of single and double precission real
!
!  Version 1.0
!
!  Modules used       :   none
!
!  Programmed         :   Ketil Hokstad October   1999 
!
!**************************************************************         

module art_kind_real_module

   implicit none

   public  :: kind_real_single,kind_real_double, & ! Parameters
              kr4, kr8                             ! Parameters

   !--- Long  names:
   integer, parameter :: kind_real_single = 4
   integer, parameter :: kind_real_double = 8

   !--- Short names:
   integer, parameter :: kr4 = kind_real_single 
   integer, parameter :: kr8 = kind_real_double 

end module art_kind_real_module
