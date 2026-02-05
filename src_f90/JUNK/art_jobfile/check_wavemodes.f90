!**********************************************************************
! Sintef Petroleum Research subroutine kam_check_wavemodes
!
! Purpose:
!    Check that the names of the wavemodes are correctly read from the
!    jobfile, and return the number of wave modes for imaging, the wave
!    modes for ray tracing and the number of these wave modes.
! Programmed:
!    Emmanuel Causse  December 1999
!    Ketil Hokstad    July 2001
!
!**********************************************************************
subroutine check_wavemodes(upars)

  implicit none

  !-- Declarations of arguments
  type(art_user_pars), intent(inout)  :: upars   ! user parameters
  
  !-- Declarations of local variables
  integer   :: i, istop, Nmod
  logical   :: flag_error
  
  !-- Number of wave modes for imaging
  Nmod=0
  do i = 1, 3
     if (len_trim(upars%wavemode(i)) /= 0) then
        Nmod = Nmod +1
     end if
  end do
  if (Nmod==0) then
     write(6,*) 'ERROR in subroutine check_wavemodes: the number of wave' 
     write(6,*) 'modes for ray tracing is equal to zero'
     write(6,*) 'STOP the program'
     stop
  end if
    
  !-- Check syntax for definition of modes
  flag_error = .false.
  do i=1,Nmod
     if ( ( upars%wavemode(i)(1:2) /= 'P0' .and.          &
            upars%wavemode(i)(1:2) /= 'S1' .and.          &
            upars%wavemode(i)(1:2) /= 'S2'       ) ) then
        flag_error = .true.
        istop      = i
     end if
  end do
  if (flag_error) then
     write(6,*) 'ERROR: incorrect syntax for definition of wave modes '
     write(6,*) 'Wave mode nr ',istop,' is incorrect: ',&
                 upars%wavemode(istop)(1:2)
     write(6,*) 'Check agreement with the reading format'
     write(6,*) 'STOP THE PROGRAM from routine check_wavemodes'   
     write(6,*) 
     write(6,*) 'Example of correct syntax: P0 S1 S2'
     stop
  end if
    
  !-- Wave modes from sources
  upars%N_wmod_sor = Nmod
  do i=1,Nmod
     upars%wmod_sor(i) = upars%wavemode(i)(1:2)
  end do
    
!----------------------------------------------------------------------
end subroutine check_wavemodes
!----------------------------------------------------------------------




