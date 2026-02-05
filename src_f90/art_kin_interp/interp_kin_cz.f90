!********************************************************************* !
!  IKU Seismic subroutine interp_kin_cz
!
!
!  Purpose : Interpolate extended kinetic raytracing system to 
!            constant depth.
!
!  Subroutines called : klimz_cz
!                 f77 : SPLINE SPLINT
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad January  2000
!
!**********************************************************************
    
subroutine interp_kin_cz(ksex_cz,ksex,kgrid,lulog,luerr)

   implicit none

   !--- External variables: 
   type(art_kin_sex) ,intent(inout) :: ksex_cz  ! Kinetic data at const. z
   type(art_kin_sex) ,intent(in)    :: ksex     ! Kinetic ray data (raw)
   type(art_kin_grid),intent(in)    :: kgrid    ! Kinetic ray data on grid
   integer           ,intent(in)    :: luerr    ! Error message file
   integer           ,intent(in)    :: lulog    ! Log file

   !--- Internal variables:  
   integer   :: ic,ir,k,iz
   integer   :: nspl,k1,k2,nzint,nel,nzmax
   integer   :: kdir
   integer   :: ls
   real(kr4) :: z1,z2,dzint
   real(kr4) :: der1,der2,wrk

   !--- Work arrays:
   integer, parameter :: ndim=1001
   real(kr4)          :: rnode(ndim),rknot(ndim),deriv(ndim)
   real(kr4)          :: zint(ndim)

   !---------------------------------------------------------
   !   Initialize
   !---------------------------------------------------------
   
   ksex_cz%kdir  = ksex%kdir
   ksex_cz%kmode = ksex%kmode
   ksex_cz%nray  = ksex%nray
   ksex_cz%npol  = ksex%npol
   ksex_cz%nazi  = ksex%nazi
   ksex_cz%apol  = ksex%apol
   ksex_cz%aazi  = ksex%aazi

   !---------------------------------------------------------
   !   Output depth levels
   !---------------------------------------------------------
   
!!$   write(6,*) 'SUBROUTINE: interp_kin_cz'
   
   nzmax = min(kgrid%nz,ksex_cz%maxel)
   dzint = real(kgrid%dx(3),kind=kr4)
   z1    = real(kgrid%x0(3),kind=kr4)
   z2    = z1 + real(nzmax-1)*dzint

   do iz=1,nzmax
      zint(iz) = z1 + real(iz-1,kind=kr4)*dzint
   end do
   
   !---------------------------------------------------------
   !   write to log file
   !---------------------------------------------------------

   write(lulog,1) '   - Interpolation #1 (const. depth): nz = ',nzmax
   write(    6,1) '   - Interpolation #1 (const. depth): nz = ',nzmax
1  format(A,I4)

   !---------------------------------------------------------
   !   Loop over initial angles
   !---------------------------------------------------------

   !--- End point derivatives of spline:
   der1  = 0.0
   der2  = 0.0

!!$   write(6,*) ' * Paralell loop:'

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(DYNAMIC,1)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (ksex,ksex_cz,zint,                 &
   !$OMP            z1,z2,dzint,der1,der2)             &
   !$OMP    PRIVATE(ir,nel,k1,k2,nzint,rnode,          &
   !$OMP            rknot,deriv,nspl,ic,iz,wrk)
   do ir=1,ksex_cz%nray

!!$         write(6,*) '   - ir = ',ir

      !---------------------------------------------------------
      !   Find the ray nodes above z1 and below z2
      !---------------------------------------------------------
      
      nel = ksex%nel(ir)
      rnode(1:nel) = real(ksex%xray(3,1:nel,ir),kind=kr4)
      call klimz_cz(k1,k2,nzint,z1,z2,dzint,rnode,nel,ksex%kdir)
      
      k2    = min(k2,k1+ndim-1)
      
      ksex_cz%nel(ir) = nzint
      
      !---------------------------------------------------------
      !   Array of nodes
      !---------------------------------------------------------
      
      nspl = k2-k1+1
      rnode(1:nspl) = real(ksex%xray(3,k1:k2,ir),kind=kr4)
      
!!$         write(6,*) '   + ir,k1,k2,nspl= ',ir,k1,k2,nspl
      
      !---------------------------------------------------------
      !   Interpolate traveltimes
      !---------------------------------------------------------
      
      rknot(1:nspl) = real(ksex%time(k1:k2,ir),kind=kr4)
      
      call SPLINE(rnode,rknot,nspl,der1,der2,deriv)
      do iz=1,nzint
         call SPLINT(rnode,rknot,deriv,nspl,zint(iz),wrk)
         ksex_cz%time(iz,ir) = real(wrk,kind=krx)
      end do
      
      !---------------------------------------------------------
      !   Interpolate geometrical spreading
      !   NB! INTERPOLATION OF KMAH INDEX IS NOT YET COMPLETE
      !---------------------------------------------------------
      
      rknot(1:nspl) = real(ksex%gdiv(1,k1:k2,ir),kind=kr4)
      call SPLINE(rnode,rknot,nspl,der1,der2,deriv)
      do iz=1,nzint
         call SPLINT(rnode,rknot,deriv,nspl,zint(iz),wrk)
         ksex_cz%gdiv(1,iz,ir) = real(wrk,kind=krx)
         ksex_cz%gdiv(2,iz,ir) = real(0.0,kind=krx)
         ksex_cz%kmah(iz,ir)   = ksex%kmah(k1,ir) 
      end do
      
      !---------------------------------------------------------
      !   Ray positions
      !---------------------------------------------------------
      
      do ic=1,2
         rknot(1:nspl) = real(ksex%xray(ic,k1:k2,ir),kind=kr4)
         call SPLINE(rnode,rknot,nspl,der1,der2,deriv)
         do iz=1,nzint
            call SPLINT(rnode,rknot,deriv,nspl,zint(iz),wrk)
            ksex_cz%xray(ic,iz,ir) = real(wrk,kind=krx)
         end do
      end do
      
!!$         write(6,*) 'X,T = ',ksex_cz%xray(1,6,ir),ksex_cz%time(6,ir)
      
      ic=3
      do iz=1,nzint
         ksex_cz%xray(ic,iz,ir) = real(zint(iz),kind=krx)
      end do
      
      !---------------------------------------------------------
      !   Ray slowness
      !---------------------------------------------------------
      
      do ic=1,3
         rknot(1:nspl) = real(ksex%pray(ic,k1:k2,ir),kind=kr4)
         call SPLINE(rnode,rknot,nspl,der1,der2,deriv)
         do iz=1,nzint
            call SPLINT(rnode,rknot,deriv,nspl,zint(iz),wrk)
            ksex_cz%pray(ic,iz,ir) = real(wrk,kind=krx)
         end do
      end do
      
      !---------------------------------------------------------
      !   Ray polarization
      !---------------------------------------------------------
      
      do ic=1,3
         rknot(1:nspl) = real(ksex%gray(ic,k1:k2,ir),kind=kr4)
         call SPLINE(rnode,rknot,nspl,der1,der2,deriv)
         do iz=1,nzint
            call SPLINT(rnode,rknot,deriv,nspl,zint(iz),wrk)
            ksex_cz%gray(ic,iz,ir) = real(wrk,kind=krx)
         end do
      end do
      
   end do
   
!-----------------------------------------------------------------------
 end subroutine interp_kin_cz
!-----------------------------------------------------------------------


!*********************************************************************  !
!  IKU Seismic subroutine klimz_cz
!
!
!  Purpose : Get upper and lower depths to be used in
!            spline interpolation to constant depth
!
!  Programmed  :   Ketil Hokstad January  2000
!
!**********************************************************************
    
subroutine klimz_cz(k1,k2,nzint,z1,z2,dzint,zray,mel,kdir)

   implicit none

   !--- External variables: 
   integer   ,intent(out)   :: k1,k2
   integer   ,intent(out)   :: nzint
   real(kr4) ,intent(in)    :: z1,z2,dzint  
   integer   ,intent(in)    :: mel
   real(kr4) ,intent(in)    :: zray(mel)
   integer   ,intent(in)    :: kdir

   !--- Internal variables:  
   integer  :: k
   logical  :: lgot1,lgot2
   logical  :: lturn,ltest

   !---------------------------------------------------------
   !   Find the ray nodes above z1 and below z2
   !---------------------------------------------------------
        
   k1    = mel
   k2    = mel
   lgot1 = .false.
   lgot2 = .false.

   if    (kdir .eq. K_DN) then

      !--- Find nearest ray node above z1:
      do k=1,mel-1
         ltest = zray(k) .le. z1 .and. zray(k+1) .gt. z1
         if (ltest) then
            k1    = k
            lgot1 = .true.
            exit
         end if
      end do

      !--- Find nearest ray node below z2:
      do k=k1+1,mel-1
         lturn = (zray(k)-zray(k-1))*(zray(k+1)-zray(k)) .lt. 0.0
         if (lturn) then
            k2 = k
            exit
         end if
         ltest = zray(k-1) .lt. z2 .and. zray(k) .ge. z2
         if (ltest) then
            k2    = k
            lgot2 = .true.
            exit
         end if
      end do

      !--- Number of depth levels that can be interpolated:
      if     (lgot1 .and. lgot2) then
         nzint = 1+int((z2-z1)/dzint)
      elseif (lgot1) then
         nzint = 1+int((zray(k2)-z1)/dzint)
      else
         nzint = 0
      end if

   elseif(kdir .eq. K_UP) then
      write(6,*) 'SUBROUTINE KLIMZ_CZ: KDIR=K_UP NOT YET IMPLEMENTED'
      stop
   endif


!-----------------------------------------------------------------------
 end subroutine klimz_cz
!-----------------------------------------------------------------------





