!*********************************************************************         
!
!  IKU Seismic function get_elk
!
!  Purpose : Extract one component of the  geological models
!
!  Programmed  :   Emmanuel Causse, march 2000 
!
!**********************************************************************
function get_elk(gmod,i) 

implicit none

!--- External variables: 
type(art_geo_mod)                        :: gmod       ! Elastic model
integer                                  :: i          ! Component nr  
real, dimension(gmod%nx,gmod%ny,gmod%nz) :: get_elk    ! function result

get_elk = gmod%elk(:,:,:,i)

!-----------------------------------------------------------------------
end function get_elk
!-----------------------------------------------------------------------

