!**********************************************************************
! Sintef Petroleum Research subroutine check_file_names
!
! Purpose:
!    Check that the file names for the description of survey bins, 
!    illumination windows and model obey to the following rules:
!       * they begin with 'kam_'
!       * they contain the substring describing the input mode
!       * these substrings consist of an 'm', followed by a number (1-9)
!       * the file name for the survey bins must contain the substring 
!         'sor' for source bins and 'rec' for receiver bins,
!         the file name for the illumination windows must contain the 
!         substring 'illum', the file name for the model must contain the
!         substring 'model'.
!    Check that the name of the data base for rays begins with 'kam_'.
!    The different components of the ray fans (traveltime, geom 
!    spread, ...) have names constructed by inserting an extra
!    string to these root names just after the "ID" string 'kam_'...
! Programmed:
!    Emmanuel Causse  December 1999
!    Ketil Hokstad    July     2001
!**********************************************************************
subroutine check_file_names(upars)

implicit none

!-- Declarations of arguments
type(art_user_pars), intent(in)  :: upars   ! user parameters

!-- Declarations of local variables
logical   :: flag_error

!-- Check for description of survey bins
if ( upars%inmode_survey(1:1) /= 'm' .or. &
     index('12',upars%inmode_survey(2:2)) == 0 )  then
   write(6,*) 'ERROR: incorrect input mode ',trim(upars%inmode_survey),  &
              ' for description of survey bins'
   write(6,*) 'STOP THE PROGRAM from routine check_file_names'   
   stop
end if
if ( upars%name_survey_sor_file(1:4) /= 'kam_' .or.                          &
     index(upars%name_survey_sor_file, upars%inmode_survey(1:2)) == 0 .or.   & 
     index(upars%name_survey_sor_file, 'sor') == 0 )  then
   write(6,*) 'ERROR: incorrect file name ',trim(upars%name_survey_sor_file),&
              ' for description of source bins'
   write(6,*) 'STOP THE PROGRAM from routine check_file_names'   
   stop
end if     
    
!-- Check for description of model
if ( upars%inmode_model(1:1) /= 'm' .or. &
     index('123',upars%inmode_model(2:2)) == 0 )  then
   write(6,*) 'ERROR: incorrect input mode ',trim(upars%inmode_model),  &
              ' for description of model'
   write(6,*) 'STOP THE PROGRAM from routine check_file_names'   
   stop
end if
if ( upars%name_model_file(1:4) /= 'kam_' .or.                          &
     index(upars%name_model_file, upars%inmode_model(1:2)) == 0 .or.    &    
     index(upars%name_model_file, 'model') == 0 )  then
   write(6,*) 'ERROR: incorrect file name ',trim(upars%name_model_file),&
              ' for description of model'
   write(6,*) 'STOP THE PROGRAM from routine check_file_names'   
   stop
end if     

!-- Check for root names of data bases for rays
if ( upars%name_ray_sor_P0_data_base(1:4) /= 'kam_' ) then
   write(6,*) 'ERROR: incorrect file name ', & 
              trim(upars%name_ray_sor_P0_data_base),' for ray data base'
   write(6,*) 'STOP THE PROGRAM from routine check_file_names'   
   stop
end if
if ( upars%name_ray_sor_S1_data_base(1:4) /= 'kam_' ) then
   write(6,*) 'ERROR: incorrect file name ', & 
              trim(upars%name_ray_sor_S1_data_base),' for ray data base'
   write(6,*) 'STOP THE PROGRAM from routine check_file_names'   
   stop
end if
if ( upars%name_ray_sor_S2_data_base(1:4) /= 'kam_' ) then
   write(6,*) 'ERROR: incorrect file name ', & 
              trim(upars%name_ray_sor_S2_data_base),' for ray data base'
   write(6,*) 'STOP THE PROGRAM from routine check_file_names'   
   stop
end if
!----------------------------------------------------------------------
end subroutine check_file_names
!----------------------------------------------------------------------



