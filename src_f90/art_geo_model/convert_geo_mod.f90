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

   if     (gmod%modpar.eq.k_thomsen) then

      select case(gmod%kasino)
      case (K_ISO)                           ! Isotropic
         call convert_iso(gmod,flag)
      case (K_TIV)                           ! TIV
         call convert_tiv(gmod,flag)
      case (K_TIH)                           ! TIH
!CUT         call convert_tih(gmod,flag)
      case (K_TIG)                           ! TI general 
!CUT         call convert_tig(gmod,flag)
      case (K_ORV)                           ! Orthorhombic vertical
!CUT         call convert_orv(gmod,flag)
      case (K_ORG)                           ! Orthorhombic general 
!CUT         call convert_org(gmod,flag)
      end select

   elseif (gmod%modpar.eq.k_voigt) then

!CUT      call density_norm(gmod,flag)

   end if

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

   write(6,*) 'CONVERT ISO #@$'

   if (.not.flag%lelk(1)) gmod%elk(:,:,:,1) = 1500.0
   !--- Default: VP/VS = 2:
   if (.not.flag%lelk(2)) gmod%elk(:,:,:,2) = 0.5*gmod%elk(:,:,:,1)
   

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(STATIC,10)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (gmod)                              &
   !$OMP    PRIVATE(ix,iy,iz,rho,vp0,vs0)

   write(6,*) 'nx,ny,nz = ',gmod%nx,gmod%ny,gmod%nz
   write(6,*) 'Min VP=',minval(gmod%elk(:,:,:,1))
   write(6,*) 'Max VP=',maxval(gmod%elk(:,:,:,1))
   write(6,*) 'Min VS=',minval(gmod%elk(:,:,:,2))
   write(6,*) 'Max VS=',maxval(gmod%elk(:,:,:,2))
  
   !--- This is the original loop, for regular seismic ray tracing:
   do iz=1,gmod%nz
      do iy=1,gmod%ny
         do ix=1,gmod%nx
            vp0 = gmod%elk(ix,iy,iz,1)
            vs0 = gmod%elk(ix,iy,iz,2)
            gmod%elk(ix,iy,iz,1) = vp0*vp0 - 2.0*vs0*vs0   ! Lambda
            gmod%elk(ix,iy,iz,2) = vs0*vs0                 ! Mu
         enddo
      end do
   end do

   write(6,*) 'Min Lam/rho=',minval(gmod%elk(:,:,:,1))
   write(6,*) 'Max Lam/rho=',maxval(gmod%elk(:,:,:,1))
   write(6,*) 'Min Mu/rho=',minval(gmod%elk(:,:,:,2))
   write(6,*) 'Max Mu/rho=',maxval(gmod%elk(:,:,:,2))

1  format(3I6,2F8.1)
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


   write(6,*) 'CONVERT TIV #@$'

   if (.not.flag%lelk(1)) gmod%elk(:,:,:,1) = 1500.0
   if (.not.flag%lelk(2)) gmod%elk(:,:,:,2) =  600.0
   if (.not.flag%lelk(3)) gmod%elk(:,:,:,3) =    0.2
   if (.not.flag%lelk(4)) gmod%elk(:,:,:,4) =    0.1
   if (.not.flag%lelk(5)) gmod%elk(:,:,:,5) =    0.05

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(STATIC,10)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (gmod)                              &
   !$OMP    PRIVATE(ix,iy,iz,rho,vp0,vs0,del,          &
   !$OMP            eps,gam,w1,w2,w3)
   do iz=1,gmod%nz
      do iy=1,gmod%ny
         do ix=1,gmod%nx
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

!*********************************************************************
!
!  IKU Seismic subroutine density_norm
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
    
subroutine density_norm(gmod,flag)

   implicit none

   !--- External variables: 
   type(art_geo_mod)  ,intent(inout) :: gmod     ! Elastic model
   type(art_geo_ctrl) ,intent(inout) :: flag

   !--- Internal variables:
   integer   :: ix,iy,iz,ielk

!-----------------------------------------------------------------------
!  Convert velocities and Thomsen parameters to Lame parameters
!-----------------------------------------------------------------------

   if (flag%lrho) then
   
      do ielk=1,gmod%nelk

         !$OMP PARALLEL DO                                   &
         !$OMP    SCHEDULE(STATIC,10)                        &
         !$OMP    DEFAULT(PRIVATE)                           &
         !$OMP    SHARED (gmod)                              &
         !$OMP    PRIVATE(ix,iy,iz)
         do iz=1,gmod%nz
            do iy=1,gmod%ny
               do ix=1,gmod%nz
                  gmod%elk(ix,iy,iz,ielk) = gmod%elk(ix,iy,iz,ielk)/ &
                                            gmod%rho(ix,iy,iz)
               enddo
            end do
         end do
         
      end do

   end if

!-----------------------------------------------------------------------
 end subroutine density_norm
!-----------------------------------------------------------------------








