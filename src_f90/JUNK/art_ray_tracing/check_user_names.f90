!**********************************************************************
!
!  Sintef Petroleum Research subroutine check_user_names
!
!  Purpose : Distribute filenames from the jobfile
!            
!  Subroutines called :   none
!  Functions called   :   none
! 
!  Programmed         :   Ketil Hokstad January 2000
!                         Ketil Hokstad July    2001
!     
!**********************************************************************

subroutine  check_user_names(upars,                                 &
                             name_sor_bins_file,name_sor_bins_base, &
                             name_illum_file,name_sor_illum_base,   &
                             name_model_file,name_sor_ray_base,     &
                             name_errmsg)

   implicit none

   !--- External variables: 
   type(art_user_pars) ,intent(in)    :: upars      ! Pars from jobfile
   character(len=*)    ,intent(inout) :: name_sor_bins_file
   character(len=*)    ,intent(inout) :: name_sor_bins_base
   character(len=*)    ,intent(inout) :: name_illum_file
   character(len=*)    ,intent(inout) :: name_sor_illum_base(3)
   character(len=*)    ,intent(inout) :: name_model_file
   character(len=*)    ,intent(inout) :: name_sor_ray_base(3)
   character(len=*)    ,intent(inout) :: name_errmsg

   !--- Internal variables:

   !--- Survey description file:
   name_sor_bins_file = adjustl(upars%name_survey_sor_file)
   name_sor_bins_base = adjustl(upars%name_survey_sor_data_base)

   !--- Illumination grids description file:
   name_illum_file        = adjustl(upars%name_illum_file)
   name_sor_illum_base(1) = adjustl(upars%name_illum_sor_P0_data_base)
   name_sor_illum_base(2) = adjustl(upars%name_illum_sor_S1_data_base)
   name_sor_illum_base(3) = adjustl(upars%name_illum_sor_S2_data_base)

   !--- Geological models description file:
   name_model_file = adjustl(upars%name_model_file)

   !--- Ray data bases:
   name_sor_ray_base(1) = adjustl(upars%name_ray_sor_P0_data_base)
   name_sor_ray_base(2) = adjustl(upars%name_ray_sor_S1_data_base)
   name_sor_ray_base(3) = adjustl(upars%name_ray_sor_S2_data_base)

   !--- Error messages and warnings:
   name_errmsg = adjustl(upars%errmsg)

!-----------------------------------------------------------------------
end subroutine check_user_names
!-----------------------------------------------------------------------
