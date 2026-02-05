!********************************************************************* 
!
!  IKU Seismic subroutine sort_kin_grid
!
!
!  Purpose : Sort kinetic data on grid in the case of multipathing.
!            The ray data are sorted on min traveltime,
!            max amplitude or none.
!            
!  Subroutines called : none
!                 f77 : SHELLA SHELLD
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!
!**********************************************************************
    
subroutine sort_kin_grid(kgrid)

   implicit none

   !--- External variables: 
   type(art_kin_grid),intent(inout) :: kgrid   ! Kinetic ray data on grid

   !--- Internal variables: 
   integer ,parameter :: maxsrt = 11
   integer            :: isort( maxsrt)        ! Sort index array
   real(krx)          :: rsort( maxsrt)        ! Sort work array
   real(krx)          :: time(  maxsrt)        ! Permutation work array
   integer            :: kmah(  maxsrt)        ! Permutation work array
   real(krx)          :: gdiv(2,maxsrt)        ! Permutation work array
   real(krx)          :: xrec(3,maxsrt)        ! Permutation work array
   real(krx)          :: prec(3,maxsrt)        ! Permutation work array
   real(krx)          :: grec(3,maxsrt)        ! Permutation work array
   integer            :: kp,mp,ix,iy,iz,npat

   !-------------------------------------------------------------------
   !  Sort kinetic raytracing data
   !-------------------------------------------------------------------

   !$OMP PARALLEL DO                                   &
   !$OMP    SCHEDULE(DYNAMIC,1)                        &
   !$OMP    DEFAULT(PRIVATE)                           &
   !$OMP    SHARED (kgrid)                             &
   !$OMP    PRIVATE(kp,mp,ix,iy,iz,npat,isort,rsort,   &
   !$OMP            time,kmah,gdiv,xrec,prec,grec)
   do iz=1,kgrid%nz
      do iy=1,kgrid%ny
         do ix=1,kgrid%nx

            npat = min(kgrid%npat(ix,iy,iz),maxsrt)

            !--- Set up index array for permutations:
            if     (kgrid%ksort .eq. k_min_time) then
               do kp=1,npat
                  rsort(kp) = kgrid%time(kp,ix,iy,iz)
               enddo
               call SHELLA(npat,rsort,isort)
            elseif (kgrid%ksort .eq. k_max_amp ) then
               do kp=1,npat
                  rsort(kp) = kgrid%gdiv(1,kp,ix,iy,iz)
               enddo
               call SHELLD(npat,rsort,isort)
            else
               do kp=1,npat
                  isort(kp) = kp
                  rsort(kp) = 0.0
               end do
            endif

            !--- Store current order:
            do kp=1,npat
               time(    kp) = kgrid%time(    kp,ix,iy,iz)
               kmah(    kp) = kgrid%kmah(    kp,ix,iy,iz)
               gdiv(1:2,kp) = kgrid%gdiv(1:2,kp,ix,iy,iz)
               xrec(1:3,kp) = kgrid%xrec(1:3,kp,ix,iy,iz)
               prec(1:3,kp) = kgrid%prec(1:3,kp,ix,iy,iz)
               grec(1:3,kp) = kgrid%grec(1:3,kp,ix,iy,iz)
            enddo

            !--- Reorder:
            do kp=1,npat
               mp = isort(kp)
               kgrid%time(    kp,ix,iy,iz) = time(    mp)
               kgrid%kmah(    kp,ix,iy,iz) = kmah(    mp)
               kgrid%gdiv(1:2,kp,ix,iy,iz) = gdiv(1:2,mp)
               kgrid%xrec(1:3,kp,ix,iy,iz) = xrec(1:3,mp)
               kgrid%prec(1:3,kp,ix,iy,iz) = prec(1:3,mp)
               kgrid%grec(1:3,kp,ix,iy,iz) = grec(1:3,mp)
            enddo

         end do
      end do
   end do

!-----------------------------------------------------------------------
 end subroutine sort_kin_grid
!-----------------------------------------------------------------------





