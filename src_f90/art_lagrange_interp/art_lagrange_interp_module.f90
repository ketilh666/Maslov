!**************************************************************         
!
!  art_lagrange_interp_module
!
!  Type definitions for Lagrange interpolation on 
!  a regular grid.
!
!  The Lagrange intepolation is performed by the 
!  following f77 routines in src_f77/interpol:
!  CARPRE, CARFUN, CARI3D
!
!  References:
!          Kincaid and Cheney (1991): Numerical Analyisis.
!          Mathematics of scientific computing. (Chapter 6)
!          Brooks/Cole publ. Company.
!
!  Version 1.0
!
!  Modules used       :   art_geo_model_inc 
!                         art_kind_real_module
!
!  Programmed         :   Ketil Hokstad November 1999 
!
!**************************************************************         

module art_lagrange_interp_module

   use art_geo_model_inc
   use art_kind_real_module

   implicit none

   public  :: art_lag_int 

   !--- Lagrange interpolation parameters and work arrays:
   !--- The parameter MAXPOL is defined in the f77 include
   !--- file src_f77/include/files/geo_model.inc
   type art_lag_int
      integer   :: npx,npy,npz    ! Degree of interpolating polynomial
      integer   :: lpx,lpy,lpz    ! Left midpoint node
      real(kr4) :: ca(MAXPOL+1,3) ! Precomputed array
      real(kr4) :: da(MAXPOL+1,3) ! Precomputed array
   end type art_lag_int

end module art_lagrange_interp_module
