!********************************************************************* 
!
!  IKU Seismic subroutine convert_geo_mod
!
!  Purpose : Convert from velocities and Thomsen parameters to 
!            density-normalized elastic coefficients
!
!  Subroutines called : convert_iso convert_tiv
!  Functions called   : none
!
!  Programmed :  Ketil Hokstad November 1999 
!                Ketil Hokstad January  2000
!
!**********************************************************************
    
subroutine convert_geo_mod(gmod,flag)

   implicit none

   !--- External variables: 
   type(art_geo_mod)  ,intent(inout) :: gmod     ! Elastic model
   type(art_geo_ctrl) ,intent(inout) :: flag

   !--- Internal variables:  

!-----------------------------------------------------------------------
!  Convert velocities and Thomsen parameters to elastic coefficients
!-----------------------------------------------------------------------

   select case(gmod%kasino)
   case (K_ISO)                           ! Isotropic
      call convert_iso(gmod,flag)
   case (K_TIV)                           ! TIV
      call convert_tiv(gmod,flag)
   case (K_TIH)                           ! TIH
!CUT      call convert_tih(gmod,flag)
   case (K_TIG)                           ! TI general 
!CUT      call convert_tig(gmod,flag)
   case (K_ORV)                           ! Orthorhombic vertical
!CUT      call convert_orv(gmod,flag)
   case (K_ORG)                           ! Orthorhombic general 
!CUT      call convert_org(gmod,flag)
   end select

!-----------------------------------------------------------------------
end subroutine convert_geo_mod
!-----------------------------------------------------------------------

!*********************************************************************
!
!  IKU Seismic subroutine convert_iso
!
!  Purpose : Convert from velocities and Thomsen parameters to 
!            density-normalized elastic coefficients
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed :  Ketil Hokstad November 1999 
!                Ketil Hokstad January  2000
!
!**********************************************************************
    
subroutine convert_iso(gmod,flag)

   implicit none

   !--- External variables: 
   type(art_geo_mod)  ,intent(inout) :: gmod     ! Elastic model
   type(art_geo_ctrl) ,intent(inout) :: flag

   !--- Internal variables:
   integer   :: ix,iy,iz
   real(kr4) :: rho,vp0,vs0

!-----------------------------------------------------------------------
!  Convert velocities and Thomsen parameters to Lame parameters
!-----------------------------------------------------------------------

   if (.not.flag%lrho)    gmod%rho          =    1.0
   if (.not.flag%lelk(1)) gmod%elk(:,:,:,1) = 1200.0
   if (.not.flag%lelk(2)) gmod%elk(:,:,:,2) =  600.0
   
   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(STATIC,10)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (gmod)                              &
   !$OMP    PRIVATE(ix,iy,iz,rho,vp0,vs0)
   do iz=1,gmod%nz
      do iy=1,gmod%ny
         do ix=1,gmod%nz
            rho = gmod%rho(ix,iy,iz)
            vp0 = gmod%elk(ix,iy,iz,1)
            vs0 = gmod%elk(ix,iy,iz,2)
            gmod%elk(ix,iy,iz,1) = vp0*vp0 - 2.0*vs0*vs0   ! Lambda
            gmod%elk(ix,iy,iz,2) = vs0*vs0                 ! Mu
         enddo
      end do
   end do

!-----------------------------------------------------------------------
end subroutine convert_iso
!-----------------------------------------------------------------------

!*********************************************************************         
!
!  IKU Seismic subroutine convert_tiv
!
!  Purpose : Convert from velocities and Thomsen parameters to 
!            density-normalized elastic coefficients
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed :  Ketil Hokstad November 1999 
!                Ketil Hokstad January  2000
!
!**********************************************************************
    
subroutine convert_tiv(gmod,flag)

   implicit none

   !--- External variables: 
   type(art_geo_mod)  ,intent(inout) :: gmod     ! Elastic model
   type(art_geo_ctrl) ,intent(inout) :: flag

   !--- Internal variables:
   integer   :: ix,iy,iz
   real(kr4) :: rho,vp0,vs0,del,eps,gam,w1,w2,w3

!-----------------------------------------------------------------------
!  Convert velocities and Thomsen parameters to Love parameters
!-----------------------------------------------------------------------

!!$   if (.not.flag%lrho)    gmod%rho          =    1.0
!!$   if (.not.flag%lelk(1)) gmod%elk(:,:,:,1) = 1200.0
!!$   if (.not.flag%lelk(2)) gmod%elk(:,:,:,2) =  600.0
!!$   if (.not.flag%lelk(3)) gmod%elk(:,:,:,3) =    0.2
!!$   if (.not.flag%lelk(4)) gmod%elk(:,:,:,4) =    0.1
!!$   if (.not.flag%lelk(5)) gmod%elk(:,:,:,5) =    0.05
   if (.not.flag%lrho)    gmod%rho          =    1.0
   if (.not.flag%lelk(1)) gmod%elk(:,:,:,1) = 2000.0
   if (.not.flag%lelk(2)) gmod%elk(:,:,:,2) = 1000.0
   if (.not.flag%lelk(3)) gmod%elk(:,:,:,3) =    0.2
   if (.not.flag%lelk(4)) gmod%elk(:,:,:,4) =    0.1
   if (.not.flag%lelk(5)) gmod%elk(:,:,:,5) =    0.05

   write(6,*) 'Convert geo model: center of model:'
   ix = gmod%nx/2+1
   iy = 1
   do iz=1,gmod%nz,10
      write(6,1) 'iz,rho,vp0,vs0,del,eps,gam=', &
           iz,gmod%rho(ix,iy,iz), &
           gmod%elk(ix,iy,iz,1) , &
           gmod%elk(ix,iy,iz,2) , &
           gmod%elk(ix,iy,iz,3) , &
           gmod%elk(ix,iy,iz,4) , &
           gmod%elk(ix,iy,iz,5)
   enddo
1  format(A,I6,F8.3,2F8.1,3F8.3)

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(STATIC,10)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (gmod)                              &
   !$OMP    PRIVATE(ix,iy,iz,rho,vp0,vs0,del,          &
   !$OMP            eps,gam,w1,w2,w3)
   do iz=1,gmod%nz
      do iy=1,gmod%ny
         do ix=1,gmod%nx
            rho = gmod%rho(ix,iy,iz)
            vp0 = gmod%elk(ix,iy,iz,1)
            vs0 = gmod%elk(ix,iy,iz,2)
            del = gmod%elk(ix,iy,iz,3)
            eps = gmod%elk(ix,iy,iz,4)
            gam = gmod%elk(ix,iy,iz,5)
            w1  = vp0*vp0 
            w2  = vs0*vs0
            w3  = sqrt(2.0*w1*(w1-w2)*del + (w1-w2)*(w1-w2))
            gmod%elk(ix,iy,iz,1) =  w1*(1.0+2.0*eps)          ! C11=A
            gmod%elk(ix,iy,iz,2) =  w1                        ! C33=C
            gmod%elk(ix,iy,iz,3) =  w3-w2                     ! C13=F
            gmod%elk(ix,iy,iz,4) =  w2                        ! C44=L
            gmod%elk(ix,iy,iz,5) =  w2*(1.0+2.0*gam)          ! C55=N
         enddo
      end do
   end do

!-----------------------------------------------------------------------
end subroutine convert_tiv
!-----------------------------------------------------------------------
