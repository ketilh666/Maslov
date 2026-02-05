!*********************************************************************         
!
!  IKU Seismic subroutine alloc_kin_sex
!
!  Subroutines called : none
!  Functions called   : none
!
!  Purpose : Initialize kinetic ray tracing data: 
!            Compute initial polar and azimuth angles for each ray.
!
!  Programmed  :   Ketil Hokstad March    2000
!
!**********************************************************************
    
subroutine init_kin_sex(ksex,kini)

   implicit none

   !--- External variables: 
   type(art_kin_sex),intent(inout) :: ksex    ! Kinetic ray data
   type(art_kin_ini),intent(in)    :: kini    ! Initial cond. for kinetic rt

   !--- Internal variables:  
   integer   :: ip,ia,ir
   integer   :: npol,nazi,naz2
   real(krx) :: apol1,apol2,apol,dpol
   real(krx) :: aazi1,aazi2,aazi,dazi

   real(krx) :: dpol0,cosav2
   real(krx) :: cospa1,sinpa1
   real(krx) :: cospa2,sinpa2
   real(krx) :: wrk1,wrk2
   integer   :: iwrk

   !--- Degrees to radians and vice verca:
   real(krx) ,parameter :: pi4 = 3.141592654
   real(krx) ,parameter :: d2r = pi4/180.0
   real(krx) ,parameter :: r2d = 180.0/pi4

   !---------------------------------------------------------
   !  Current wavemode and initial direction (up/down)
   !---------------------------------------------------------

   ksex%kdir  = kini%kdir
   ksex%kmode = kini%kmode(1)

   !---------------------------------------------------------
   !  Initial polar and azimuth angles
   !   * 3D ray tracing constraints:
   !     - At least 3 azimuths
   !     - Azimuth angles in the open set [0,360> deg.
   !     - Polar angles in the closed set [0,90] deg.
   !   * 2D ray tracing constraints:
   !     - Azimuth angle is zero
   !     - Polar angles in the closed set [-90,90] deg.
   !---------------------------------------------------------

   if (kini%naz2 .ge. 3) then
      !--- 3D:
      aazi1 =   0.0
      aazi2 = 360.0
      apol1 =   0.0
      apol2 = real(abs(kini%apol2),kind=krx)
      naz2  = kini%naz2
      npol  = kini%npol
   else
      !--- 2D:
      aazi1 = 0.0
      aazi2 = 0.0
      apol1 = real(kini%apol1,kind=krx)
      apol2 = real(kini%apol2,kind=krx)
      naz2  = 0
      npol  = kini%npol
   endif

   !---------------------------------------------------------
   !   Number of azimuths for each polar angle
   !---------------------------------------------------------

   do ip=1,npol
      ksex%nazi(ip) = max((ip-1)*naz2+jredun,1)
   enddo

   !---------------------------------------------------------
   !  Increment in polar angle:
   !---------------------------------------------------------

   if (ladapt_dpol) then
      !--- Adaptive increment:
      cospa1 = cos(d2r*apol1)
      sinpa1 = sin(d2r*apol1)
      cospa2 = cos(d2r*apol2)
      sinpa2 = sin(d2r*apol2)
      wrk1   = cospa2*sinpa2 - cospa1*sinpa1
      wrk2   = d2r*apol2 - d2r*apol1
      cosav2 = 0.5*(wrk1/wrk2 + 1.0)
   else
      !--- Constant increment:
      cosav2 = 1.0
   endif

   dpol0  = (apol2-apol1)/(real(max(npol-1,1))*cosav2)

   !---------------------------------------------------------
   !  Initial polar and azimuth angles 
   !---------------------------------------------------------

   ir    = 0
   dpol  = 0.0
   apol  = apol1
   do ip=1,npol
      !--- Current polar angle:
      apol = apol + dpol
      !--- Azimuths for current polar angle:
      nazi = ksex%nazi(ip)
      dazi = (aazi2-aazi1)/real(max(nazi-jredun,1))
      do ia=1,nazi
         ir    = ir+1
         aazi  = aazi1 + real(ia-1)*dazi
         ksex%apol(ir) = apol
         ksex%aazi(ir) = aazi
      end do
      !--- Next increment in polar angle:
      if (ladapt_dpol) then
         cospa2 = cos(d2r*apol)*cos(d2r*apol)
      else
         cospa2 = 1.0
      endif
      dpol = dpol0*cospa2
!      write(6,1) 'KH: init: ip,apol,dpol,nazi = ',ip,apol,dpol,nazi
   end do

   !--- Store:
   ksex%nray = ir
   ksex%npol = npol

!   write (6,2) 'KH: init: nray = ',ksex%nray

1  format(A,I5,F7.2,F7.4,I5)
2  format(A,I8)

!-----------------------------------------------------------------------
end subroutine init_kin_sex
!-----------------------------------------------------------------------



