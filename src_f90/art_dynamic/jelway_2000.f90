!************************************************************************
!
! Subroutine jelway_2000
!
! Purpose: Compute the geometrical spreading from point source dynamic
!          ray tracing result
!          
!
! References: 
!          Cerveny, V., 1995: Elastic wavefields in three-
!          dimensional isotropic and anisotropic structures, 
!          Chapter 4. Lecture notes,University of Trondheim,1995. 
!          John Elway is the QB of Denver Broncos.
!          Superbowl champ 1998 and 1999.
!
! Subroutines called : none
! Functions called   : none
!
! Programmed : Ketil Hokstad          January 1999
!              Sverre Brandsberg-Dahl June    1999
!              Ketil Hokstad          March   2000
!
!************************************************************************

subroutine jelway_2000(ksys,dsys,jr,gsray,kindx)

   implicit none

   !---  External variables:
   type(art_dyn_sys) ,intent(in)  :: dsys          ! Dynamic ray system
   type(art_kin_sys) ,intent(in)  :: ksys          ! Kinetic ray system
   integer           ,intent(in)  :: jr            ! Current ray index
   real(kry)         ,intent(out) :: gsray(:,:,:)  ! Geom. spread.
   integer           ,intent(out) :: kindx(  :,:)  ! KMAH index

   !---  Internal variables:
   integer      ::  k,ind,ind_old
   complex(kry) ::  gdiv
   real(kry)    ::  detq,wrk1,wrk2
   real(kry)    ::  qy(2,2),py(2,2),hy(3,3)
   real(kry)    ::  vgroup,qx(3,3)              ! Dummy variables determinant
   real(kry)    ::  x,z,t,r,ef,vp               ! For debugging

   !-----------------------------------------------------------------------
   !  Initialize
   !-----------------------------------------------------------------------
   
!!$   write(6,*) 'jelway_2000: jr = ',jr
   
   kindx(1:ksys%maxel,jr) = 0
   
   ind     = 0
   ind_old = 0
   
   !-----------------------------------------------------------------------
   !  Compute complex geometrical spreading and KMAH index along the ray:
   !   * Magnitude   in gsray(1,k,jr)
   !   * Phase angle in gsray(2,k,jr)
   !-----------------------------------------------------------------------
   
   !---  Loop over ray elements for current ray:
   
   do k=1,ksys%nel(jr)
      
      !--- Cartesian to ray centered coordinates: (Junk?)
      call HYMAT(hy,ksys%gvray(1,1,k,jr),ECART)
      call GOCRAY(qy,py,2,2,hy,dsys%qxray(1,1,k,jr),      &
                  dsys%pxray(1,1,k,jr),3,2,               &
                  ksys%xray(1,k,jr),ksys%pray(1,k,jr),    &
                  ksys%vgray(1,k,jr),ksys%etray(1,k,jr))

      !--- Group velocity magnitude
      vgroup = sqrt(ksys%vgray(1,k,jr)**2 +               &
                    ksys%vgray(2,k,jr)**2 +               &
                    ksys%vgray(3,k,jr)**2)

      !--- 3x3 Q-matrix in Cartesian coordinates:
      qx(1:3,1) = dsys%qxray(1:3,1,k,jr)
      qx(1:3,2) = dsys%qxray(1:3,2,k,jr)
      qx(1:3,3) = ksys%vgray(1:3,  k,jr)/vgroup
      
      !--- Determinant of th e 3x3 Q-matrix:
      detq = qx(1,1)*(qx(2,2)*qx(3,3)-qx(3,2)*qx(2,3)) -   &
             qx(1,2)*(qx(2,1)*qx(3,3)-qx(3,1)*qx(2,3)) +   &
             qx(1,3)*(qx(2,1)*qx(3,2)-qx(3,1)*qx(2,2)) 

      !--- Geometrical spreading:
      gdiv = sqrt(cmplx(detq, kind=kry))
      wrk1 = abs (gdiv)
      wrk2 = real(gdiv)
      gsray(1,k,jr) = wrk1
      gsray(2,k,jr) = acos(wrk2/wrk1)
      
      !--- KMAH index. The index is MODULO 4 !!!
      if (abs(detq) .gt. 1.0) then
         ind = int(detq/abs(detq))
      else
         ind = -1
      endif
      if (ind+ind_old .eq. 0) then
         kindx(k,jr) = 1
      else
         kindx(k,jr) = 0
      endif
      ind_old=ind
      
   enddo

!!$ 1    format(A,I4,2F8.1,I4,4F8.4)

!-----------------------------------------------------------------------
   end subroutine jelway_2000
!-----------------------------------------------------------------------





